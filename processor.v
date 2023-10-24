/**
 * READ THIS DESCRIPTION!
 *
 * The processor takes in several inputs from a skeleton file.
 *
 * Inputs
 * clock: this is the clock for your processor at 50 MHz
 * reset: we should be able to assert a reset to start your pc from 0 (sync or
 * async is fine)
 *
 * Imem: input data from imem
 * Dmem: input data from dmem
 * Regfile: input data from regfile
 *
 * Outputs
 * Imem: output control signals to interface with imem
 * Dmem: output control signals and data to interface with dmem
 * Regfile: output control signals and data to interface with regfile
 *
 * Notes
 *
 * Ultimately, your processor will be tested by subsituting a master skeleton, imem, dmem, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file acts as a small wrapper around your processor for this purpose.
 *
 * You will need to figure out how to instantiate two memory elements, called
 * "syncram," in Quartus: one for imem and one for dmem. Each should take in a
 * 12-bit address and allow for storing a 32-bit value at each address. Each
 * should have a single clock.
 *
 * Each memory element should have a corresponding .mif file that initializes
 * the memory element to certain value on start up. These should be named
 * imem.mif and dmem.mif respectively.
 *
 * Importantly, these .mif files should be placed at the top level, i.e. there
 * should be an imem.mif and a dmem.mif at the same level as process.v. You
 * should figure out how to point your generated imem.v and dmem.v files at
 * these MIF files.
 *
 * imem
 * Inputs:  12-bit address, 1-bit clock enable, and a clock
 * Outputs: 32-bit instruction
 *
 * dmem
 * Inputs:  12-bit address, 1-bit clock, 32-bit data, 1-bit write enable
 * Outputs: 32-bit data at the given address
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for regfile
    ctrl_writeReg,                  // O: Register to write to in regfile
    ctrl_readRegA,                  // O: Register to read from port A of regfile
    ctrl_readRegB,                  // O: Register to read from port B of regfile
    data_writeReg,                  // O: Data to write to for regfile
    data_readRegA,                  // I: Data from port A of regfile
    data_readRegB                   // I: Data from port B of regfile
);
    // Control signals
    input clock, reset;

    // Imem
    output [11:0] address_imem;
    input [31:0] q_imem;

    // Dmem
    output [11:0] address_dmem;
    output [31:0] data;
    output wren;
    input [31:0] q_dmem;

    // Regfile
    output ctrl_writeEnable;
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    input [31:0] data_readRegA, data_readRegB;

    /* YOUR CODE STARTS HERE */
    //instruction
	 wire [4:0] opcode,rd,rs,rt,shamt,Func;
	 wire [16:0] Immediate;
	 
	 //signal
	 wire Rwe,ALUinB,DMwe,Rwd, Rdst;
	 
	 //I-type
	 wire [31:0] Immediate_full;
	 wire [31:0] data_B;
	 
	 //Regfile
	 wire [4:0] Reg_t;
	 wire [31:0] Reg_datawrite;
	 
	 //alu
	 wire isNotEqual, isLessThan, overflow;
	 wire [4:0] ALUop;
	 wire [31:0] ALU_result;
	 
	 //PC
	 wire [11:0] PCplus4;
	 plus1 plus1_0(address_imem,PCplus4);
	 reg_12bit PC(address_imem,PCplus4,clock,1'b1,reset);
	 
	 
	 
	 //instruction
	 assign opcode = q_imem[31:27];
	 assign rd = q_imem[26:22];
	 assign rs = q_imem[21:17];
	 assign rt = q_imem[16:12];
	 assign shamt = q_imem[11:7];
	 assign Func = q_imem[6:2];
	 assign Immediate = q_imem[16:0];
	 
	 Control control0(opcode,Func,Rwe,Rdst,ALUinB,ALUop,DMwe,Rwd);
	 
	 //Regfile
	 assign Reg_t = Rdst?rd:rt;
	 
    assign ctrl_writeEnable = Rwe;
    assign ctrl_writeReg = Reg_t;
	 assign ctrl_readRegA = rs;
	 assign ctrl_readRegB = rt;
    assign data_writeReg = Rwd?q_dmem:ALU_result;
	 
	 //I-type
	 SX SX0(Immediate,Immediate_full);
	 assign data_B = ALUinB?Immediate_full:data_readRegB;
	 
	 //alu
	 alu alu0(
			.data_operandA		 (data_readRegA), 
			.data_operandB     (data_B), 
			.ctrl_ALUopcode    (ALUop),
			.ctrl_shiftamt     (shamt), 
			.data_result       (ALU_result), 
			.isNotEqual        (isNotEqual), 
			.isLessThan        (isLessThan), 
			.overflow          (overflow)
	);
	
	//data mem
	assign wren = DMwe;
	assign address_dmem = ALU_result[11:0];
	assign data = data_readRegB;
	
	
	 
endmodule