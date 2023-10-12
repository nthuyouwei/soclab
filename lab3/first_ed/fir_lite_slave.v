`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2023 09:56:59 AM
// Design Name: 
// Module Name: fir_lite_slave
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


module fir_lite_slave#(parameter
    C_S_AXI_ADDR_WIDTH = 12,
    C_S_AXI_DATA_WIDTH = 32
)(
    input  wire                          ACLK,
    input  wire                          ARESET,
    input  wire                          ACLK_EN,

    input  wire [C_S_AXI_ADDR_WIDTH-1:0] AWADDR,
    input  wire                          AWVALID,
    output wire                          AWREADY,

    input  wire [C_S_AXI_DATA_WIDTH-1:0] WDATA,
    input  wire                          WVALID,
    output wire                          WREADY,


    input  wire [C_S_AXI_ADDR_WIDTH-1:0] ARADDR,
    input  wire                          ARVALID,
    output wire                          ARREADY,

    output wire [C_S_AXI_DATA_WIDTH-1:0] RDATA,
    output wire                          RVALID,
    input  wire                          RREADY,

    output wire                          ap_start,
    input  wire                          ap_done,
    input  wire                          ap_idle,    
   
    output  wire                     Tap_WE,
    output  wire                     Tap_EN,
    output  wire [C_S_AXI_DATA_WIDTH-1:0] Tap_Di,
    output  wire [C_S_AXI_ADDR_WIDTH-1:0] Tap_A,
    input   wire [C_S_AXI_DATA_WIDTH-1:0] Tap_Do
);
    localparam
    ADDR_AP_CTRL         =    12'h00,
    ADDR_datalength      =    12'h10,
    ADDR_tapparameters   =    12'hFF,
    ADDR_BITS                = 12;
    // output signal use reg 
    reg aw_ready; //finish
    reg w_ready; //finish
    reg ar_ready; //finish
    reg [C_S_AXI_DATA_WIDTH-1:0]  r_data;
    reg [C_S_AXI_ADDR_WIDTH-1:0]  aw_addr;
    reg                           r_valid; //finish
    reg    [3:0]               tapwe;
    reg                        tapen;
    reg [C_S_AXI_DATA_WIDTH-1:0] tapdi;
    reg [C_S_AXI_ADDR_WIDTH-1:0] tapa;
    
    assign Tap_WE=tapwe;
    assign Tap_EN=tapen;
    assign Tap_Di=tapdi;
    assign Tap_A=tapa;
    assign AWREADY=aw_ready;
    assign WREADY = w_ready;
    assign ARREADY=ar_ready;
    assign RVALID  = r_valid;
    assign RDATA   = r_data;
    
   //produce en
       always @(posedge ACLK) begin
        if (ARESET == 1'b0) begin
            tapen <= 1'b0;
            
        end
        else begin
            //if ((aw_ready&&AWVALID)||(RREADY & r_valid) ) begin
                tapen <= 1'b1;
                
           // end
            //else begin
              //  tapen <= 1'b0;
            //end
        end
    end
    
    
   //produce tapwe 
          always @(posedge ACLK) begin
        if (ARESET == 1'b0) begin
            tapwe <= 1'b0;
            
        end
        else begin
            if (~aw_ready&&AWVALID&&~w_ready&&WVALID) begin
                tapwe <= 1'b1;
                
            end
            else begin
                tapwe <= 1'b0;
            end
        end
    end
   

    // produce awready 
    always @(posedge ACLK) begin
        if (ARESET == 1'b0) begin
            aw_ready <= 1'b0;
             
        end
        else begin
            if (~aw_ready && AWVALID&& WVALID ) begin
                aw_ready <= 1'b1;
                
            end
            else  begin
                aw_ready <= 1'b0;
            end
        end
    end

    //produce wready

    always @(posedge ACLK) begin
        if (ARESET == 1'b0) begin
            w_ready <= 1'b0;
        end
        else begin
            if (~w_ready && WVALID && AWVALID ) begin
                w_ready <= 1'b1;
            end
            else begin
                w_ready <= 1'b0;
            end
        end
    end
   always @( posedge ACLK )
    begin
        if ( ARESET== 1'b0 )
            begin
                aw_addr <= 0;
            end
        else
            begin
                if (~aw_ready&& AWVALID && WVALID )
                begin
                    aw_addr <= AWADDR;

                end
                else if(ARVALID)begin
         
                end              
           end
    end
    // can compare 1st this way is better
    always @(AWADDR) begin
    tapa<=AWADDR;
    end
    always @(ARADDR) begin
    tapa<=ARADDR;
    end  
    
    
    
     reg [C_S_AXI_DATA_WIDTH-1:0] datlength;
   
       always @(posedge ACLK) begin
        if (ACLK_EN) begin
            if( ARESET == 1'b0) begin
               datlength <=0;
            end
            else if (~aw_ready&&AWVALID&&~w_ready&&WVALID ) begin
                case (AWADDR)
                    ADDR_AP_CTRL: begin
                     int_ap_start <= WDATA;

                    end
                    ADDR_datalength: begin     
                        datlength <= WDATA;
                    
                    end
                    default: begin
                     tapdi<=WDATA;
                         
                    end
                endcase
            end
        end
    end
   
   
  // produce arready
    reg [ADDR_BITS-1:0]  ar_addr;
    always @(posedge ACLK) begin
        if (ARESET == 1'b0) begin
            ar_ready = 1'b0;
            ar_addr = 32'b0;
        end
        else begin
            if (~ar_ready & ARVALID )begin
                ar_ready = 1'b1;
                ar_addr = ARADDR;
                
            
            end
            else begin
                ar_ready = 1'b0;
            end
        end
    end


    // produce rvaild  應該要check有沒有arready在前
    always @(posedge ACLK) begin
        if (ARESET == 1'b0) begin
            r_valid <= 0;
        end
        else begin
            if (ARVALID && ~r_valid && ar_ready ) begin
                r_valid <= 1'b1;
            end
            else  if (RREADY && r_valid)begin
                r_valid <= 1'b0;
            end
        end
    end
    //  readdate
    
    reg int_ap_start;
    reg int_task_ap_done;
    reg int_ap_idle;
    always @(posedge ACLK) begin
        if (ACLK_EN) begin
            if( ARESET == 1'b0) begin
                r_data<=0;
            end
            else if (ar_ready && ~r_valid && ARVALID  ) begin
                case (ARADDR)
                    ADDR_AP_CTRL: begin
                        r_data[0] <= int_ap_start;
                        r_data[1] <= int_task_ap_done;
                        r_data[2] <= int_ap_idle;

                    end
                    ADDR_datalength: begin     
                        r_data <= 32'b1;
                    
                    end
                    default: begin
                         
                        r_data <=Tap_Do;
                    
                    end
                endcase
                
            end

        end
    end  
    // int_ap_start   

    // int_task_ap_done

    // int_ap_idle
endmodule



