// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.1 (lin64) Build 3526262 Mon Apr 18 15:47:01 MDT 2022
// Date        : Thu Dec  7 02:41:33 2023
// Host        : ubuntu2004 running 64-bit Ubuntu 20.04.4 LTS
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_blk_mem_gen_0_0_sim_netlist.v
// Design      : design_1_blk_mem_gen_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_blk_mem_gen_0_0,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.1" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (clka,
    rsta,
    ena,
    wea,
    addra,
    dina,
    douta,
    clkb,
    rstb,
    enb,
    web,
    addrb,
    dinb,
    doutb,
    rsta_busy,
    rstb_busy);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE BRAM_CTRL, READ_WRITE_MODE READ_WRITE, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA RST" *) input rsta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [3:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [31:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE BRAM_CTRL, READ_WRITE_MODE READ_WRITE, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB RST" *) input rstb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB WE" *) input [3:0]web;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [31:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DIN" *) input [31:0]dinb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [31:0]doutb;
  output rsta_busy;
  output rstb_busy;

  wire [31:0]addra;
  wire [31:0]addrb;
  wire clka;
  wire clkb;
  wire [31:0]dina;
  wire [31:0]dinb;
  wire [31:0]douta;
  wire [31:0]doutb;
  wire ena;
  wire enb;
  wire rsta;
  wire rsta_busy;
  wire rstb;
  wire rstb_busy;
  wire [3:0]wea;
  wire [3:0]web;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [31:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "32" *) 
  (* C_ADDRB_WIDTH = "32" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "8" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "2" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "1" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "1" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     10.7492 mW" *) 
  (* C_FAMILY = "zynq" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "1" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "1" *) 
  (* C_HAS_RSTB = "1" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "NONE" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "2" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "2048" *) 
  (* C_READ_DEPTH_B = "2048" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "1" *) 
  (* C_USE_BYTE_WEA = "1" *) 
  (* C_USE_BYTE_WEB = "1" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "4" *) 
  (* C_WEB_WIDTH = "4" *) 
  (* C_WRITE_DEPTH_A = "2048" *) 
  (* C_WRITE_DEPTH_B = "2048" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_5 U0
       (.addra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,addra[12:2],1'b0,1'b0}),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,addrb[12:2],1'b0,1'b0}),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb(dinb),
        .douta(douta),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(enb),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[31:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(rsta),
        .rsta_busy(rsta_busy),
        .rstb(rstb),
        .rstb_busy(rstb_busy),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[31:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(web));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2022.1"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
RgPKnWr9n0dGgttm3akiFhAlfB96usOQYxnEmPhGyTGg1AbizYAjGPWLXBWl50n/d0IA71ci4aJB
wt6mtfyNADm3ZReK7D3mKu037BOgxryoEwwf1kiC6q/PllxsdAgEMfQrfHJ3E2AzSpdYjoxVYito
y0JW6CUDcWvWa4WV0EA=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
M0l6KpOGH3jL8eRt3NCD7e2USYnkg5H9GAnE1PKmnjiouFN3Y8kjWA2PZDAQLm9UW+TsC1HeVlzO
WjNCHkjR/6ubCsIcWfpPZWdIuAenlsyq8Y9l6b8vMj8JSbDEOiFF/GHSbKsn22MJdDJKEhHFK6GV
s8gR2vywRFwG69gIRE4qGhVB+WIg8GJrDpDMYH6lCjMkTrjXuKDUcNlJN3NPLuhJ7tsditwf1pr5
moJRmGpJnip/rGm0g4o4A6ev4CtePjoao8C1wFtzHkERX9oenhh7cGjDMejU5IrLv8NxFnLj1FpB
9MuF1beTU20NI5oAn6zLiLiOtXjf0ghU3AN4DA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
hAsrUfp6Qgjm8yBjNYTEtQmVQmMxzL8TE/3oiQSxSI3+yEkXAbQCXkT9mo+LCdv+fGECOB0istHd
eLtbsiYbxjxNxYkXiUrRE5O+aSxynIray+uF9DJigTEUZu8JJXUbzxK4DDUu1Lm9tpGps4+Prz1m
0gkj13RT/Y/418s2VTw=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
BP/54Wm/GJmb1jy0bxWJJX4aiKyiWPVh4X3VL30BQrmX4PlEsNKzBJH3Qu8IIYERfnFP0ifAgboa
vypMQ5Ed0BrMePGkWIgT6I8hxJCMFpHdkSK7m1giSKyZzFfTOrVqoNFXE+qdzLfY1J5hBWCvouYo
jllavK4N3gF9FLScH2AUWYVMcVth2QPaTAU2NLnAUNH8kgtBjBfc8/KbPPTznD1QNVqvFstzcbTA
hGQ1ETVPvINQ0KqxxAG5PRhtQD4+pC+hr/Tvk+RSvGyBOfy9zE86OXkJiYs9dSFhNiMFmCPL9DBO
se4OxNNC0/7aBtb1mkSEA9YFDYEb9jS7Jasy2A==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
SnzT9DVH3xlEN8nrr2YrlvTO5qj7L22d7WaBcuKyTaiHoIwwFHrC4HQbfs0TAwkdWcOgmJoATPSF
F6qm0KiddbrlERF3MfKUldeGBJtqLdX+zGw7+3JD7S+HB9dIMOFOHy+IiCZp1/Pz8epKpi238cel
rcVoJQKz406wmXDvOo8KsT+XhRLs9BVCrBErPGGXKYDk6NXAp0duOgQE9DbslzMU83M/kUC7uERV
tQW02240peKQFp2elEZC7Tetvgp0TaFTtJiKN45REi8GQUCKGa85JjNIk1qb/+k95TIIP1xrHirc
6iX7qbwnPetv8TVu2NjkZ0WDEK5RXdOXcxBwHA==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_07", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
erkR82V0jX8ytva+9MzEs0c75Z7j7TsgxWRLNAUfbbU28i+U9YzuZlSfYU75M0f9jx1gvxtBrfKv
cNHVdkR+i5zfHDZsDwfMEEBhs8wzDCKqe+eex6BBEvlIOesCPXrr2RozQgaQ1PBh/os2Arfu+873
BjsVxFJkbhpzIqlddOo/XZV9Yi+eih7A7pXXEBR6IL7Poo4Ka49MiVQU0xJrDTm+ddOuMPDRRD7g
dsxS/uzdcBcO2myV6g/7YH/C2Ce9s6+UywJN/0JeXSqwA7bsBqqnfFicVAT0lckLopMLiuzK7dsN
EwhFeqoetciFrDIj9+o0xDMWBZhgNP1u68vURA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
R+BI65BKLT0I9hEtsxGnDyM5XY9gzULeTPOSDXvd3KWOzZJAx6C0xlbyZcFZhAEG/QIK2yd0wAi6
IUWxyF/sx3HsqKjhVi5KxnpuXDBOZVoj811O7JukedFVmDW7OHGtBkuiJ5X5irw7mfsEKRQmF/1i
V6lj9HYHZEjxtDeZjACsLY4y1QxWalSKT4HIMOHznBLL8dLbGMlS+ZmFuFn0gcwZavVl7gTkTtkf
W0gn01A9ru7NKsf+iLX0kj4dgItPu9N2g02M1vWQ9UUQEVvfV7lUc7GY1suibrD8aEkhH9S7lZ7n
bFsT4qxyvzg8ML6v4g4v7N6VuyhEtgFgNd725Q==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
jNUVKiwH68vHsU54idgvKwaVJcoxTUuxfgrQpbpmM/IpesWA3wHsGzYClwAxkKzw3KRnFyQqTWcZ
yj1EQ2CMBxlJ0kyNbZW8OK8pXzeigToZ0U6Aq3Gy+j7wBbhe83wE1Ygn82sK8dHTEulvaRLn/c5r
ispy1s7jMKIvYNzoUuZrgyBQyfaYmdqUia8XlQjFd+VwzhTXKwzvmaqHWyaHjfBKeCooO7+oUxMG
OJg83W54EVe9ronFQ8Wr9EOL8ia7qelCAgyQe/bC0HHCoMAm8apI7sX23iMR/wMiPP5V2bQzycy+
rBX/+SWkqSeIE1FLm+muFPvrE7iLwJaW8d1fzdFFjAZ5aIXArbWNfwbK8S0TczXc9lEzmpb69rwA
UJIrs4alo81qGQ32UFhjuMQjX75O9Od1HWHDj5PFaT/Ja5Ly+bK8Cc3gfO6dCE81m7d+B2JBZ/Hl
tBA19QuOAYwT2EIPOdpaVtCULb33cWODWu3qQFhZMmDzKTb3kwpcr0LL

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
MnzcA2swaxH1LRacKDou0ZmiiMRETbWIdHgeBgyQz7ILronsXLoB/C20WuFNGEVSiL2/51EZ6MXZ
vMHI8fFcMQCJcuTBDBibUMKv6bXI9s8fTbtrBZppbF/R1icG5JYhqmX4aRnv4W/dxJRjI2L35nLN
Y48E9OfgfkD1sr+IRwx8WEKFmUhuk8dLe0VOK7ywe3XEcneYvrz+HhPj16bGmNfMwNnDgZ3gKKZD
hRnys+jzvAX3HyISrErWXhMKrhWMxXeTNFJCqNQ0LWAVHQYwyKnF5xVpyXSuGNSIrva+QXqOrZBG
3VNLirNVtMRiKLfwZeMaqvswkqBDAa53utlAAA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
d0xXkKtsKM8GvXhDZr16p1+oE3uBtD04BJ76eGGIEj/CFECfHVy9qsJ43oSKjas0+AJr4GFFnVb6
X7gJV6MmX/OboC9ier5joUCGz0mxVzkRZK9a+LPEDcg0K6+cLE36kr+FfxW9Uk2816EHBCMCf5mK
A4eAhSmAb5Nq74F/q0quiG416npbny7faiQ+xmPDfYYiM3UuMKaD4iE8ODlz1w5xThPllWESf3LZ
NTkw6fozyTqZ47vvE21O3dgIGAY1v+C6BwlCK24VwPJa1xs9csY+qTk31j5jjAc1ExlB6QF7t9UH
lk70qdNPWxT87OH7kFT8UvPO1D6BTC3/WkDZfA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
LYhdzKTvo93uJrAaiP5OfCDuOnu2BSvPnxlv6I7h2n1+xHtj34LNNKzWEgOg9dUV9cYDaHYUjjEt
DKdWcz6mZ61d5qyxAhpv67fc90v7JVgtOAcT94/Yb+AuLxXFcGA6Gic7uoJtUgz6JmTnb22Dxdjc
KuIewDj4IOTfP8XGXKTaF+cNp0CFrQgTAcVSQFyLFxr0I/9h3S+GZLecA7ntEeHEOfCJzPvy0ddi
7MCdQWECLb+fXC0IAn8V95TumcpINiRAX1BHi9IGJ4QoMrb3jOCrPkFhDMTJj2aiImUWdi/l/0QE
d7wcXlgIEYVeoKYUOJ4mqy+zZPUbLNeOPADUDQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 59856)
`pragma protect data_block
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
Jd2SuBBF
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
