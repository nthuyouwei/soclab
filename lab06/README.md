# WorkLoad Optimize SOC (WLOS) Baseline

separate_tests 中我們為分開模擬(Fir、Matrix multiplication、Quick sort 、Uart)

intergrate_test 中我們把上述四個結合在一起，並且到pynq板子上進行驗證

## Separate_tests
### Counter_la_fir

Test result :

![image](https://github.com/nthuyouwei/soclab/assets/97797875/f6d580c4-fa60-4c54-8b5c-59567180fc28)

Waveform :

![image](https://github.com/nthuyouwei/soclab/assets/97797875/a928a9f6-9d34-49ed-b9bc-fed9680a8802)

### Counter_la_mm

Test result :

![image](https://github.com/nthuyouwei/soclab/assets/97797875/ed55c717-2980-416a-956e-4002940617d7)

Waveform :

![image](https://github.com/nthuyouwei/soclab/assets/97797875/8f794c06-81ec-4496-85e0-3b98ffffef98)

### Counter_la_qs

Test result :

![image](https://github.com/nthuyouwei/soclab/assets/97797875/50ba3548-a6eb-472e-82a2-5b791687daa3)

Waveform :

![image](https://github.com/nthuyouwei/soclab/assets/97797875/f39d0963-ecc7-45af-b02c-3a8aa82dc747)


### Uart

Test result :

![image](https://github.com/nthuyouwei/soclab/assets/97797875/f17bf46f-bbf1-4f8f-b432-0969041d0c9d)

Waveform :

![image](https://github.com/nthuyouwei/soclab/assets/97797875/670fefd9-1d39-4594-a135-6923aa5d3fc2)

## Intergrate_test

### Simulation on Ubuntu : 

![image](https://github.com/nthuyouwei/soclab/assets/97797875/5e69547d-c170-49f4-bdeb-41c39025b9ff)

#### Uart

當 Simulation 開始時啟動 interrupt，並等待 random cycle 進行 Uart 的資料傳輸。

![image](https://github.com/nthuyouwei/soclab/assets/97797875/799c09d4-fc64-4ecd-92ff-b9cfb5590617)

![image](https://github.com/nthuyouwei/soclab/assets/97797875/c8b05880-3e1f-44b7-b228-aef3d0723c9c)

#### Matrix Multiplication

當 checkbits 跑到 AB50 的位置開始 Matrix Multiplication，然後執行完回到 AB51。

![image](https://github.com/nthuyouwei/soclab/assets/97797875/9bf2b72e-e632-4a3d-834c-0a8ae70a177b)

![image](https://github.com/nthuyouwei/soclab/assets/97797875/631e068d-89d5-4738-a990-02fa2c571294)

![image](https://github.com/nthuyouwei/soclab/assets/97797875/8564fccb-d0e1-4233-b558-09eef7569679)

#### Fir

當 checkbits 跑到 AB60 的位置開始 Fir，然後執行完回到 AB61。

![image](https://github.com/nthuyouwei/soclab/assets/97797875/7b979e21-b0bd-4991-b0cb-5ddd7cd13806)

![image](https://github.com/nthuyouwei/soclab/assets/97797875/4a353d0b-42a7-4832-bd6d-7613c9a7d2ae)

![image](https://github.com/nthuyouwei/soclab/assets/97797875/4a6c7fc1-1123-4bdc-a699-c7feb368d88a)

#### Quick Sort

當 checkbits 跑到 AB70 的位置開始 Quick Sort，然後執行完回到 AB71。
最後全部執行完回到 AB31 完成 Simulation。

![image](https://github.com/nthuyouwei/soclab/assets/97797875/4af7ebef-4ec2-4159-8593-b0633e1b4511)

![image](https://github.com/nthuyouwei/soclab/assets/97797875/193e4690-86b8-4528-9599-b8ac5b955de1)

![image](https://github.com/nthuyouwei/soclab/assets/97797875/3e379d29-79f0-4a9b-ab6a-00862b263327)

![image](https://github.com/nthuyouwei/soclab/assets/97797875/f71ea831-3e83-4236-867b-7745de93cb51)

### Simulation on Jupyter Notebook

由於 firmware code 跑的速度比 ps side 快太多，以至於在 Jupyter Notebook 容易因為抓不到 0x1C 的位置，因此參考了討論區的做法，分別在 python code 與 firmware code 加上 while 迴圈去等待 ps side 抓到 0x1C 的位置。

#### Matrix Multiplication

![image](https://github.com/nthuyouwei/soclab/assets/97797875/c79be2b8-80fe-49bb-a9e1-43592fce0058)

![image](https://github.com/nthuyouwei/soclab/assets/97797875/203fd054-2c64-4ca3-842a-799156957efd)

#### Fir

![image](https://github.com/nthuyouwei/soclab/assets/97797875/42e51dbe-9ed8-4138-a263-d1880c411b09)

![image](https://github.com/nthuyouwei/soclab/assets/97797875/c7a2cd52-cbf1-49b4-afa3-73c57a805786)

#### Quick Sort

![image](https://github.com/nthuyouwei/soclab/assets/97797875/48ec8409-8871-4c20-9f6f-b2ea1d5def2a)

![image](https://github.com/nthuyouwei/soclab/assets/97797875/6a2b9f8a-e256-49c1-b2f0-64db531e7efe)

以下為 Simulation 結果：

![image](https://github.com/nthuyouwei/soclab/assets/97797875/5200c109-873b-46d1-8f33-6c8a49e17af2)

