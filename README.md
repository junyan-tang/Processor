# Processor
 - Author: Xueyi Fu(xf52) , Junyan Tang(jt418)
 - Date: 10/18/2023

### Design Description
This design implements a single-cycle 32-bit processor. The top-level entity("skeleton") includes processor, instruction memory, data memory and regfile. In this project, we implement some basic functionalities of a processor based on MIPS ISA. Specifically, the following R-type and I-type instructions: _add_, _sub_, _and_, _or_, _sll_, _sra_, _sw_, _lw_, _addi_.

**skeleton.v**
<br> This is a wrapper around the processor to provide certain control signals and interfaces to memory elements. It has two inputs, clock signal and reset signal. The outputs are imem_clock, dmem_clock, processor_clock and regfile_clock, which represent the clock signal of these components respectively. Frequency of regfile & processor clock is one quarter of those two memory clock frequency. The clock of data memory is half a cycle behind instruction memory's clock.

**processor.v**
<br> This is the core module of processor design. In this module, we connect Memory, Register File, ALU, Program Counter and Control circuit together and assign correct values to them. Here we process several exceptions. For example, if overflow occurs, $rstatus($r30) will be set to certain value.

**Control.v**
<br> This module implements control circuit. Processor needs control signals including Rwe, Rdst, ALUinB, DMwe and Rwd to decide which datapath to choose. These signals are generated by logical combination of opcode.

**dmem.v**
<br> Data momory is generated as a 1-port RAM. Initial content of dmem is left blank as we can never read data from some address of the dmem before writing into it.

**imem.v**
<br> Instruction memory is written by .mif file. It is a 1-port ROM on chip memory. Its 'q' output bus is 32 bits wide and it has 4096 32-bit words of memory.

**alu.v**
<br> Arithmetic Logic Unit.

**regfile.v**
<br> Register File.

**clock_divider_by2.v**
<br> Clock Divider which divides the clock input by two.

**plus1.v**
<br> Plus Program Counter(PC) by 1.

**reg_12bit.v**
<br> Program Counter which contains the address of the instruction being executed at current time. 

**SX.v**
<br> This module sign-extends I-type immediate field [16:0] to a signed 32-bit integer.

**dffe.v**
<br> Rising-Edge D Flip-Flop.

**basic_test.s**
<br> Basic test cases in assembly. Use assembler to generate corresponding .mif file to mif_outputs.

**halfTestCases.s**
<br> Half test cases in assembly.  Use assembler to generate corresponding .mif file to mif_outputs.

**skeleton_tb.v**
<br> Testbench file. Compares generated results with expected results.
