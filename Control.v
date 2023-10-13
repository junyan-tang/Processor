module Control(
	opcode,Func,Rwe,Rdst,ALUinB,ALUop,DMwe,Rwd
);
	input [4:0] opcode;
	input [4:0] Func;
	output Rwe,Rdst,ALUinB,ALUop,DMwe,Rwd;
	
	wire addi,sw;

	//add
	//addi 00101
	assign addi = opcode[4]?0:(opcode[3]?0:(opcode[2]?(opcode[1]?0:(opcode[0]?1:0)):0));
	//sub
	//and
	//or
	//sll
	//sra
	
	//sw 00111
	assign sw = opcode[4]?0:(opcode[3]?0:(opcode[2]?(opcode[1]?(opcode[0]?1:0):0):0));
	
	//lw 01000
	assign lw = opcode[4]?0:(opcode[3]?(opcode[2]?0:(opcode[1]?0:(opcode[0]?0:1))):0);
endmodule