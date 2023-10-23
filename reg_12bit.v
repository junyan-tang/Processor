module reg_12bit (q, d, clk, en, clr);

   input clk, clr,en;
   input [11:0] d;
   output [11:0] q;

   /* YOUR CODE HERE */
   genvar i;
	generate for (i=0;i<12;i=i+1) begin:reg_loop
	  dffe_ref dffe0(q[i],d[i],clk,en,clr);
	end
	endgenerate
endmodule