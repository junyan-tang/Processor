module plus4(
	in12,out12
);
	input [11:0] in12;
	output [11:0] out12;

	wire [31:0] in32;
	wire [31:0] out32;
	
	wire isNotEqual, isLessThan, overflow;
	
	assign in32[11:0]=in12[11:0];
	assign in32[31:12]=20'b0000_0000_0000_0000_0000;
	
	alu(in32, 32'b0000_0000_0000_0000_0000_0000_0000_0100, 5'b00000,
			5'b00000, out32, isNotEqual, isLessThan, overflow);
	
	assign out12=out32[11:0];
	
endmodule