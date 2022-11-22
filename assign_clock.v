module clockdivider(out_clk, clk);
    output reg out_clk;
	 input clk;
	 always @(posedge clk)
	     out_clk <= ~out_clk;
endmodule

module assign_clock(clk, imem_clock, dmem_clock, processor_clock, regfile_clock);
    output imem_clock, dmem_clock, processor_clock, regfile_clock;
	 input clk;
	 
	 wire clk1;
	 
	 clockdivider clkd(clk1, clk);
	 
	 assign imem_clock = clk;///
	 assign dmem_clock = clk;
	 assign processor_clock = clk1;
	 assign regfile_clock = clk1;
	 
endmodule

