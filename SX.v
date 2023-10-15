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