# lab4_1 Report
110020015 劉祐瑋
## Firmware code 
the related code can be found in [counter_la_fir.elf-fir.s](https://github.com/nthuyouwei/soclab/blob/main/lab04/lab04_1/lab-exmem_fir/testbench/counter_la_fir/counter_la_fir.elf-fir.s) and [counter_la_fir.out](https://github.com/nthuyouwei/soclab/blob/main/lab04/lab04_1/lab-exmem_fir/testbench/counter_la_fir/counter_la_fir.out)

![image](https://github.com/nthuyouwei/soclab/assets/145022311/45922a48-51b5-4fb5-a9cd-a00ca6cbabbd)

correspond to 

![image](https://github.com/nthuyouwei/soclab/assets/145022311/1a64f6d0-87da-49ef-a7b4-388dbc65efad)


And 

![image](https://github.com/nthuyouwei/soclab/assets/145022311/4834b1ff-ec85-4587-90b7-a8f80f524c2d)
![image](https://github.com/nthuyouwei/soclab/assets/145022311/d4852498-f869-4035-9708-cfb807c9ceb1)

correspond to

![image](https://github.com/nthuyouwei/soclab/assets/145022311/c84b37f6-662e-46b1-8cca-3491478afc77)

### How does it execute  multiplication in assembly code ?
乘法是通過名為 __mulsi3 的函数来执行的。
### What address allocate for user project and how many space is required to allocate to firmware code ?

從0x38000000開始到0x380001a0，總共416bytes。

![image](https://github.com/nthuyouwei/soclab/assets/145022311/cf020db9-0979-4dec-860f-7de4ff93f29b)
![image](https://github.com/nthuyouwei/soclab/assets/145022311/0480f5d9-0702-4796-8fcf-dd1f663e3428)
![image](https://github.com/nthuyouwei/soclab/assets/145022311/127830c0-60ff-4788-b482-c48c4363f432)




## Interface between BRAM and WB
```sh
cd ~/soclab/lab04/lab04_1/lab-exmem-fir/testbench/counter_la_fir
source run_clean
source run_sim
gtkwave counter_la_fir.vcd
```
### WB protocol 
![image](https://github.com/nthuyouwei/soclab/assets/145022311/4da48f74-7eb9-41f3-afd1-bc2b0395ea31)

注意ack應該在stb跟cyc拉起後，經過12個cycle才拉起，而不是10個因為要考慮bram。
### Waveform

Overview:

![image](https://github.com/nthuyouwei/soclab/assets/145022311/0d0d3726-474a-4b2b-9522-36ddde17a313)

Init:

![image](https://github.com/nthuyouwei/soclab/assets/145022311/6df48511-18aa-4993-8088-a05a645bf13c)

fir:

![image](https://github.com/nthuyouwei/soclab/assets/145022311/6bfbf08b-a328-408b-a37f-cf5f015d6d10)

End:

![image](https://github.com/nthuyouwei/soclab/assets/145022311/24150ec9-c542-4d52-89e6-b6dc01f70bab)


## synthesis
The bram.v and user_proj_example.counter.v run synthesis in vivado.

The report are in [syn_report](https://github.com/nthuyouwei/soclab/tree/main/lab04/lab04_1/syn_report).
### Utiliztion
![image](https://github.com/nthuyouwei/soclab/assets/145022311/1abb053a-2a77-481a-ac85-505f397c754b)

### Memory

![image](https://github.com/nthuyouwei/soclab/assets/145022311/1c494d94-34e9-4732-9212-55e44e7bd71c)

