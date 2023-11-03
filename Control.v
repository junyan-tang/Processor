module Control(
	opcode,Func,
	Rwe,Rdst,ALUinB,ALUop,DMwe,Rwd,JP, 
	bne, blt, jr, jal, setx, bex,
	add,addi,sub
);
	input [4:0] opcode;
	input [4:0] Func;
	output Rwe,Rdst,ALUinB,DMwe,Rwd,JP;
	output bne, blt, jr, jal, setx, bex;
	output add,addi,sub;
	output [4:0] ALUop;
	
	//wire add,addi,sub,And,Or,sll,sra,sw,lw;
	wire And,Or,sll,sra,sw,lw;
	wire op;
	//R-Type
	assign op = opcode[4]?0:(opcode[3]?0:(opcode[2]?0:(opcode[1]?0:(opcode[0]?0:1))));
	
	//add  00000(00000)
	assign add = op?(Func[4]?0:(Func[3]?0:(Func[2]?0:(Func[1]?0:(Func[0]?0:1))))):0;
	
	//addi 00101
	assign addi = opcode[4]?0:(opcode[3]?0:(opcode[2]?(opcode[1]?0:(opcode[0]?1:0)):0));
	
	//sub  00000(00001)
	assign sub = op?(Func[4]?0:(Func[3]?0:(Func[2]?0:(Func[1]?0:(Func[0]?1:0))))):0;
	
	//and  00000(00010)
	//assign And = op?(Func[4]?0:(Func[3]?0:(Func[2]?0:(Func[1]?(Func[0]?0:1):0)))):0;
	//or   00000(00011)
	//assign Or =  op?(Func[4]?0:(Func[3]?0:(Func[2]?0:(Func[1]?(Func[0]?0:1):0)))):0;
	//sll  00000(00100)
	//assign sll = op?(Func[4]?0:(Func[3]?0:(Func[2]?(Func[1]?(Func[0]?0:1):0):0))):0;
	//sra  00000(00101)
	//assign sra = op?(Func[4]?0:(Func[3]?0:(Func[2]?(Func[1]?0:(Func[0]?1:0):0)))):0;
	
	//sw 00111
	assign sw = opcode[4]?0:(opcode[3]?0:(opcode[2]?(opcode[1]?(opcode[0]?1:0):0):0));
	
	//lw 01000
	assign lw = opcode[4]?0:(opcode[3]?(opcode[2]?0:(opcode[1]?0:(opcode[0]?0:1))):0);
	
	//j 00001
	assign j = opcode[4]?0:(opcode[3]?0:(opcode[2]?0:(opcode[1]?0:(opcode[0]?1:0))));
	
	//bne 00010
	assign bne = opcode[4]?0:(opcode[3]?0:(opcode[2]?0:(opcode[1]?(opcode[0]?0:1):0)));
	//jal 00011
	assign jal = opcode[4]?0:(opcode[3]?0:(opcode[2]?0:(opcode[1]?(opcode[0]?1:0):0)));
	//jr 00100
	assign jr = opcode[4]?0:(opcode[3]?0:(opcode[2]?(opcode[1]?0:(opcode[0]?0:1)):0));
	
	//blt 00110
	assign blt = opcode[4]?0:(opcode[3]?0:(opcode[2]?(opcode[1]?(opcode[0]?0:1):0):0));
	
	//bex 10110
	assign bex = opcode[4]?(opcode[3]?0:(opcode[2]?(opcode[1]?(opcode[0]?0:1):0):0)):0;
	
	//setx 10101
	assign setx = opcode[4]?(opcode[3]?0:(opcode[2]?(opcode[1]?0:(opcode[0]?1:0)):0)):0;
	
	//Rwe
	assign Rwe = op?1:(addi?1:(lw?1:0));
	//Rdst
	assign Rdst = ~op;
	//ALUinB
	assign ALUinB = addi?1:(sw?1:(lw?1:0));
	//ALUop
	assign ALUop = ALUinB?5'b00000:Func;
	//DMwe
	assign DMwe = sw?1:(jr?1:(blt?1:(bne?1:0)));
	//Rwd
	assign Rwd = lw;
	//BR
	//assign BR = blt?1:(bne?1:0);
	//JP
	assign JP = j?1:(jal?1:(bex?1:0));
endmodule