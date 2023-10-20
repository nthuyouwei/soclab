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



module fir#(parameter
    C_S_AXI_ADDR_WIDTH = 12,
    C_S_AXI_DATA_WIDTH = 32
)(
    input  wire                          ACLK,
    input  wire                          ARESET,

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



    output  wire                 [3:0]    Tap_WE,
    output  wire                     Tap_EN,
    output  wire [C_S_AXI_DATA_WIDTH-1:0] Tap_Di,
    output  wire [C_S_AXI_ADDR_WIDTH-1:0] Tap_A,
    input   wire [C_S_AXI_DATA_WIDTH-1:0] Tap_Do,
    
    input   wire                     SS_tvalid, 
    input   wire [(C_S_AXI_DATA_WIDTH-1):0] SS_tdata, 
    input   wire                     SS_tlast, 
    output  wire                     SS_tready, 
    
    input   wire                     SM_tready, 
    output  wire                     SM_tvalid, 
    output  wire [(C_S_AXI_DATA_WIDTH-1):0] SM_tdata, 
    output  wire                     SM_tlast, 
    
    
    
    
    
    output  wire [3:0]               Data_WE,
    output  wire                     Data_EN,
    output  wire [C_S_AXI_DATA_WIDTH-1:0] Data_Di,
    output  wire [C_S_AXI_ADDR_WIDTH-1:0] Data_A,
    input   wire [C_S_AXI_DATA_WIDTH-1:0] Data_Do

    
      
);
    localparam
    ADDR_AP_CTRL         =    12'h00,
    ADDR_datalength      =    12'h10,
    ADDR_tapparameters   =    12'hFF;
    // output signal use reg 

    reg aw_ready; //finish
    reg w_ready; //finish
    reg ar_ready; //finish
    reg [C_S_AXI_DATA_WIDTH-1:0] r_data;
    reg [C_S_AXI_ADDR_WIDTH-1:0] aw_addr;
    reg                          r_valid; //finish
    reg                  [3:0]   tapwe;
    reg                          tapen;
    reg [C_S_AXI_DATA_WIDTH-1:0] tapdi;
    reg [C_S_AXI_ADDR_WIDTH-1:0] tapa;
    reg [3:0]                    datawe;
    reg                          dataen;
    reg [C_S_AXI_DATA_WIDTH-1:0] datadi;
    reg [C_S_AXI_ADDR_WIDTH-1:0] dataa;
    reg smtvalid;
    reg smtlast;
    assign SM_tlast=smtlast;        
    assign SM_tdata=yout;
    assign SM_tvalid=smtvalid;
    assign Tap_WE=tapwe;
    assign Tap_EN=tapen;
    assign Tap_Di=tapdi;
    assign Tap_A=tapa;
    assign Data_WE=datawe;
    assign Data_EN=dataen;
    assign Data_Di=datadi;
    assign Data_A=dataa;
    assign AWREADY=aw_ready;
    assign WREADY = w_ready;
    assign ARREADY=ar_ready;
    assign RVALID  = r_valid;
    assign RDATA   = r_data;
    
 //---------- some RESET   register
 always@(posedge ACLK)begin
        if (ARESET == 1'b0) begin
         smtvalid<=1'b0;
         yout<=32'h0;
         ymult<=32'h0;
         firstate<=1'b0;
         sstready<=1'b0;
         smtlast<=1'b0;
         last<=0;
         smtvalid<=0;
        end
       
 end
 // let bram 0
 reg bramstate;
 always@(posedge ACLK) begin
 if (ARESET == 1'b0) begin
   bramstate<=0;
   dataa<=12'h0;
  end
 else begin 
 if(bramstate==1'b0)begin

    if(dataa==12'h28) begin
       datadi<=32'h00;
       dataa<=12'h00;
       bramstate<=1'b1;
    end
    else begin
    datadi<=32'h00;
    dataa<=dataa+12'h04;
    end
 end
 end  
 end

// ---------decide the last input and last outout state
reg last;
always @(posedge ACLK) begin
if (ARESET == 1'b0) begin
end
else begin 
   if(SS_tlast &&sstready)begin
    last<=1'b1;
    end
   if(last&&smtvalid) begin
     int_task_ap_done<=1'b1;
      int_ap_idle<=1'b1;
      smtvalid<=1'b0;
end
end
end
//--------FIR caluculaate 
reg [C_S_AXI_DATA_WIDTH-1:0]ymult;
reg [C_S_AXI_DATA_WIDTH-1:0] yout;

always @(posedge ACLK) begin
    if (firstate) begin
        case (tapa)
            12'h00: begin
                ymult <= Tap_Do * Data_Do;
                dataa <= (dataa == 12'h28) ? 12'h00 : dataa + 12'h04;
                tapa <= tapa + 12'h04;
            end
            12'h04: begin
                yout <= ymult;
                dataa <= (dataa == 12'h28) ? 12'h00 : dataa + 12'h04;
                ymult <= Tap_Do * Data_Do;
                tapa <= tapa + 12'h04;
            end
            12'h28: begin
                ymult <= Tap_Do * Data_Do;
                yout <= ymult + yout;
                tapa <= tapa + 12'h04;
            end
            12'h2c: begin
                firstate <= 1'b0;
                smtvalid <= 1'b1;
                tapa <= 12'h00;
                yout <= ymult + yout;
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





//-------Xin-------

reg sstready=0;
assign SS_tready =sstready;

reg firstate;
reg [C_S_AXI_ADDR_WIDTH-1:0] data_addr=12'h20;
always @(posedge ACLK)begin
if (ARESET == 1'b0) begin
         sstready<=1'b0;
         end
else if( SS_tvalid  && int_ap_start) begin
    sstready<=1'b1;
    tapa<=12'h00;
    dataa<=12'h00;
    int_ap_start<=1'b0;
   end
else if(sstready && SS_tvalid) begin   
    smtvalid<=1'b0;
    tapa<=12'h00;
    datadi<=SS_tdata;
    datawe<=4'b1111;
    sstready<=1'b0;
    firstate<=1'b1;
end
else if(bramstate==1'b0)
 datawe<=4'b1111;
else
datawe<=4'b0;
end

    //produce tapen
    always @(posedge ACLK) begin
        if (ARESET == 1'b0) begin
            tapen <= 1'b0;
            dataen<=1'b0;
        end
        else begin
            tapen <= 1'b1;
            dataen<=1'b1;
        end
    end

    //produce tapwe 
    always @(posedge ACLK) begin
        if (ARESET == 1'b0) begin
            tapwe <= 4'b0;

        end
        else begin
            if((AWADDR==12'h0)||(AWADDR==ADDR_datalength))begin
                 tapwe<=4'b0;
            end
            
            else if (~aw_ready&&AWVALID&&~w_ready&&WVALID) begin
                tapwe <= 4'b1111;

            end
            else begin
                tapwe <= 4'b0;
            end
        end
    end

    //------axi write--------
    // produce awready 
    always @(posedge ACLK) begin
        if (ARESET == 1'b0) begin
            aw_ready <= 1'b0;

        end
        else begin
            if (~aw_ready && AWVALID&& WVALID ) begin
                aw_ready <= ~aw_ready;

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
                w_ready <= ~w_ready;
            end
            else begin
                w_ready <= 1'b0;
            end
        end
    end

//-----------符合bram的地址


always @(posedge ACLK) begin
    if (AWVALID == 1'b1) begin
        case (AWADDR)
            12'h20: tapa <= 12'h00;
            12'h24: tapa <= 12'h04;
            12'h28: tapa <= 12'h08;
            12'h2c: tapa <= 12'h0c;
            12'h30: tapa <= 12'h10;
            12'h34: tapa <= 12'h14;
            12'h38: tapa <= 12'h18;
            12'h3c: tapa <= 12'h1c;
            12'h40: tapa <= 12'h20;
            12'h44: tapa <= 12'h24;
            12'h48: tapa <= 12'h28;
            default: tapa <= 12'h00;  // 在AWADDR没有匹配时使用默认值
        endcase
    end
end
always@(negedge ACLK)begin
if (ARVALID == 1'b1) begin
    if ((ARADDR != 12'h0) && (ARADDR != ADDR_datalength)) begin
        case (ARADDR)
            12'h20: tapa <= 12'h00;
            12'h24: tapa <= 12'h04;
            12'h28: tapa <= 12'h08;
            12'h2c: tapa <= 12'h0c;
            12'h30: tapa <= 12'h10;
            12'h34: tapa <= 12'h14;
            12'h38: tapa <= 12'h18;
            12'h3c: tapa <= 12'h1c;
            12'h40: tapa <= 12'h20;
            12'h44: tapa <= 12'h24;
            12'h48: tapa <= 12'h28;
            default: tapa <= 12'h00;  // 在ARADDR没有匹配时使用默认值
        endcase
    end
end
end




    reg [C_S_AXI_DATA_WIDTH-1:0] data_length;
    //write in
    always @(posedge ACLK) begin
        if( ARESET == 1'b0) begin
            data_length <=0;
        end
        else if (~aw_ready&&AWVALID&&~w_ready&&WVALID ) begin
            case (AWADDR)
                ADDR_AP_CTRL: begin
                   if(WDATA==32'h0000_0001)
                    int_ap_start <= 1'b1;
                    tapdi<=0;
                end
                ADDR_datalength: begin
                    data_length <= WDATA;
                    tapdi<=0;
                end
                default: begin
                    tapdi<=WDATA;

                end
            endcase
        end

    end

    //----------AXI READ-----------
    // produce arready
  
    always @(posedge ACLK) begin
        if (ARESET == 1'b0) begin
            ar_ready <= 1'b0;
          
        end
        else begin
            if (~ar_ready & ARVALID )begin
                ar_ready <= ~ar_ready;
           
            end
            else begin
            if(r_valid)
                ar_ready <= ~ar_ready;
            end
        end
    end


    // produce rvaild  應該要check有沒有arready在前

    //  readdate
    reg rvalidstate;
    reg int_ap_start;
    reg int_task_ap_done;
    reg int_ap_idle;
    always @(posedge ACLK) begin

        if( ARESET == 1'b0) begin
            r_data<=0;
            int_task_ap_done<=1'b0;
            int_ap_idle<=1'b0;
             r_valid <= 0;
        end
        else if (ar_ready && ~r_valid && ARVALID  ) begin
            rvalidstate<=~rvalidstate;
            

        end
        else  if (RREADY && r_valid)begin
                r_valid <= 1'b0;
        end
    end
    always  @(posedge ACLK) begin

        if( ARESET == 1'b0) begin
        rvalidstate<=1'b0;
        end
        else begin
        if(rvalidstate) begin
           rvalidstate<=~rvalidstate;
           r_valid <= ~r_valid;
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
                    r_data <=Tap_Do;
                end
        endcase
        end
      end
      end

endmodule