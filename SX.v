module SX(
	bits17,bits32
);
	input [16:0] bits17;
	output [31:0] bits32;

	assign bits32[16:0]=bits17;
	
	genvar i;
	generate for (i=17;i<32;i=i+1) begin:SX_loop
	  assign bits32[i]=bits17[16];
	end
	endgenerate
	
endmodule

module SX_T(
	bits27, bits32
	);
	input [26:0] bits27;
	output [31:0] bits32;
	
	assign bits32[26:0]=bits27;
	
	genvar i;
	generate for (i=27;i<32;i=i+1) begin:SX_T_loop
		assign bits32[i]=bits27[26];
	end
	endgenerate
	
endmodule

module SX_PC(
	bits12, bits32
	);
	input [11:0] bits12;
	output [31:0] bits32;
	assign bits32[11:0]=bits12;
	
	genvar i;
	generate for (i=12;i<32;i=i+1) begin:SX_PC_loop
	  assign bits32[i]= 1'b0;
	end
	endgenerate
	
endmodule
