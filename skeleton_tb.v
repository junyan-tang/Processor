`timescale 1 ns / 100 ps

module skeleton_tb();

    // inputs to the ALU are reg type

    reg            clock, reset;
    reg [31:0] data_operandA, data_operandB, data_expected;
    reg [4:0] ctrl_ALUopcode, ctrl_shiftamt;


    // outputs from the ALU are wire type
    wire [31:0] data_result;
    wire isNotEqual, isLessThan, overflow;

    // Instantiate ALU
    skeleton skeleton0(clock, reset, imem_clock, dmem_clock, processor_clock, regfile_clock);

    initial
	 
	 begin
		$display($time, "<< Starting the Simulation >>");
		clock = 1'b0;
		reset = 1'b1;
		#20
		reset = 1'b0;
		#400
		$stop;
	end

    // Clock generator
    always
         #10     clock = ~clock;

endmodule