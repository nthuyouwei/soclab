`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2023 08:37:32 AM
// Design Name: 
// Module Name: ss
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


module fir_stream_slave#(parameter
    pDATA_WIDTH = 32)(
    input   wire                     CLK,
    input   wire                     RESET,
    input   wire                         SSTVALID,
    input   wire [(pDATA_WIDTH-1):0]     SSTDATA,
    input   wire                         SSTLAST,
    output  wire                         SSTREADY
);


    reg sstready;
    assign SSTREADY =sstready;

    //produce sstready
    always @(posedge CLK)begin
    if (RESET == 1'b0) begin
        sstready <= 1'b0;

    end
    else begin
        if (~sstready && SSTVALID ) begin
            sstready <= 1'b1;
        end

    end
  end 
  
  // input_tdata 
  always @(posedge CLK)begin
    if (RESET == 1'b0) begin
        // something <= 1'b0;

    end
    else begin
        if (sstready && SSTVALID ) begin
     
      
          //  a[k] <= SSTDATA;
        end

    end
  end 










endmodule
