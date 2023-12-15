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
