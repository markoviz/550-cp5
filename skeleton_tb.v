`timescale 1 ns / 1 ps
module skeleton_tb();

reg clock, reset,errors;
wire imem_clock, dmem_clock, processor_clock, regfile_clock;
wire [11:0] address_imem;
wire [31:0] q_imem;
wire [11:0] address_dmem;
wire [31:0] data;
wire wren, dmwe2;
wire [31:0] q_dmem;
wire ctrl_writeEnable;
wire [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
wire [31:0] data_writeReg;
wire [31:0] data_readRegA, data_readRegB;
wire [31:0] alu_data_result;///double check

wire [31:0] rstatus;
wire [31:0] register0, register1, register2, register3, register4, register5, register6, register7,
	register8, register9, register10, register11, register12, register13, register14, register15,
	register16, register17, register18, register19, register20, register21, register22, register23,
	register24, register25, register26, register27, register28, register29, register30, register31, signout, mux1out, alu1out, rwdout, bne_extend, temp_q_extend, pc_alu_result;

wire [11:0] temp_q2_1, temp_q3, temp_q4;
wire reverse_isLessThan, blt_mux, isLessThan;

	
skeleton skeleton_test(clock, reset, imem_clock, dmem_clock, processor_clock, regfile_clock, address_imem,q_imem,address_dmem,data,wren,q_dmem,ctrl_writeEnable,
					 ctrl_writeReg, ctrl_readRegA, ctrl_readRegB,data_writeReg,data_readRegA, data_readRegB,
					 register0, register1, register2, register3, register4, register5, register6, register7,
	register8, register9, register10, register11, register12, register13, register14, register15,
	register16, register17, register18, register19, register20, register21, register22, register23,
	register24, register25, register26, register27, register28, register29, register30, register31, alu1out, mux1out, signout, rwdout, dmwe2,
	bne_extend, temp_q_extend, pc_alu_result, temp_q2_1, temp_q3, temp_q4, reverse_isLessThan, blt_mux, isLessThan
					 );
					 
			
initial
    begin
        $display($time, " << Starting the Simulation >>");
        clock = 1'b0;    // at time 0  
        errors = 0;

        reset = 1'b1;    // assert reset
        @(negedge clock);    // wait until next negative edge of clock
        @(negedge clock);    // wait until next negative edge of clock

        reset = 1'b0;    // de-assert reset
        @(negedge clock);    // wait until next negative edge of clock

        if (errors == 0) begin
            $display("The simulation completed without errors");
        end
        else begin
            $display("The simulation failed with %d errors", errors);
        end

        
end
			
always
	#10     clock = ~clock;
	
endmodule

