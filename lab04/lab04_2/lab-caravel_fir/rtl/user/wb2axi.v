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
    input wb_clk_i,
    input wb_rst_i,
    
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o

);

    wire                     fir_valid;
    wire                     fir_we;
    wire [(pADDR_WIDTH-1):0] fir_addr;

   //------global---------
   assign fir_valid = wbs_stb_i & wbs_cyc_i;
   assign fir_we = wbs_we_i & wbs_cyc_i;
   assign fir_addr = wbs_adr_i[11:0];
   assign wbs_ack_o = wready|rvalid|(ss_tvalid & ss_tready)|(sm_tvalid & sm_tready);
   assign wbs_dat_o= (fir_addr[7:4] == 4'd8)? sm_tdata : rdata;
   //---------------------

    //tlast counter for data length = 64
    reg [5:0] tlast_counter;

    wire                     awready;
    wire                     awvalid;
    wire [(pADDR_WIDTH-1):0] awaddr;
    wire                     wready;
    wire                     wvalid;  
    wire [(pDATA_WIDTH-1):0] wdata;

    wire                     arready;
    wire                     arvalid;
    wire [(pADDR_WIDTH-1):0] araddr;
    wire                     rready;
    wire                     rvalid;
    wire [(pDATA_WIDTH-1):0] rdata;

    wire                     ss_tready;
    wire                     ss_tvalid;
    wire                     ss_tlast;
    wire [(pDATA_WIDTH-1):0] ss_tdata;

    wire                     sm_tready;
    wire                     sm_tvalid;
    wire                     sm_tlast;
    wire [(pDATA_WIDTH-1):0] sm_tdata;

    wire   [3:0]             tap_WE;
    wire                     tap_EN;
    wire [(pDATA_WIDTH-1):0] tap_Di;
    wire [(pADDR_WIDTH-1):0] tap_A;
    wire [(pDATA_WIDTH-1):0] tap_Do;

    wire  [3:0]              data_WE;
    wire                     data_EN;
    wire [(pDATA_WIDTH-1):0] data_Di;
    wire [(pADDR_WIDTH-1):0] data_A;
    wire [(pDATA_WIDTH-1):0] data_Do;


    // ------module conect---------
    fir_lab4 user_fir (
        // Global
        .axis_clk(wb_clk_i),
        .axis_rst_n(~wb_rst_i),  // cuz fir is rst_n
        // AXI-lite slave write
        .awready(awready),
        .awvalid(awvalid),
        .awaddr(fir_addr),
        .wready(wready),
        .wvalid(wvalid),  
        .wdata(wbs_dat_i),
        // AXI-lite slave read
        .arready(arready),
        .arvalid(arvalid),
        .araddr(fir_addr),
        .rready(rready),
        .rvalid(rvalid),
        .rdata(rdata),
        // AXI-ST slave - X
        .ss_tready(ss_tready),
        .ss_tvalid(ss_tvalid),
        .ss_tlast(ss_tlast),
        .ss_tdata(wbs_dat_i),
        // AXI-ST master - Y
        .sm_tready(sm_tready),
        .sm_tvalid(sm_tvalid),
        .sm_tlast(sm_tlast),
        .sm_tdata(sm_tdata),
        // bram for TAP RAM
        .tap_WE(tap_WE),
        .tap_EN(tap_EN),
        .tap_Di(tap_Di),
        .tap_A(tap_A),
        .tap_Do(tap_Do),
        // bram for X RAM
        .data_WE(data_WE),
        .data_EN(data_EN),
        .data_Di(data_Di),
        .data_A(data_A),
        .data_Do(data_Do)
    );
    // TAP RAM
    bram11 tap_ram (
        .clk(wb_clk_i),
        .we(tap_WE[0]),
        .re(tap_EN),
        .waddr(tap_A),
        .raddr(tap_A),
        .wdi(tap_Di),
        .rdo(tap_Do)
    );
    // DATA RAM
    bram11 data_ram (
        .clk(wb_clk_i),
        .we(data_WE[0]),
        .re(data_EN),
        .waddr(data_A),
        .raddr(data_A),
        .wdi(data_Di),
        .rdo(data_Do)
    );

    //------------
    // AXI-lite W
    //------------
    assign awvalid = fir_valid & (fir_addr[7:4] != 4'd8) & fir_we;
    assign wvalid = fir_valid & (fir_addr[7:4] != 4'd8) & fir_we;
    //------------
    // AXI-lite R
    //------------
    assign arvalid = fir_valid & (fir_addr[7:4] != 4'd8) ;    
    assign rready = fir_valid & (fir_addr[7:4] != 4'd8) ;
    //------------
    // AXI-Stream ss
    //------------
    assign ss_tvalid = fir_valid & (fir_addr[7:4] == 4'd8) & fir_we;
    assign ss_tlast  = fir_valid & (fir_addr[7:4] == 4'd8) & fir_we & (tlast_counter == 6'd63);
    // reg [5:0] tlast_counter;
    always @(posedge wb_clk_i) begin
        if (wb_rst_i)
            tlast_counter <= 6'd0;
        else if (ss_tvalid & ss_tready)
            tlast_counter <= tlast_counter + 1'b1;
        else
            tlast_counter <= tlast_counter;
    end
    //------------
    // AXI-Stream sm
    assign sm_tready = fir_valid & (fir_addr[7:4] == 4'd8) ;
    
endmodule



`default_nettype wire
