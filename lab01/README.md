
#  LAB_01
name: youwei liu 

school: NTHU

student's number: 110020015


## brief introdction about the overall system
  We want to generate a Ip for multiplication by HLS, and intergrate the HLS IP into the system design by vivado. Finally, generating a bitstream to run on the jupyter notebook.
- HLS(high level synthesis)
    - Functionality in c /c++
    - Port interfaces
    - Optimaztions
    - Simulation
    - Debugging
    - Co-simulation
    - Ip generator
- vivado
    - Integrate the HLS IP into system Design
      
       the block design:
      ![image](https://github.com/nthuyouwei/soclab/assets/145022311/797cbb35-8585-467a-b92b-26eac5e81bf4)

    - Add Constraints
    - Synthesis
    - Implementation
    - Bistream Generation
    
- jupyter notebook
    - Program the board
    - Provide the inputs
    - Investigate the Output
 
   the [result](<https://github.com/nthuyouwei/soclab/blob/main/lab01/result_in_jupyter/Multip2Num.ipynb>) in the jupyter notebook.





##  what did I leaen in this lab? 

find an error when use incorrect program on the jupyter.

if my filename of .bit and .hwh aren't same, there would be an error.


```
\\from chatgpt

this is because these two files are typically interrelated, and PYNQ expects their names to match to ensure correct configuration and communication. Here's the roles and relationship of these two files:

.bit file: This is the FPGA bitstream file containing the digital bitstream for configuring the FPGA. It determines the configuration of logic gates within the FPGA to perform specific acceleration operations.

.hwh file: This is the hardware description file that describes the hardware resource configuration and connections within the FPGA. It specifies the connections established between logic gates within the FPGA and defines high-level interfaces for communication with the FPGA.

When the names of these two files don't match, PYNQ can't determine which .bit file should be used with which .hwh file, resulting in runtime errors. To resolve this issue, ensure that your .bit file and .hwh file have the same filename and are located in the same directory. This way, PYNQ will correctly identify and use both files to configure the FPGA and communicate with it.

```









