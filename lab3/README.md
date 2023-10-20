#  環境
Use vivado in ubuntu.
#  目的
## FIR - Verilog implementation
**Function specification**

y[t]=Σ(h[i]∗x[t-i])

**Design specification**
- Data_Width 32
- Tape_Num 11
- Data_Num To be determined by data size
- Interface (reference [HackMD]( https://hackmd.io/oGlSE6_QQS2XW7ZR34f24Q?view))
    -  data_in stream （Xn）
    -  data_out: stream ( Yn)
    -  coef[Tape_Num-1:0] axilite
    -  len: axilite
    -  ap_start: axilite
    -  ap_done: axilite
- Using one Multiplier and one Adder
- Shift register implemented with SRAM (Shift_RAM, size = 10 DW) – size = 10 DW
- Tap coefficient implemented with SRAM (Tap_RAM = 11 DW) and initialized by axilite write
- Operation
    - ap_start to initiate FIR engine (ap_start valid for one clock cycle)
    - Stream-in Xn. The rate is depending on the FIR processing speed. Use axi-stream valid/ready for flow control
    - Stream out Yn, the output rate depends on FIR processing speed.

**Signal design details**

Configuration Register Address map:

0x00    [0]  ap_start (r/w), set when ap_start signal assert reset, when start data transfer, i.e. 1st axi-stream data come in

&emsp; &emsp; [1] ap_done (ro) -> when FIR process all the dataset, i.e. receive tlast, and last Y is generated and transferred

&emsp; &emsp; [2] ap_idle (ro) -> indicate FIR is actively processing data

0x10-14 - data-length

0x80-FF – Tap parameters, (e.g., 0x20-24 Tap0, in sequence …)

**The mmodule schematic diagram like :**
![figure](https://github.com/nthuyouwei/soclab/assets/145022311/5179cf95-539c-4674-acae-898eb46d6b58)
figure 1

**The testbench should follow the figure 2:**
![image](https://github.com/nthuyouwei/soclab/assets/145022311/340e45d7-2971-4781-a7ad-da2b40731715)
figure 2
# 設計細節





#  verilog code
The fir.v and tb.v in the [final_ed](<https://github.com/nthuyouwei/soclab/tree/main/lab3/final_ed>).
# simulation part

# synthesis part

## 使用資源(more details on [syn](https://github.com/nthuyouwei/soclab/tree/main/lab3/syn)):

![image](https://github.com/nthuyouwei/soclab/assets/145022311/d167d8a4-7f46-4d45-87f5-1b856bc7f912)

![image](https://github.com/nthuyouwei/soclab/assets/145022311/184da395-185f-4a40-8445-0167fa534063)

## Design timing summary(more details on [timing_report](https://github.com/nthuyouwei/soclab/blob/main/lab3/timing_report.txt)):

![image](https://github.com/nthuyouwei/soclab/assets/145022311/3e619c0f-000c-4eb6-b3a6-6ef3ce9a3cca)

![image](https://github.com/nthuyouwei/soclab/assets/145022311/72a63e4b-265a-4863-b60e-f0860cc9a586)



