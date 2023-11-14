`timescale 1ns/100ps
module skeleton_tb();
	
    reg clock, reset;
    wire processor_clock, imem_clock, dmem_clock, regfile_clock;
	 clk_dffe clk2(clock,reset, clock_2, clock_2_);
	 clk_dffe clk4(clock_2,reset, clock_4, clock_4_);
	 
	 assign regfile_clock = clock_4_;
	 assign processor_clock = clock_4_;
	 assign imem_clock = clock;
	 assign dmem_clock = ~clock;

	wire [11:0] address_imem;
	wire [31:0] q_imem;
    imem my_imem(
        .address    (address_imem),            // address of data
        .clock      (imem_clock),                  // you may need to invert the clock
        .q          (q_imem)                   // the raw instruction
    );

    wire [11:0] address_dmem;
    wire [31:0] data;
    wire wren;
    wire [31:0] q_dmem;
    dmem my_dmem(
        .address    (address_dmem/* 12-bit wire */),       // address of data
        .clock      (dmem_clock),                  // may need to invert the clock
        .data	    (data/* 32-bit data in */),    // data you want to write
        .wren	    (wren/* 1-bit signal */),      // write enable
        .q          (q_dmem/* 32-bit data out */)    // data from dmem
    );

    /** REGFILE **/
    wire ctrl_writeEnable;
    wire [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    wire [31:0] data_writeReg;
    wire [31:0] data_readRegA, data_readRegB;
    regfile my_regfile(
        regfile_clock,
        ctrl_writeEnable,
        reset,
        ctrl_writeReg,
        ctrl_readRegA,
        ctrl_readRegB,
        data_writeReg,
        data_readRegA,
        data_readRegB
    );

    /** PROCESSOR **/
    processor my_processor(
        // Control signals
        processor_clock,                          // I: The master clock
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
		
// ********************************************************************************************* //
	// Clock generator
	localparam half_period = 10;
	always
	begin
		#half_period clock = ~clock; // period = 20ns, freq = 50MHz
	end
	
	// Run
	
	initial
	begin
		$display($time, " << Starting the Simulation >>");
		clock = 1'b0; // at time 0
		reset = 1'b1; // assert reset
		
		@(negedge clock);  // wait until next negative edge of clock
		@(negedge clock);  // wait until next negative edge of clock
		reset = 1'b0; 		 // de-assert reset

		
		#10000
		$display($time, " << The simulation completed >>");
		$stop;

		
	end
	
endmodule
