# 操作說明


```
git clone https://github.com/bol-edu/caravel-soc_fpga-lab.git ~caravel-soc_fpga-lab
```

先設定zynq板子 [參考](https://github.com/bol-edu/caravel-soc_fpga#generate-caravel-soc-fpga-bitstream-from-xilinx-vivado)

自動建置 Vitis HLS 專案並匯出 IP

```
source run_vitis.sh
```
Caravel-FPGA 建立 Vivado 專案([vvd_caravel_fpga]())並執行「write_bitstream」步驟以產生位元流


