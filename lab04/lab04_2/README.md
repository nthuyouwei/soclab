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

我們先從未優化前的waveform觀察!

![image](https://github.com/nthuyouwei/soclab/assets/145022311/1eac1c40-3bcd-46e1-936a-1386342a25b0)

![image](https://github.com/nthuyouwei/soclab/assets/145022311/f4217a5e-2218-402c-b3f6-9edba409f2f2)

我們可以發現整個throughput為197cycle，但可以發現我們硬體做計算時只有14cycle就可以做完，所以問體是卡在cpu上，我們可以發現wb_addr會跑去3800x0000的位置做其他事情，這也導致軟體的部分，也就是sstvalid->smtready(對應到 c code 中 reg_fir_x = i 到 outputsignal[i] = reg_fir_y)花費的cycle數高達 68 cycle 以及smtready->sstvalid(對應到 c code 中 outputsignal[i] = reg_fir_y 迴圈至  reg_fir_x = i)花費的cycle數高達 129 cycle。所以我們要想辦法減少這兩部分。剛剛說到我們發現cpu會跑去做其他事情，所以我們打開assembly code 去看有沒有哪部分可以優化。

![image](https://github.com/nthuyouwei/soclab/assets/145022311/3007eb72-15bd-45be-a469-1ad4ca77ac90)

我們可以發現assembly code 中有這一部分，它會導致cpu進行指令的緩存刷新，也正因為如此他才要再去3800讀取code。 所以我們利用 -o1這個指令來讓編譯器幫我們優化(在run_sim中修改如下)

![image](https://github.com/nthuyouwei/soclab/assets/145022311/7a3e828a-d538-4fbe-a2a8-008192b6cb00)

優化後我們可以先簡單的對比一下優化前後assembly code 的差別

未優化:

![image](https://github.com/nthuyouwei/soclab/assets/145022311/730d68ad-5b6f-4139-9ad5-b3c6785e76ac)

優化後:

![image](https://github.com/nthuyouwei/soclab/assets/145022311/c67d4077-71a6-47a5-b412-42449245c99f)

可以發現優化後沒有stack pointer，也變得更加簡潔。

第一次優化後的waveform:

![image](https://github.com/nthuyouwei/soclab/assets/145022311/5fb129e9-4896-4038-9406-197329c8ce03)

![image](https://github.com/nthuyouwei/soclab/assets/145022311/53a20098-fd72-45b8-a360-356d0c113052)

這時sstvalid->smtready花費的cycle數為 29 cycle 以及smtready->sstvalid花費的cycle數為 72 cycle，整體throughput為101cycle。在這可以明顯的發現cpu有些時候不會再跑去bram重新讀指令，猜測可能直接經由cache來運作。除此之外，我們發現3000x0000在送y值之前讀了兩次，對應到了while迴圈判斷是否可以接收y，這造成不必要的cycle再跑一次至3000x0000，但我們發現其實可以直接打進去交給硬體判斷，上圖可以發現都是smtvalid先拉至1後等待smtready完成傳遞，但如果我不利用while迴圈來判斷，而是直接先給smtready拉至1，然後等待smtvalid完成傳遞，這樣可能會花更少的cycle。

第二次優化後的waveform:

![image](https://github.com/nthuyouwei/soclab/assets/145022311/7adb4fd3-b670-4b59-9b9b-0e448e65e96d)

![image](https://github.com/nthuyouwei/soclab/assets/145022311/7cdabf19-3686-40b8-9f13-d01432ea5309)

這時sstvalid->smtready花費的cycle數為 15 cycle 以及smtready->sstvalid花費的cycle數為 16 cycle，整體throughput為31cycle。而且可以發現cpu完全不用至bram重新讀取指令。

## synthesis analyze

### Utiliztion

### Memory


