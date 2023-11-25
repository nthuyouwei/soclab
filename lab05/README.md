# 操作說明


```
git clone https://github.com/bol-edu/caravel-soc_fpga-lab.git ~caravel-soc_fpga-lab
```

先設定zynq板子 [參考](https://github.com/bol-edu/caravel-soc_fpga#generate-caravel-soc-fpga-bitstream-from-xilinx-vivado)

自動建置 Vitis HLS 專案並匯出 IP

```
source run_vitis.sh
```
Caravel-FPGA 建立 Vivado 專案([vvd_caravel_fpga](https://github.com/nthuyouwei/soclab/tree/main/lab05/vvd_caravel_fpga))並執行「write_bitstream」步驟以產生位元流
1. run_vivado.sh：產生時脈為 50MHz 的使用者專案計數器的位元流
2. run_vivado_gcd.sh：產生時脈為 10MHz 的使用者專案 gcd 的位元流

```
source run_vivado.sh
```
最後jupter會用到的.bit 和.hwh會複製到 [jupyter_notebooks_project](https://github.com/nthuyouwei/soclab/tree/main/lab05/jupyter_notebooks_project)

上傳[jupyter_notebooks_project](https://github.com/nthuyouwei/soclab/tree/main/lab05/jupyter_notebooks_project)至遠端PYNQ-Z2做驗證 (如lab01、lab02)
