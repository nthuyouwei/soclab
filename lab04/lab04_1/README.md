# Report
110020015 劉祐瑋
## Firmware code 
the related code can be found in [counter_la_fir.elf-fir.s](https://github.com/nthuyouwei/soclab/blob/main/lab04/lab04_1/lab-exmem_fir/testbench/counter_la_fir/counter_la_fir.elf-fir.s) and [counter_la_fir.out](https://github.com/nthuyouwei/soclab/blob/main/lab04/lab04_1/lab-exmem_fir/testbench/counter_la_fir/counter_la_fir.out)

### How does it execute  multiplication in assembly code ?

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




## synthesis
The bram.v and user_proj_example.counter.v run synthesis in vivado.

The report are in [syn_report](https://github.com/nthuyouwei/soclab/tree/main/lab04/lab04_1/syn_report).
### Utiliztion
![image](https://github.com/nthuyouwei/soclab/assets/145022311/1abb053a-2a77-481a-ac85-505f397c754b)

### Memory

![image](https://github.com/nthuyouwei/soclab/assets/145022311/1c494d94-34e9-4732-9212-55e44e7bd71c)

