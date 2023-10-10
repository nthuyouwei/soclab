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
    ADDR_tapparameters   =    12'hFF,
    ADDR_BITS                = 12;
    // output signal use reg 

    reg aw_ready; //finish
    reg w_ready; //finish
    reg ar_ready; //finish
    reg [C_S_AXI_DATA_WIDTH-1:0]  r_data;
    reg [C_S_AXI_ADDR_WIDTH-1:0]  aw_addr;
    reg                           r_valid; //finish
    reg                  [3:0]      tapwe;
    reg                          tapen;
    reg [C_S_AXI_DATA_WIDTH-1:0] tapdi;
    reg [C_S_AXI_ADDR_WIDTH-1:0] tapa;
    reg [3:0]                    datawe;
    reg                          dataen;
    reg [C_S_AXI_DATA_WIDTH-1:0] datadi;
    reg [C_S_AXI_ADDR_WIDTH-1:0] dataa;
    
    
          
    
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
         last<=2'b00;
         mxstate<=4'b0000;
         yout<=32'h0;
         ymult<=32'h0;
         firstate<=1'b0;
         sstready<=1'b0;
        end
 end
    
    
    
    
//-----yout
reg smtvalid;
assign SM_tdata=ydata;
assign SM_tvalid=smtvalid;










// ---------decide the last input and last outout state
reg [1:0] last;
always@(posedge ACLK)begin
if(SS_tlast)begin
if(mxstate==4'b1010)begin
if(last==2'b00)
last<=2'b01;
if(last==2'b01)
last<=2'b10;
if(last==2'b10)
last<=2'b11;
end
end


end

always@(posedge ACLK)begin
if(last==2'b10)begin
if(mxstate==4'b0000)begin
 firstate<=0;
 int_task_ap_done<=1'b1;
 int_ap_idle<=1'b1;
end 
end

end




//--------FIR caluculaate 

reg [C_S_AXI_DATA_WIDTH-1:0]ymult;
reg [C_S_AXI_DATA_WIDTH-1:0] yout;
reg [C_S_AXI_DATA_WIDTH-1:0]ydata;



reg [3:0] mxstate;

always @(posedge ACLK) begin
if(firstate)begin
   if(mxstate==4'b0000)begin
    tapa<=12'h20;
dataa<=12'h20;
ymult<=Tap_Do*Data_Do;
ydata<=ymult+yout;
smtvalid<=1'b1;
mxstate<=4'b0001;
end

if(mxstate==4'b0001)begin
tapa<=12'h24;
dataa<=12'h24;
ymult<=Tap_Do*Data_Do;
mxstate<=4'b0010;
yout<=ymult;
smtvalid<=1'b0;
end

if(mxstate==4'b0010)begin
tapa<=12'h28;
dataa<=12'h28;
ymult<=Tap_Do*Data_Do;
yout<=ymult+yout;
mxstate<=4'b0011;
end

if(mxstate==4'b0011)begin
tapa<=12'h2c;
dataa<=12'h2c;
ymult<=Tap_Do*Data_Do;
mxstate<=4'b0100;
yout<=ymult+yout;
end

if(mxstate==4'b100)begin
tapa<=12'h30;
dataa<=12'h30;
ymult<=Tap_Do*Data_Do;
mxstate<=4'b0101;
yout<=ymult+yout;
end


if(mxstate==4'b0101)begin
tapa<=12'h34;
dataa<=12'h34;
ymult<=Tap_Do*Data_Do;
mxstate<=4'b0110;
yout<=ymult+yout;
end

if(mxstate==4'b0110)begin
tapa<=12'h38;
dataa<=12'h38;
ymult<=Tap_Do*Data_Do;
mxstate<=4'b0111;
yout<=ymult+yout;
end

if(mxstate==4'b0111)begin
tapa<=12'h3c;
dataa<=12'h3c;
ymult<=Tap_Do*Data_Do;
mxstate<=4'b1000;
yout<=ymult+yout;
end

if(mxstate==4'b1000)begin
tapa<=12'h40;
dataa<=12'h40;
ymult<=Tap_Do*Data_Do;
mxstate<=4'b1001;
yout<=ymult+yout;
end

if(mxstate==4'b1001)begin
tapa<=12'h44;
dataa<=12'h44;
ymult<=Tap_Do*Data_Do;
mxstate<=4'b1010;
yout<=ymult+yout;
end

if(mxstate==4'b1010)begin
tapa<=12'h48;
dataa<=12'h48;
ymult<=Tap_Do*Data_Do;
mxstate<=4'b0000;
firstate<=1'b0;
if(last!=2'b10)begin
sstready<=1'b1;
 end
yout<=ymult+yout;
end


end
end





//-------Xin-------
reg sstready=1'b0;
assign SS_tready =sstready;

reg firstate;
always @(posedge ACLK)begin

if( SS_tvalid  && int_ap_start) begin
    sstready<=1'b1;
    tapa<=12'h20;
    dataa<=12'h20;
    int_ap_start<=1'b0;
   end
   
end




reg [C_S_AXI_ADDR_WIDTH-1:0] data_addr=12'h20;


always @(posedge ACLK)begin
if(sstready==1'b0) begin  
datawe<=1'b0;
end

end



always @(posedge ACLK)begin

if(sstready && SS_tvalid) begin   
    datadi<=SS_tdata;
    datawe<=1;
    sstready<=1'b0;
    firstate<=1'b1;
      end

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


    // 同步  tapa (can compare 1st this way is better)
    always @(AWADDR) begin
        tapa<=AWADDR;
    end
    always @(ARADDR) begin
    if((ARADDR!=12'h0) && (ARADDR!=ADDR_datalength))begin
        tapa<=ARADDR;
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
            ar_ready = 1'b0;
          
        end
        else begin
            if (~ar_ready & ARVALID )begin
                ar_ready = 1'b1;
           
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

        if( ARESET == 1'b0) begin
            r_data<=0;
            int_task_ap_done<=1'b0;
            int_ap_idle<=1'b0;
        end
        else if (ar_ready && ~r_valid && ARVALID  ) begin
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

endmodule