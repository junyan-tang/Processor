module SX(
	bits16,bits32
);
	input [15:0] bits16;
	output [31:0] bits32;

	assign bits32[15:0]=bits16;
	
	genvar i;
	generate for (i=16;i<32;i=i+1) begin:SX_loop
	  assign bits32[i]=1'b0;
	end
	endgenerate
	
endmodule