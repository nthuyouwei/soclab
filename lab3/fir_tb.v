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
    wire                        rvalid;
    wire signed [(pDATA_WIDTH-1): 0] rdata;
    reg                         ss_tvalid;
    reg signed [(pDATA_WIDTH-1) : 0] ss_tdata;
    reg                         ss_tlast;
    wire                        ss_tready;

    reg                         axis_clk;
    reg                         axis_rst_n;

// ram for tap
    wire                     tap_WE;
    wire                     tap_EN;
    wire [(pDATA_WIDTH-1):0] tap_Di;
    wire [(pADDR_WIDTH-1):0] tap_A;
    wire [(pDATA_WIDTH-1):0] tap_Do;






    fir fir_DUT(
        .awready(awready),
        .wready(wready),
        .awvalid(awvalid),
        .awaddr(awaddr),
        .wvalid(wvalid),
        .wdata(wdata),
        .arready(arready),
        .rready(rready),
        .arvalid(arvalid),
        .araddr(araddr),
        .rvalid(rvalid),
        .rdata(rdata),
        .ss_tvalid(ss_tvalid),
        .ss_tdata(ss_tdata),
        .ss_tlast(ss_tlast),
        .ss_tready(ss_tready),


        // ram for tap
        .tap_WE(tap_WE),
        .tap_EN(tap_EN),
        .tap_Di(tap_Di),
        .tap_A(tap_A),
        .tap_Do(tap_Do),

        .axis_clk(axis_clk),
        .axis_rst_n(axis_rst_n)

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







    initial begin
        axis_clk = 0;
        forever begin
            #5 axis_clk = (~axis_clk);
        end
    end

    initial begin
        axis_rst_n = 0;
        @(posedge axis_clk); @(posedge axis_clk);
        axis_rst_n = 1;
    end


reg error_coef;
    initial begin
        error_coef = 0;
        $display("----Start the coefficient input(AXI-lite)----");
        config_write(12'h24, 32'h6);
        config_write(12'h28, 32'h7);

        awvalid <= 0; wvalid <= 0;
        // read-back and check
        $display(" Check Coefficient ...");
        
            config_read_check(12'h24, 32'h6, 32'hffffffff);
            config_read_check(12'h28, 32'h7, 32'hffffffff);
        arvalid <= 0;
        $display(" Tape programming done ...");
        $display(" Start FIR");
             // ap_start = 1
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





endmodule

// bram behavior code (can't be synthesis)
// 11 words
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
    input   wire            WE;
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

    assign Do =RAM[A>>2];//{32{EN}}&RAM[A>>2];    // read

    reg [31:0] D;
  
    
    always @(posedge CLK) begin
        if(EN) begin
	        if(WE) begin RAM[A>>2] <= Di;
            end
           //D<=RAM[A>>2];
            

           
        end
    end
    

endmodule

