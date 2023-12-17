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

### Simulation : 

![image](https://github.com/nthuyouwei/soclab/assets/97797875/5e69547d-c170-49f4-bdeb-41c39025b9ff)

#### Uart

![image](https://github.com/nthuyouwei/soclab/assets/97797875/f5a3333c-a1cb-4063-bcce-65f8a2c3f465)

#### Matrix Multiplication

當 checkbits 跑到 AB50 的位置開始 Matrix Multiplication，然後執行完回到 AB51。

![image](https://github.com/nthuyouwei/soclab/assets/97797875/9bf2b72e-e632-4a3d-834c-0a8ae70a177b)

![image](https://github.com/nthuyouwei/soclab/assets/97797875/631e068d-89d5-4738-a990-02fa2c571294)

#### Fir

當 checkbits 跑到 AB60 的位置開始 Matrix Multiplication，然後執行完回到 AB61。

![image](https://github.com/nthuyouwei/soclab/assets/97797875/7b979e21-b0bd-4991-b0cb-5ddd7cd13806)

![image](https://github.com/nthuyouwei/soclab/assets/97797875/4a353d0b-42a7-4832-bd6d-7613c9a7d2ae)


