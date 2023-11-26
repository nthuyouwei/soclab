
110020015 劉祐瑋  
110011141 陳昇達

# Carvael SoC FPGA
為了模擬 Efabless Caravelharness SoC 模擬環境，設計的block diagram 如下圖所示。讓 Caravel Verilog 測試台程式碼可以輕鬆轉換為 Jupyter Notebook Python 測試台程式碼，如 [la_result.ipynb](https://github.com/nthuyouwei/soclab/blob/main/lab05/la_result.ipynb) 所示

![image](https://github.com/nthuyouwei/soclab/assets/145022311/9c66b9e9-646e-4a41-9174-4812dce947af)

我們也可以開啟vivado的block deseign 來查看。

```
cd ~/soclab/lab05/vvd_caravel_fpga
vivado vvd_caravel_fpga.xpr
```
載入 Vivado 專案後，點擊 IP INTEGRATOR 中的 Open Block Design，您可以看到圖表視窗。

![image](https://github.com/nthuyouwei/soclab/assets/145022311/d4445fef-c97c-4277-aed6-2091660a4f43)

## 其中4個較重要的IP
### ResetControl: A memory-mapped-io to control Caravel reset pin.
  
利用 xilinx hls建立。 hls code: [output_pin.cpp
](https://github.com/nthuyouwei/soclab/blob/main/lab05/vitis_hls_project/hls_output_pin/src/output_pin.cpp)

然後如 lab01 一樣匯出IP。 

### read_romcode: read the firmware hex data from PS/DDR memory to FPGA BRAM.
利用 xilinx hls建立。 hls code: [read_romcode.cpp](https://github.com/nthuyouwei/soclab/blob/main/lab05/vitis_hls_project/hls_read_romcode/src/read_romcode.cpp)

然後如 lab01 一樣匯出IP。 

### caravel_ps: It allows the PS side to use memory-mapped IO to read/write mprj pins. 
利用 xilinx hls建立。 hls code: [caravel_ps.cpp](https://github.com/nthuyouwei/soclab/blob/main/lab05/vitis_hls_project/hls_caravel_ps/src/caravel_ps.cpp)

然後如 lab01 一樣匯出IP。 
### spiflash: It emulates spiflash device read behavior. It reads data from BRAM.
直接撰寫verilog 。 verilog code: [spiflash.v](https://github.com/bol-edu/caravel-soc_fpga-lab/blob/main/labi/vvd_srcs/spiflash.v)

# Caravel SOC FPGA 的.bit 和 .hwh 檔案

```
git clone https://github.com/bol-edu/caravel-soc_fpga-lab.git ~/caravel-soc_fpga-lab
```

先設定PYNQ-Z2板子 [參考](https://github.com/bol-edu/caravel-soc_fpga#generate-caravel-soc-fpga-bitstream-from-xilinx-vivado)

自動建置 Vitis HLS 專案並匯出 IP(上面所說明的IP)

```
source run_vitis.sh
```
Caravel-FPGA 建立 Vivado 專案( [vvd_caravel_fpga](https://github.com/nthuyouwei/soclab/tree/main/lab05/vvd_caravel_fpga) )並執行「write_bitstream」步驟以產生位元流
1. run_vivado.sh： generate bitstream of user project counter with clock 50MHz
2. run_vivado_gcd.sh： generate bitstream of user project gcd with clock 10MHz

```
source run_vivado.sh
```
這裡會把jupter會用到的.bit 和.hwh複製到 [jupyter_notebooks_project](https://github.com/nthuyouwei/soclab/tree/main/lab05/jupyter_notebooks_project)

# Jupyter Notebook testbench example code

lab03、lab04都是在simiulator的環境下利用verilog 來寫testbench code。現在要轉換至 Jupyter Notebook Python 測試平台，所以利用python來寫testbench code (如:[caravel_fpga.ipynb](https://github.com/nthuyouwei/soclab/blob/main/lab05/jupyter_notebooks_project/caravel_fpga.ipynb))

## 說明
![image](https://github.com/nthuyouwei/soclab/assets/145022311/0736b9af-e6e8-4a5e-a443-80c2e471a528)
1. load new overlay(.bit)
   
![image](https://github.com/nthuyouwei/soclab/assets/145022311/ee400eb6-8c3b-434e-bced-456ff74931fa)

2. instance IPs by navigating the overlay object

![image](https://github.com/nthuyouwei/soclab/assets/145022311/45b3cd22-447e-4f43-afd7-151b3d12a1ab)

3. 選擇要匯入的firmwave
   
![image](https://github.com/nthuyouwei/soclab/assets/145022311/6ff145cb-c1fc-448d-a3ca-0470216aa569)

4. 計算rom size

![image](https://github.com/nthuyouwei/soclab/assets/145022311/520ac115-b291-4a33-841e-3ed07b32ab08)


5. write to bram

![image](https://github.com/nthuyouwei/soclab/assets/145022311/e9bcd416-00ed-4fea-b789-ca03a0bc6afc)


6. Release reset to make Caravel-soc start execute firmware code

![image](https://github.com/nthuyouwei/soclab/assets/145022311/313c6b3d-f6a3-43df-af0c-a36d13350dfc)

7. 可以查看mprj[31:0]

![image](https://github.com/nthuyouwei/soclab/assets/145022311/a8dea6cd-c74c-408f-877d-7c579fc561b0)


# Run on the jupter_notebook
我們需要的檔案有:
- compiled RISC-V firmwares : .hex
- FPGA bitstream and HWH file : .bit .hwh 
- Jupyter Notebook testbench example code: .ipynq

這裡所需的檔案都放置在 [jupyter_notebooks_project](https://github.com/nthuyouwei/soclab/tree/main/lab05/jupyter_notebooks_project)

上傳 [jupyter_notebooks_project](https://github.com/nthuyouwei/soclab/tree/main/lab05/jupyter_notebooks_project)至遠端PYNQ-Z2做驗證 ( 如 lab01 一樣或者可以參考[reference](https://github.com/bol-edu/caravel-soc_fpga#validation-on-pynq-fpga-board))

我們要測試counter_la和counter_wb，可以更改[caravel_fpga.ipynb](https://github.com/nthuyouwei/soclab/blob/main/lab05/jupyter_notebooks_project/caravel_fpga.ipynb)中的code來做驗證。

```
fiROM = open("counter_la.hex", "r+")
#fiROM = open("counter_wb.hex", "r+")
```

## counter_la

Compare the mprj_o value =0xab51(16-31bits)should sync to final result in the firmware code.

testbench on jupter_notebook ([la_result.ipynb](https://github.com/nthuyouwei/soclab/blob/main/lab05/la_result.ipynb)):

![image](https://github.com/nthuyouwei/soclab/assets/145022311/93f470cb-e526-4c3d-8798-98d6b6fa9263)

firmware code ([counter_la.c](https://github.com/nthuyouwei/soclab/blob/main/lab05/vvd_srcs/caravel_soc/counter_la/counter_la.c)):

![image](https://github.com/nthuyouwei/soclab/assets/145022311/e4c378d2-c126-4784-893d-eac60bb53169)


## counter_wb

Compare the mprj_o value =0xab61(16-31bits)should sync to final result in the firmware code.

testbench on jupter_notebook ([wb_result.ipynb](https://github.com/nthuyouwei/soclab/blob/main/lab05/wb_result.ipynb)
)

![image](https://github.com/nthuyouwei/soclab/assets/145022311/9a68b166-1777-4353-aee9-0d0fb68010ef)

firmware code ([counter_wb.c](https://github.com/nthuyouwei/soclab/blob/main/lab05/vvd_srcs/caravel_soc/counter_wb/counter_wb.c))

![image](https://github.com/nthuyouwei/soclab/assets/145022311/cd43c668-b03b-4516-b6d1-5f637aa0c05d)



# Utilization of IP in the Caravel SoC FPGA
這些都結果可以在[vvd_caravel_fpga](https://github.com/nthuyouwei/soclab/tree/main/lab05/vvd_caravel_fpga/vvd_caravel_fpga.runs) 底下翻找到。
## Caravel([design_1_caravel_0_0_utilization_synth.rpt](https://github.com/nthuyouwei/soclab/blob/main/lab05/vvd_caravel_fpga/vvd_caravel_fpga.runs/design_1_caravel_0_0_synth_1/design_1_caravel_0_0_utilization_synth.rpt))

![image](https://github.com/nthuyouwei/soclab/assets/145022311/4ab65121-61d1-41b6-a989-0e24168963a0)

![image](https://github.com/nthuyouwei/soclab/assets/145022311/a8def272-8497-41ba-a8ec-13f981f8b768)

## caravel_ps([design_1_caravel_ps_0_0_utilization_synth.rpt](https://github.com/nthuyouwei/soclab/blob/main/lab05/vvd_caravel_fpga/vvd_caravel_fpga.runs/design_1_caravel_ps_0_0_synth_1/design_1_caravel_ps_0_0_utilization_synth.rpt))

![image](https://github.com/nthuyouwei/soclab/assets/145022311/65cb289e-e4b1-4e0e-93fb-53d265d34ef5)

## spiflash([design_1_spiflash_0_0_utilization_synth.rpt](https://github.com/nthuyouwei/soclab/blob/main/lab05/vvd_caravel_fpga/vvd_caravel_fpga.runs/design_1_spiflash_0_0_synth_1/design_1_spiflash_0_0_utilization_synth.rpt))

![image](https://github.com/nthuyouwei/soclab/assets/145022311/f3ca490d-adc7-485e-b992-56f7066157aa)


## read_romcod([design_1_read_romcode_0_0_utilization_synth.rpt](https://github.com/nthuyouwei/soclab/blob/main/lab05/vvd_caravel_fpga/vvd_caravel_fpga.runs/design_1_read_romcode_0_0_synth_1/design_1_read_romcode_0_0_utilization_synth.rpt))

![image](https://github.com/nthuyouwei/soclab/assets/145022311/f9a039d7-e37c-4d78-bd1d-17449dc4153f)

![image](https://github.com/nthuyouwei/soclab/assets/145022311/0eef566a-738c-42d9-b009-550fdb7517b3)

## ResetControl([design_1_output_pin_0_0_utilization_synth.rpt](https://github.com/nthuyouwei/soclab/blob/main/lab05/vvd_caravel_fpga/vvd_caravel_fpga.runs/design_1_output_pin_0_0_synth_1/design_1_output_pin_0_0_utilization_synth.rpt))

![image](https://github.com/nthuyouwei/soclab/assets/145022311/1288787f-40f1-41da-985b-685c1cc9f7e7)


## BRAM([design_1_blk_mem_gen_0_0_utilization_synth.rpt](https://github.com/nthuyouwei/soclab/blob/main/lab05/vvd_caravel_fpga/vvd_caravel_fpga.runs/design_1_blk_mem_gen_0_0_synth_1/design_1_blk_mem_gen_0_0_utilization_synth.rpt))

![image](https://github.com/nthuyouwei/soclab/assets/145022311/c7a948c4-3524-4bb9-9dd1-3956ced920c9)

![image](https://github.com/nthuyouwei/soclab/assets/145022311/f091fc52-88da-4df9-bbd7-e634b75dd44d)




