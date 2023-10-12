`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/25/2023 01:35:35 AM
// Design Name: 
// Module Name: fir
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

module fir 
#(  parameter pADDR_WIDTH = 12,
    parameter pDATA_WIDTH = 32,
    parameter Tape_Num    = 11
)
(
    output  wire                     awready,
    input   wire                     awvalid,
    input   wire [(pADDR_WIDTH-1):0] awaddr,
    
    output  wire                     wready,
    input   wire                     wvalid,
    input   wire [(pDATA_WIDTH-1):0] wdata,
    
    output  wire                     arready,
    input   wire                     arvalid,
    input   wire [(pADDR_WIDTH-1):0] araddr,
    
    input   wire                     rready,
    output  wire                     rvalid,
    output  wire [(pDATA_WIDTH-1):0] rdata, 
       

    input   wire                     axis_clk,
    input   wire                     axis_rst_n,
    
    output  wire                     tap_WE,
    output  wire                     tap_EN,
    output  wire [(pDATA_WIDTH-1):0] tap_Di,
    output  wire [(pADDR_WIDTH-1):0] tap_A,
    input   wire [(pDATA_WIDTH-1):0] tap_Do,  
    
    input   wire                         ss_tvalid, 
    input   wire [(pDATA_WIDTH-1):0]     ss_tdata, 
    input   wire                         ss_tlast, 
    output  wire                         ss_tready  ,
    
    input wire state
    
);
wire   ap_start;
reg    ap_done;
reg    ap_idle;
wire   [(pADDR_WIDTH-1):0] ad;



fir_lite_slave #(
    .C_S_AXI_ADDR_WIDTH( pADDR_WIDTH ),
    .C_S_AXI_DATA_WIDTH( pDATA_WIDTH ))
control_s_axi_U(
    .AWVALID(awvalid),
    .AWREADY(awready ),
    .AWADDR( awaddr),
    
    .WVALID(wvalid),
    .WREADY(wready),
    .WDATA(wdata),

    .ARVALID(arvalid),
    .ARREADY(arready),
    .ARADDR(araddr),
    
    .RVALID(rvalid),
    .RREADY(rready),
    .RDATA(rdata),

    .ACLK(axis_clk),
    .ARESET(axis_rst_n),
    .ACLK_EN(1'b1),
    .ap_start(ap_start),
    .ap_done(ap_done),
    .ap_idle(ap_idle),
    .Tap_WE(tap_WE),
    .Tap_EN(tap_EN),
    .Tap_Di(tap_Di),
    .Tap_A(ad),
    .Tap_Do(tap_Do)
    
    
);

fir_stream_slave #(
    .pDATA_WIDTH( pDATA_WIDTH ))
ss(
        .CLK(axis_clk),
        .RESET(axis_rst_n),
        .SSTVALID(ss_tvalid), 
        .SSTDATA(ss_tdata), 
        .SSTLAST(ss_tlast), 
        .SSTREADY(ss_tready)  
);
 

reg start;
reg coeff;
reg coefad=0;

reg tap;
always @(posedge axis_clk)begin
if(0)begin
tap<=ad;
end
if(0)begin
tap<=coeff;
end
end


assign tap_A=ad;

always @(posedge axis_clk) begin
if(ap_start==32'h0000_0001)begin  
coefad <=12'h10;
coeff <= tap_Do;

end

end




















endmodule




