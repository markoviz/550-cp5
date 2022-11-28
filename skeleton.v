/**
 * NOTE: you should not need to change this file! This file will be swapped out for a grading
 * "skeleton" for testing. We will also remove your imem and dmem file.
 *
 * NOTE: skeleton should be your top-level module!
 *
 * This skeleton file serves as a wrapper around the processor to provide certain control signals
 * and interfaces to memory elements. This structure allows for easier testing, as it is easier to
 * inspect which signals the processor tries to assert when.
 */

module skeleton(clock, reset, imem_clock, dmem_clock, processor_clock, regfile_clock, address_imem,q_imem,address_dmem,data,wren,q_dmem,ctrl_writeEnable,
					 ctrl_writeReg, ctrl_readRegA, ctrl_readRegB,data_writeReg,data_readRegA, data_readRegB,
   register0, register1, register2, register3, register4, register5, register6, register7,
	register8, register9, register10, register11, register12, register13, register14, register15,
	register16, register17, register18, register19, register20, register21, register22, register23,
	register24, register25, register26, register27, register28, register29, register30, register31, alu1out, mux1out, signout, rwdout, dmwe2,
	bne_extend, temp_q_extend, pc_alu_result, temp_q2_1, temp_q3, temp_q4, reverse_isLessThan, blt_mux, isLessThan
	);
    input clock, reset;
    /* 
        Create four clocks for each module from the original input "clock".
        These four outputs will be used to run the clocked elements of your processor on the grading side. 
        You should output the clocks you have decided to use for the imem, dmem, regfile, and processor 
        (these may be inverted, divided, or unchanged from the original clock input). Your grade will be 
        based on proper functioning with this clock.
    */
    output imem_clock, dmem_clock, processor_clock, regfile_clock;
	 output [31:0] signout, mux1out, alu1out, rwdout;///
	 output dmwe2;
	 output [31:0] bne_extend, temp_q_extend, pc_alu_result;
	 output [11:0] temp_q2_1, temp_q3, temp_q4;
	 output reverse_isLessThan, blt_mux, isLessThan;
					 
    
    ///assign clocks here
	 wire clock1;
	 
	 ///frequency_divider_by2 fdb(clock, reset, clock1);
	 
	 clk_div cd0(clock, reset, clock1);
	 
	 assign imem_clock = clock;
	 assign dmem_clock = clock;
	 assign processor_clock = clock1;
	 assign regfile_clock = clock1;
	 
	 
	 /** IMEM **/
    // Figure out how to generate a Quartus syncram component and commit the generated verilog file.
    // Make sure you configure it correctly!
    output [11:0] address_imem;
    output [31:0] q_imem;
    imem my_imem(
        .address    (address_imem),            // address of data
        .clock      (imem_clock),                  // you may need to invert the clock
        .q          (q_imem)                   // the raw instruction
    );

    /** DMEM **/
    // Figure out how to generate a Quartus syncram component and commit the generated verilog file.
    // Make sure you configure it correctly!
    output [11:0] address_dmem;
    output [31:0] data;
    output wren;
    output [31:0] q_dmem;
    dmem my_dmem(
        .address    (address_dmem),       // address of data
        .clock      (dmem_clock),                  // may need to invert the clock
        .data	    (data),    // data you want to write
        .wren	    (wren),      // write enable
        .q          (q_dmem)    // data from dmem
    );  

    /** REGFILE **/
    // Instantiate your regfile 
    output ctrl_writeEnable;
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    output [31:0] data_readRegA, data_readRegB;
	 
	 output [31:0] register0, register1, register2, register3, register4, register5, register6, register7,
	register8, register9, register10, register11, register12, register13, register14, register15,
	register16, register17, register18, register19, register20, register21, register22, register23,
	register24, register25, register26, register27, register28, register29, register30, register31;
	 
	 
	 
    regfile my_regfile(
        regfile_clock,
        ctrl_writeEnable,
        reset,
        ctrl_writeReg,
        ctrl_readRegA,
        ctrl_readRegB,
        data_writeReg,
        data_readRegA,
        data_readRegB,
		  register0, register1, register2, register3, register4, register5, register6, register7,
	register8, register9, register10, register11, register12, register13, register14, register15,
	register16, register17, register18, register19, register20, register21, register22, register23,
	register24, register25, register26, register27, register28, register29, register30, register31
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
        data_readRegB,                  // I: Data from port B of regfile
		  
		  alu1out, mux1out, signout, rwdout, dmwe2, bne_extend, temp_q_extend, pc_alu_result,
		  temp_q2_1, temp_q3, temp_q4, reverse_isLessThan, blt_mux, isLessThan
    );

endmodule

