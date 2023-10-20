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

module fir #(
    parameter C_S_AXI_ADDR_WIDTH = 12,
    parameter C_S_AXI_DATA_WIDTH = 32
)(
    input wire ACLK,
    input wire ARESET,

    input wire [C_S_AXI_ADDR_WIDTH-1:0] AWADDR,
    input wire AWVALID,
    output wire AWREADY,

    input wire [C_S_AXI_DATA_WIDTH-1:0] WDATA,
    input wire WVALID,
    output wire WREADY,

    input wire [C_S_AXI_ADDR_WIDTH-1:0] ARADDR,
    input wire ARVALID,
    output wire ARREADY,

    output wire [C_S_AXI_DATA_WIDTH-1:0] RDATA,
    output wire RVALID,
    input wire RREADY,

    output wire [3:0] Tap_WE,
    output wire Tap_EN,
    output wire [C_S_AXI_DATA_WIDTH-1:0] Tap_Di,
    output wire [C_S_AXI_ADDR_WIDTH-1:0] Tap_A,
    input wire [C_S_AXI_DATA_WIDTH-1:0] Tap_Do,

    input wire SS_tvalid,
    input wire [C_S_AXI_DATA_WIDTH-1:0] SS_tdata,
    input wire SS_tlast,
    output wire SS_tready,

    input wire SM_tready,
    output wire SM_tvalid,
    output wire [C_S_AXI_DATA_WIDTH-1:0] SM_tdata,
    output wire SM_tlast,

    output wire [3:0] Data_WE,
    output wire Data_EN,
    output wire [C_S_AXI_DATA_WIDTH-1:0] Data_Di,
    output wire [C_S_AXI_ADDR_WIDTH-1:0] Data_A,
    input wire [C_S_AXI_DATA_WIDTH-1:0] Data_Do
);

    localparam
        ADDR_AP_CTRL = 12'h00,
        ADDR_datalength = 12'h10,
        ADDR_tapparameters = 12'hFF;
    
    // Output signal use reg
    reg aw_ready; 
    reg w_ready; 
    reg ar_ready; 
    reg [C_S_AXI_DATA_WIDTH-1:0] r_data;
    reg [C_S_AXI_ADDR_WIDTH-1:0] aw_addr;
    reg r_valid; 
    reg tapen;
    reg [C_S_AXI_ADDR_WIDTH-1:0] tapa;
    reg [3:0] datawe;
    reg dataen;
    reg [C_S_AXI_ADDR_WIDTH-1:0] dataa;
    reg smtvalid;
    reg smtlast;
    assign SM_tlast = smtlast;
    assign SM_tdata = yout;
    assign SM_tvalid = smtvalid;
    assign Tap_EN = tapen;
    assign Tap_Di = WDATA;
    assign Tap_A = tapa;
    assign Data_EN = dataen;
    assign Data_Di = SS_tdata & {32{sstready}};
    assign Data_A = dataa;
    assign AWREADY = aw_ready;
    assign WREADY = w_ready;
    assign ARREADY = ar_ready;
    assign RVALID = r_valid;
    assign RDATA = r_data;

    // BRAM 0 state
    reg bramstate;
    always @(posedge ACLK) begin
        if (ARESET == 1'b0) begin
            bramstate <= 0;
            dataa <= 12'h0;
        end else begin
            if (bramstate == 1'b0) begin
                if (dataa == 12'h28) begin
                    bramstate <= 1'b1;
                end else begin
                    dataa <= dataa + 12'h04;
                end
            end
        end
    end

    // Decide the last input and last output state
    reg last;
    always @(posedge ACLK) begin
        if (ARESET == 1'b0) begin
            last <= 0;
            smtlast<=1'b0;
        end else begin
            if (SS_tlast && sstready) begin
                last <= 1'b1;
            end
            else if( smtlast && smtvalid) begin
                int_task_ap_done <= 1'b1;
                int_ap_idle <= 1'b1;
                firstate<=1'b0;
                smstate<=1'b0;
            end
            else if (last && smtvalid) begin
                smtlast<=1'b1;
                last<=1'b0;
            end

               
            end
        end
    
    reg smstate;
    // FIR calculation
    reg [C_S_AXI_DATA_WIDTH-1:0] ymult;
    reg [C_S_AXI_DATA_WIDTH-1:0] yout;
    always @(posedge ACLK) begin
        if (ARESET == 1'b0) begin
            smtvalid <= 1'b0;
            yout <= 32'h0;
            ymult <= 32'h0;            
            smtlast <= 1'b0;
            smstate<=1'b0;
        end else begin
        if (firstate) begin
            case (tapa)
                12'h00: begin
                    ymult <= Tap_Do * Data_Do;
                    dataa <= (dataa == 12'h28) ? 12'h00 : dataa + 12'h04;
                    tapa <= tapa + 12'h04;
                    sstready <= 1'b0;
                    if (smstate)begin smtvalid <= 1'b1;
                    end
                    else begin smstate<=1'b1 ;end
                    yout <= ymult + yout;
                end
                12'h04: begin
                    yout <= ymult;
                    dataa <= (dataa == 12'h28) ? 12'h00 : dataa + 12'h04;
                    ymult <= Tap_Do * Data_Do;
                    tapa <= tapa + 12'h04;
                    smtvalid <= 1'b0;
                end
                12'h28: begin
                    ymult <= Tap_Do * Data_Do;
                    yout <= ymult + yout;
                    tapa <= 12'h00;
                    if (~last)
                    sstready <= 1'b1;
                end
                default: begin
                    ymult <= Tap_Do * Data_Do;
                    yout <= ymult + yout;
                    dataa <= (dataa == 12'h28) ? 12'h00 : dataa + 12'h04;
                    tapa <= tapa + 12'h04;
                end
            endcase
        end
      end
    end
  assign Data_WE ={4{(sstready && SS_tvalid)||~bramstate}};
    // Xin
    reg sstready=1'b0;
    assign SS_tready = sstready;
    reg firstate;
    reg [C_S_AXI_ADDR_WIDTH-1:0] data_addr = 12'h20;
    always @(posedge ACLK) begin
        if (ARESET == 1'b0) begin
            sstready <= 1'b0;
            firstate <= 1'b0;
        end else if (int_ap_start) begin
            sstready <= 1'b1;
            firstate <= 1'b1; 
            tapa <= 12'h00;
            dataa <= 12'h00;
            int_ap_start <= 1'b0;
        end 
    end

    // Produce tapen dataen
    always @(posedge ACLK) begin
        if (ARESET == 1'b0) begin
            tapen <= 1'b1;
            dataen <= 1'b1;
        end
    end

assign Tap_WE={4{AWVALID && WVALID && AWADDR[7]}};
    always @(*) begin
        if (AWVALID == 1'b1&&AWADDR[7]==1'b1) begin
            tapa<=AWADDR[6:0];
        end
        else if (ARVALID == 1'b1&&ARADDR[7]==1'b1)begin
            tapa<=ARADDR[6:0];
        end
    end

    
    reg [C_S_AXI_DATA_WIDTH-1:0] data_length;
    // Write in
    always @(posedge ACLK) begin
        if (ARESET == 1'b0) begin
            data_length <= 0;
            w_ready<=1'b1;
            aw_ready<=1'b1;
           end else if (AWVALID && WVALID) begin
            case (AWADDR)
                ADDR_AP_CTRL: begin
                    if (WDATA == 32'h0000_0001)
                    int_ap_start <= 1'b1;
                    int_ap_idle <= 1'b0;
                 
                end
                ADDR_datalength: begin
                    data_length <= WDATA;
               
                end
                default: begin
                 
                end
            endcase
        end
    end
    // AXI READ
    // Produce rvalid
    // Should check if arready is in front
    // Read data
    reg int_ap_start;
    reg int_task_ap_done;
    reg int_ap_idle;
    
    always @(*) begin
    case (ARADDR)
    ADDR_AP_CTRL: begin
                        r_data[0] <= int_ap_start;
                        r_data[1] <= int_task_ap_done;
                        r_data[2] <= int_ap_idle;
                    end
                    ADDR_datalength: begin
                        r_data <= data_length;
                    end
                    default: begin
                        r_data <= Tap_Do;
                    end
      endcase
    end
    always @(posedge ACLK) begin
        if (ARESET == 1'b0) begin
            r_data <= 0;
            int_task_ap_done <= 1'b0;
            int_ap_idle <= 1'b0;
            r_valid <= 1'b0;
            ar_ready<=1'b1;
        end else if ( ~r_valid && ARVALID) begin
            r_valid <= ~r_valid;
        end else if (RREADY && r_valid) begin
            r_valid <= 1'b0;
        end
    end
endmodule

