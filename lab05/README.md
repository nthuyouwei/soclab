
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

其中4個較重要的IP

## ResetControl: A memory-mapped-io to control Caravel reset pin. 
利用 xilinx hls建立。 hls code: [output_pin.cpp
](https://github.com/nthuyouwei/soclab/blob/main/lab05/vitis_hls_project/hls_output_pin/src/output_pin.cpp)

然後如 lab01 一樣匯出IP。 

## read_romcode: read the firmware hex data from PS/DDR memory to FPGA BRAM.
利用 xilinx hls建立。 hls code: [read_romcode.cpp](https://github.com/nthuyouwei/soclab/blob/main/lab05/vitis_hls_project/hls_read_romcode/src/read_romcode.cpp)

然後如 lab01 一樣匯出IP。 

## caravel_ps: It allows the PS side to use memory-mapped IO to read/write mprj pins. 
利用 xilinx hls建立。 hls code: [caravel_ps.cpp](https://github.com/nthuyouwei/soclab/blob/main/lab05/vitis_hls_project/hls_caravel_ps/src/caravel_ps.cpp)

然後如 lab01 一樣匯出IP。 
## spiflash: It emulates spiflash device read behavior. It reads data from BRAM.
直接撰寫verilog 。 verilog code: [spiflash.v](https://github.com/bol-edu/caravel-soc_fpga-lab/blob/main/labi/vvd_srcs/spiflash.v)



# 產生上面Caravel SOC FPGA 的.bit 和 .hwh 檔案


```
git clone https://github.com/bol-edu/caravel-soc_fpga-lab.git ~/caravel-soc_fpga-lab
```

先設定PYNQ-Z2板子 [參考](https://github.com/bol-edu/caravel-soc_fpga#generate-caravel-soc-fpga-bitstream-from-xilinx-vivado)

自動建置 Vitis HLS 專案並匯出 IP(上面所說明的IP)

```
source run_vitis.sh
```
Caravel-FPGA 建立 Vivado 專案( [vvd_caravel_fpga](https://github.com/nthuyouwei/soclab/tree/main/lab05/vvd_caravel_fpga) )並執行「write_bitstream」步驟以產生位元流
1. run_vivado.sh：產生時脈為 50MHz 的使用者專案計數器的位元流
2. run_vivado_gcd.sh：產生時脈為 10MHz 的使用者專案 gcd 的位元流

```
source run_vivado.sh
```
這裡會把jupter會用到的.bit 和.hwh複製到 [jupyter_notebooks_project](https://github.com/nthuyouwei/soclab/tree/main/lab05/jupyter_notebooks_project)

上傳[jupyter_notebooks_project](https://github.com/nthuyouwei/soclab/tree/main/lab05/jupyter_notebooks_project)至遠端PYNQ-Z2做驗證 (如lab01、lab02)

# The result on the jupter_notebook

## counter_la
[la_result.ipynb](https://github.com/nthuyouwei/soclab/blob/main/lab05/la_result.ipynb)
## counter_wb
[wb_result.ipynb](https://github.com/nthuyouwei/soclab/blob/main/lab05/wb_result.ipynb)

# Utilization of IP in the caravel fpga
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




