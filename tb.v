`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2023 10:38:55 AM
// Design Name: 
// Module Name: fir_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fir_tb
#(  parameter pADDR_WIDTH = 12,
    parameter pDATA_WIDTH = 32,
    parameter Tape_Num    = 11,
    parameter Data_Num    = 600
)();
    wire                        awready;
    wire                        wready;
    reg                         awvalid;
    reg   [(pADDR_WIDTH-1): 0]  awaddr;
    reg                         wvalid;
    reg signed [(pDATA_WIDTH-1) : 0] wdata;
    wire                        arready;
    reg                         rready;
    reg                         arvalid;
    reg         [(pADDR_WIDTH-1): 0] araddr;
    wire                            rvalid;
    wire signed [(pDATA_WIDTH-1): 0] rdata;


    reg                         axis_clk;
    reg                         axis_rst_n;

// ram for tap
    wire                   [3:0]tap_WE;
    wire                     tap_EN;
    wire [(pDATA_WIDTH-1):0] tap_Di;
    wire [(pADDR_WIDTH-1):0] tap_A;
    wire [(pDATA_WIDTH-1):0] tap_Do;

// ram for data RAM
    wire [3:0]               data_WE;
    wire                     data_EN;
    wire [(pDATA_WIDTH-1):0] data_Di;
    wire [(pADDR_WIDTH-1):0] data_A;
    wire [(pDATA_WIDTH-1):0] data_Do;
    
    reg                         ss_tvalid;
    reg signed [(pDATA_WIDTH-1) : 0] ss_tdata;
    reg                         ss_tlast;
    wire                        ss_tready;
    wire signed [(pDATA_WIDTH-1): 0] y;
    wire signed [(pDATA_WIDTH-1): 0] ym;

    reg                         sm_tready;
    wire                        sm_tvalid;
    wire signed [(pDATA_WIDTH-1) : 0] sm_tdata;
    wire                        sm_tlast;



      fir fir_DUT(
        .AWREADY(awready),
        .WREADY(wready),
        .AWVALID(awvalid),
        .AWADDR(awaddr),
        .WVALID(wvalid),
        .WDATA(wdata),
        .ARREADY(arready),
        .RREADY(rready),
        .ARVALID(arvalid),
        .ARADDR(araddr),
        .RVALID(rvalid),
        .RDATA(rdata),
        // ram for tap
        .Tap_WE(tap_WE),
        .Tap_EN(tap_EN),
        .Tap_Di(tap_Di),
        .Tap_A(tap_A),
        .Tap_Do(tap_Do),

        // ram for data
        .Data_WE(data_WE),
        .Data_EN(data_EN),
        .Data_Di(data_Di),
        .Data_A(data_A),
        .Data_Do(data_Do),
        
        
        .SS_tvalid(ss_tvalid),
        .SS_tdata(ss_tdata),
        .SS_tlast(ss_tlast),
        .SS_tready(ss_tready),
        
        .SM_tready(sm_tready),
        .SM_tvalid(sm_tvalid),
        .SM_tdata(sm_tdata),
        .SM_tlast(sm_tlast),
        
        
        .ACLK(axis_clk),
        .ARESET(axis_rst_n)

        );
    
    // RAM for tap
    bram11 tap_RAM (
        .CLK(axis_clk),
        .WE(tap_WE),
        .EN(tap_EN),
        .Di(tap_Di),
        .A(tap_A),
        .Do(tap_Do)
    );

  shift_bram11 data_RAM(
        .CLK(axis_clk),
        .WE(data_WE),
        .EN(data_EN),
        .Di(data_Di),
        .A(data_A),
        .Do(data_Do)
    );





    initial begin
        axis_clk = 0;
        forever begin
            #5 axis_clk = (~axis_clk);
        end
    end
    
    integer timeout = (1000000);
    initial begin
        while(timeout > 0) begin
            @(posedge axis_clk);
            timeout = timeout - 1;
        end
        $display($time, "Simualtion Hang ....");
        $finish;
    end
    
    reg signed [(pDATA_WIDTH-1):0] Din_list[0:(Data_Num-1)];
    reg signed [(pDATA_WIDTH-1):0] golden_list[0:(Data_Num-1)];
    reg [31:0]  data_length;
    integer Din, golden, input_data, golden_data, m;
    initial begin
        data_length = 0;
        Din = $fopen("/home/ubuntu/samples_triangular_wave.dat","r");
        golden = $fopen("/home/ubuntu/out_gold.dat","r");
        for(m=0;m<Data_Num;m=m+1) begin
            input_data = $fscanf(Din,"%d", Din_list[m]);
            golden_data = $fscanf(golden,"%d", golden_list[m]);
            data_length = data_length + 1;
        end
    end
    
    

    initial begin
        axis_rst_n = 0;
        @(posedge axis_clk); @(posedge axis_clk);
        axis_rst_n = 1;
    end

    reg signed [31:0] coef[0:10]; // fill in coef 
    initial begin
        coef[0]  =  32'd0;
        coef[1]  = -32'd10;
        coef[2]  = -32'd9;
        coef[3]  =  32'd23;
        coef[4]  =  32'd56;
        coef[5]  =  32'd63;
        coef[6]  =  32'd56;
        coef[7]  =  32'd23;
        coef[8]  = -32'd9;
        coef[9]  = -32'd10;
        coef[10] =  32'd0;
    end
integer i;

  initial begin
        $display("------------Start simulation-----------");
        ss_tvalid = 0;
        $display("----Start the data input(AXI-Stream)----");
        for(i=0;i<(data_length-1);i=i+1) begin
            ss_tlast = 0; ss(Din_list[i]);
        end
         config_read_check(12'h00, 32'h00, 32'h0000_000f); 
         arvalid <= 0; // check idle = 0
         ss_tlast = 1; ss(Din_list[(Data_Num-1)]);
      $display("------End the data input(AXI-Stream)------");
 end
    reg error;
    reg status_error;

   initial begin
        error = 0; status_error = 0;
        sm_tready = 1;
      
        wait (sm_tvalid);
        @(posedge axis_clk);
        for(k=0;k <data_length;k=k+1) begin
        sm(golden_list[k],k);
        end
        config_read_check(12'h00, 32'h06, 32'h0000_0002); // check ap_done = 1 (0x00 [bit 1])
        config_read_check(12'h00, 32'h06, 32'h0000_0004);
        arvalid <= 0; // check ap_idle = 1 (0x00 [bit 2])
        if (error == 0 & error_coef == 0) begin
            $display("---------------------------------------------");
            $display("-----------Congratulations! Pass-------------");
        end
        else begin
            $display("--------Simulation Failed---------");
        end
       $finish;
    end













reg error_coef;
integer k;
    initial begin
        error_coef = 0;
        $display("----Start the coefficient input(AXI-lite)----");
        config_write(12'h10, data_length);
        for(k=0; k< Tape_Num; k=k+1) begin
            config_write(12'h20+4*k, coef[k]);
        end
        awvalid <= 0; wvalid <= 0;
        // read-back and check
        $display(" Check Coefficient ...");
            for(k=0; k < Tape_Num; k=k+1) begin
            config_read_check(12'h20+4*k, coef[k], 32'hffffffff);
        end         
        arvalid <= 0;
        $display(" Tape programming done ...");
        $display(" Start FIR");
        @(posedge axis_clk) config_write(12'h00, 32'h0000_0001); // ap_start = 1
         awvalid <= 0; wvalid <= 0;
        $display("----End the coefficient input(AXI-lite)----");
    end



    task config_write;
        input [11:0]    addr;
        input [31:0]    data;
        begin
            awvalid <= 0; wvalid <= 0;
            @(posedge axis_clk);
            awvalid <= 1; awaddr <= addr;
            wvalid  <= 1; wdata <= data;
            @(posedge axis_clk);
            while (!wready) @(posedge axis_clk);
        end
    endtask

    task config_read_check;
        input [11:0]        addr;
        input signed [31:0] exp_data;
        input [31:0]        mask;
        begin
            arvalid <= 0;
            @(posedge axis_clk);
            arvalid <= 1; araddr <= addr;
            rready <= 1;
            @(posedge axis_clk);
            while (!rvalid) @(posedge axis_clk);
            if( (rdata & mask) != (exp_data & mask)) begin
                $display("ERROR: exp = %d, rdata = %d", exp_data, rdata);
                error_coef <= 1;
            end else begin
                $display("OK: exp = %d, rdata = %d", exp_data, rdata);
            end
        end
    endtask
    
        task ss;
        input  signed [31:0] in1;
        begin
            ss_tvalid <= 1;
            ss_tdata  <= in1;
            @(posedge axis_clk);
            while (!ss_tready) begin
                @(posedge axis_clk);
            end
        end
    endtask


    task sm;
        input  signed [31:0] in2; // golden data
        input         [31:0] pcnt; // pattern count
        begin
            sm_tready <= 1;
            @(posedge axis_clk) 
            wait(sm_tvalid);
        
            while(!sm_tvalid) @(posedge axis_clk);
            if (sm_tdata != in2) begin
                $display("[ERROR] [Pattern %d] Golden answer: %d, Your answer: %d", pcnt, in2, sm_tdata);
                error <= 1;
            end
            else begin
                $display("[PASS] [Pattern %d] Golden answer: %d, Your answer: %d", pcnt, in2, sm_tdata);
            end
            @(posedge axis_clk);
        end
    endtask



endmodule

// bram behavior code (can't be synthesis)
// 11 words



module shift_bram11 
(
    CLK,
    WE,
    EN,
    Di,
    Do,
    A
);
    input   wire            CLK;
    input   wire            WE;
    input   wire            EN;
    input   wire    [31:0]  Di;
    output  wire     [31:0]  Do;
    input   wire    [11:0]   A; 

    //  11 words
	reg [31:0] RAM[0:10];
  


   assign Do =RAM[(A>>2)-12'h08];//{32{EN}}&RAM[A>>2];    // read
   

    reg [31:0] D;
  
    integer i;
    initial begin
        for (i = 0; i <= 10; i = i + 1) begin
            RAM[i] <= 32'b0;
        end
    
    
    end
    always @(posedge CLK) begin
        if(EN) begin
	        if(WE) begin 
	        RAM[0] <= Di;
	        RAM[1]<=RAM[0];
	        RAM[2]<=RAM[1];
	        RAM[3]<=RAM[2];
	        RAM[4]<=RAM[3];
	        RAM[5]<=RAM[4];
	        RAM[6]<=RAM[5];
	        RAM[7]<=RAM[6];
	        RAM[8]<=RAM[7];
	        RAM[9]<=RAM[8];
	        RAM[10]<=RAM[9];

	     end
	    end

    end
    

endmodule



module bram11 
(
    CLK,
    WE,
    EN,
    Di,
    Do,
    A
);
    input   wire            CLK;
    input   wire    [3:0]   WE;
    input   wire            EN;
    input   wire    [31:0]  Di;
    output  wire     [31:0]  Do;
    input   wire    [11:0]   A; 

    //  11 words
	reg [31:0] RAM[0:10];
    reg [11:0] r_A;

    always @(posedge CLK) begin
        r_A <= A;
    end

    assign Do =RAM[(A>>2)-12'h08];//{32{EN}}&RAM[A>>2];    // read

    reg [31:0] D;
  
    
    always @(posedge CLK) begin
        if(EN) begin
	   // if(WE) begin RAM[(A>>2)-12'h08] <= Di;
	    
	        if(WE[0]) RAM[(A>>2)-12'h08][7:0] <= Di[7:0];
            if(WE[1]) RAM[(A>>2)-12'h08][15:8] <= Di[15:8];
            if(WE[2]) RAM[(A>>2)-12'h08][23:16] <= Di[23:16];
            if(WE[3]) RAM[(A>>2)-12'h08][31:24] <= Di[31:24];
	        
	        
	        
	        
	        
            //end
                     
        end
    end
    

endmodule
