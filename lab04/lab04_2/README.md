# lab04_2 Report
110020015 劉祐瑋  
110011141 陳昇達
## Firmware code 

### 設定 coef 地址

![image](https://github.com/nthuyouwei/soclab/assets/145022311/cabdd905-ad9c-465f-8991-dc1c8013a2ee)

### 設定 mprj

![image](https://github.com/nthuyouwei/soclab/assets/145022311/a4c8561e-141a-4270-b72c-2c4b97082ee7)

### 輸入 coef

![image](https://github.com/nthuyouwei/soclab/assets/145022311/fef4d55f-ec59-4ae1-84e0-e06881ebe18d)

### 利用mprj來當checkbit

![image](https://github.com/nthuyouwei/soclab/assets/145022311/f02b8ac7-2c57-46d8-96cf-5818d76c7293)

### fir.c (給 ap_start, check ap_control[4] 給 sstdata, check ap_control[5] 讀 smtdata)
![image](https://github.com/nthuyouwei/soclab/assets/145022311/c990f772-234f-48ae-aca9-e0e4996da2a1)


## testbench
main code:

![image](https://github.com/nthuyouwei/soclab/assets/145022311/52023cf2-2174-45a4-a580-76a5bacb5db9)


test result(a cycle 25 ns):

![image](https://github.com/nthuyouwei/soclab/assets/145022311/ca326093-782e-4a07-b4b4-ee667c7b0236)






## data_path

![image](https://github.com/nthuyouwei/soclab/assets/145022311/66417210-0a2a-4f0a-9278-e3c7237a07b3)

![image](https://github.com/nthuyouwei/soclab/assets/145022311/1e66fb76-c47e-48c6-a696-ee5c13046b51)


![image](https://github.com/nthuyouwei/soclab/assets/145022311/fd481189-6664-4d16-98d5-2223ef59791d)


## waveform analyze

![image](https://github.com/nthuyouwei/soclab/assets/145022311/a3e4a32b-0197-497c-92fc-226c71c34d5d)

## 優化分析
the report in the [lab4-2_optimization](https://github.com/nthuyouwei/soclab/blob/main/lab04/lab04_2/lab4-2_optimization.pdf)


## synthesis analyze

### Utiliztion

### Memory


