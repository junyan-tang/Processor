module Control(
	opcode,Func,Rwe,Rdst,ALUinB,ALUop,DMwe,Rwd
);
	input [4:0] opcode;
	input [4:0] Func;
	output Rwe,Rdst,ALUinB,DMwe,Rwd;
	output [4:0] ALUop;
	
	wire add,addi,sub,And,Or,sll,sra,sw,lw;

	//add
	assign add = 
	//addi 00101
	assign addi = opcode[4]?0:(opcode[3]?0:(opcode[2]?(opcode[1]?0:(opcode[0]?1:0)):0));
	//sub
	assign sub =
	//and
	assign And = 
	//or
	assign Or =
	//sll
	assign sll =
	//sra
	assign sra =
	
	//sw 00111
	assign sw = opcode[4]?0:(opcode[3]?0:(opcode[2]?(opcode[1]?(opcode[0]?1:0):0):0));
	
	//lw 01000
	assign lw = opcode[4]?0:(opcode[3]?(opcode[2]?0:(opcode[1]?0:(opcode[0]?0:1))):0);
	
	//Rwe
	assign Rwe = ~sw;
	//Rdst
	assign Rdst = sw;
	//ALUinB
	assign ALUinB = addi?1:(sw?1:(lw?1:0));
	//ALUop
	assign ALUop = ALUinB?5'b00000:Func;
	//DMwe
	assign DMwe = sw;
	//Rwd
	assign Rwd = lw;
endmodule