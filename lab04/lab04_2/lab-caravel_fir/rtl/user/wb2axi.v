// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype wire
/*
 *-------------------------------------------------------------
 *
 * user_proj_example
 *
 * This is an example of a (trivially simple) user project,
 * showing how the user project can connect to the logic
 * analyzer, the wishbone bus, and the I/O pads.
 *
 * This project generates an integer count, which is output
 * on the user area GPIO pads (digital output only).  The
 * wishbone connection allows the project to be controlled
 * (start and stop) from the management SoC program.
 *
 * See the testbenches in directory "mprj_counter" for the
 * example programs that drive this user project.  The three
 * testbenches are "io_ports", "la_test1", and "la_test2".
 *
 *-------------------------------------------------------------
 */

module wb2axi #(
    parameter BITS = 32,
    parameter pADDR_WIDTH =12,
    parameter pDATA_WIDTH =32,
     parameter Tape_Num =11
)(

    // Wishbone Slave ports (WB MI A)
    input 						wb_clk_i,
    input 						wb_rst_i, 
    input 						wbs_stb_i,
    input 						wbs_cyc_i,
    input 						wbs_we_i,
    input  [3:0] 				wbs_sel_i,
    input  [(pDATA_WIDTH-1):0]	wbs_dat_i,
    input  [(pDATA_WIDTH-1):0]	wbs_adr_i,
    output 						wbs_ack_o,
    output [(pDATA_WIDTH-1):0] 	wbs_dat_o

);

    wire                     fir_valid;
    wire                     fir_we;
    wire [(pADDR_WIDTH-1):0] fir_addr;

   	//------global---------
   	assign fir_valid = wbs_stb_i & wbs_cyc_i;
   	assign fir_we    = wbs_we_i & wbs_cyc_i;
   	assign fir_addr  = wbs_adr_i[11:0];
	assign wbs_ack_o = (w_count==1) | (ss_tvalid & ss_tready) | (sm_tvalid & sm_tready) | rvalid; 
   	//wready | rvalid | (ss_tvalid & ss_tready) | (sm_tvalid & sm_tready);
   	reg  [1:0] w_count;
   	wire [1:0] n_count;
    assign n_count = w_count + 2'b01;
	always @(posedge wb_clk_i or posedge wb_rst_i)begin
	    if(wb_rst_i | n_count==2) begin
			w_count <= 4'd0;
    	end
    	else if (awvalid) begin
    		w_count <= n_count;
    	end
    	else begin
    		w_count <= 4'd0;
    	end
    end
   	
   	reg [(pDATA_WIDTH-1):0] wbdato;
   	assign wbs_dat_o = wbdato;
   	// *****
   	// read data out
   	always @(*) begin
        wbdato = 32'd0;
        if (fir_addr == 12'h0) begin
        	wbdato = {27'd0, sm_tvalid, ss_tready, 1'b0, rdata[2:0]};	// X[n], Y[n]
        end 
        else if ((fir_addr >= 12'h20) & (fir_addr <= 12'h48))  begin
        	wbdato = rdata;
        end
        else if (fir_addr == 12'h84) begin
        	wbdato = sm_tdata;
        end
        else begin
        	wbdato = rdata;
        end
    end
    
   	//---------------------

    //tlast counter for data length = 64
    reg [5:0] 				tlast_counter;
	
	// write
    wire                     awready;
    wire                     awvalid;
    wire [(pADDR_WIDTH-1):0] awaddr;
    wire                     wready;
    wire                     wvalid;  
    wire [(pDATA_WIDTH-1):0] wdata;
	
	// read
    wire                     arready;
    wire                     arvalid;
    wire [(pADDR_WIDTH-1):0] araddr;
    wire                     rready;
    wire                     rvalid;
    wire [(pDATA_WIDTH-1):0] rdata;
	
	// input data
    wire                     ss_tready;
    wire                     ss_tvalid;
    wire                     ss_tlast;
    wire [(pDATA_WIDTH-1):0] ss_tdata;
	
	// output data
    wire                     sm_tready;
    wire                     sm_tvalid;
    wire                     sm_tlast;
    wire [(pDATA_WIDTH-1):0] sm_tdata;
	
	// tap ram control
    wire   [3:0]             tap_WE;
    wire                     tap_EN;
    wire [(pDATA_WIDTH-1):0] tap_Di;
    wire [(pADDR_WIDTH-1):0] tap_A;
    wire [(pDATA_WIDTH-1):0] tap_Do;

	// data ram control
    wire  [3:0]              data_WE;
    wire                     data_EN;
    wire [(pDATA_WIDTH-1):0] data_Di;
    wire [(pADDR_WIDTH-1):0] data_A;
    wire [(pDATA_WIDTH-1):0] data_Do;


    // ------module conect---------
    fir fir_DUT(
    
    	// AXI Lite write
        .awready(awready),
        .wready(wready),
        .awvalid(awvalid),
        .awaddr(fir_addr),
        .wvalid(wvalid),
        .wdata(wbs_dat_i),
        
        // AXI Lite READ
        .arready(arready),
        .rready(rready),
        .arvalid(arvalid),
        .araddr(fir_addr),
        .rvalid(rvalid),
        .rdata(rdata),
        
        // AXI Stream in
        .ss_tvalid(ss_tvalid),
        .ss_tdata(wbs_dat_i),
        // .ss_tlast(ss_tlast),  // internally used
        .ss_tready(ss_tready),
        
        // AXI Stream out
        .sm_tready(sm_tready),
        .sm_tvalid(sm_tvalid),
        .sm_tdata(sm_tdata),
        .sm_tlast(sm_tlast),

        // ram for tap
        .tap_WE(tap_WE),
        .tap_EN(tap_EN),
        .tap_Di(tap_Di),
        .tap_A(tap_A),
        .tap_Do(tap_Do),

        // ram for data
        .data_WE(data_WE),
        .data_EN(data_EN),
        .data_Di(data_Di),
        .data_A(data_A),
        .data_Do(data_Do),

        .axis_clk(wb_clk_i),
        .axis_rst_n(~wb_rst_i)

        /*
        .state(state),
        .Tap_addr(Tap_addr),
        .Data_addr(Data_addr),
        .Write_addr(Write_addr),
        .counter(counter)
        */
    );
    bram11 tap_RAM (
        .CLK(wb_clk_i),
        .WE(tap_WE),
        .EN(tap_EN),
        .Di(tap_Di),
        .A(tap_A),
        .Do(tap_Do)
    );
    bram11 data_RAM(
        .CLK(wb_clk_i),
        .WE(data_WE),
        .EN(data_EN),
        .Di(data_Di),
        .A(data_A),
        .Do(data_Do)
    );

    //------------
    // AXI-lite W
    //------------
    assign awvalid = fir_valid & (fir_addr[7:4] != 4'd8) & fir_we;	// 0x00~80
    assign wvalid  = fir_valid & (fir_addr[7:4] != 4'd8) & fir_we;	// 0x00~80
    
    //------------
    // AXI-lite R
    //------------
    assign arvalid = fir_valid & (fir_addr[7:4] != 4'd8) ;			// 0x00~80
    assign rready  = fir_valid & (fir_addr[7:4] != 4'd8) ;			// 0x00~80
    
    //---------------
    // AXI-Stream ss
    //---------------
    assign ss_tvalid = fir_valid & (fir_addr[7:4] == 4'd8) & fir_we;	// address point to 0x80, ready to send data
    
    //---------------
    // AXI-Stream sm
    //---------------
    assign sm_tready = fir_valid & (fir_addr[7:0] == 8'h84); // address point to 0x84, ready to receive data
    
endmodule

`default_nettype wire
