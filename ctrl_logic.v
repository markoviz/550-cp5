module ctrl_logic (op, ctrl, addi_signal); //change andisignal 
    input [4:0] op;
	 output [14:0] ctrl;
	 output addi_signal;
	
	

	wire a1, a2, a3, a4,a5;
	wire and1;
	

	assign a1 = ~op[4] & ~ op[3] & ~op[2] & ~op[1] & ~op[0];//add
	assign a2 = ~op[4] & ~ op[3] &  op[2] & ~op[1] &  op[0];//addi
	assign a3 = ~op[4] &   op[3] & ~op[2] & ~op[1] & ~op[0];//lw
	assign a4 = ~op[4] & ~ op[3] &  op[2] &  op[1] &  op[0];//sw
	assign a5 = ~op[4] & ~ op[3] & ~op[2] & ~op[1] &  op[0];//j
	assign a6 = ~op[4] & ~ op[3] & ~op[2] &  op[1] & ~op[0];//bne
	assign a7 = ~op[4] & ~ op[3] & ~op[2] &  op[1] &  op[0];//jal
	assign a8 = ~op[4] & ~ op[3] &  op[2] & ~op[1] & ~op[0];//jr
	assign a9 = ~op[4] & ~ op[3] &  op[2] &  op[1] & ~op[0];//blt
	assign a10 =  op[4] &  ~op[3] &  op[2] &  op[1] & ~op[0];//bex
	assign a11 =  op[4] &  ~op[3] &  op[2] & ~op[1] &  op[0];//setx
	


	
	
	// aluinb, dmwe, rwe, rdst, rwd
	assign ctrl = a1 ? 000000000000100: a2 ? 000000000010110: a3 ? 000000000010111: a4 ? 000000000111001 : a5 ? 000001000000100: a6 ? 000000001011100 : a7 ? 000001110000100: a8 ? 000010000001100 : a9 ? 000100001011100: a10 ? 001101001000100 :a11 ?110000000000100 : 15'b0;
	and (and1, op[2], op[0]);
	and (addi_signal, and1, ~op[1]);
   
	
endmodule 
