module ctrl_logic (op, ctrl, addi_signal, sw_signal, lw_signal); //change andisignal 
    input [4:0] op;
	 output [15:0] ctrl;
	 output addi_signal, sw_signal, lw_signal;
	
	

	wire a1, a2, a3, a4,a5;
	wire and1, and2;
	

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
	

	
	
	//br_blt, setx, r30, all0, rsmux, pc2_signal, pc1_signal, jal_signal, r31, br, dmwe, aluinb, dmwe[o], rwe, rdst, rwd
	assign ctrl = a1 ? 16'b0000000000000100: a2 ? 16'b0000000000010110: a3 ? 16'b0000000000010111: a4 ? 16'b0000000000111001 : a5 ? 16'b0000001000000100: a6 ? 16'b0000000001001100 : a7 ? 16'b0000001110000100: a8 ? 16'b0000010000001100 : a9 ? 16'b1000000000001100: a10 ? 16'b0001100001000100 :a11 ?16'b0110000000000100 : 16'b0;
	and (and1, op[2], op[0]);
	and (addi_signal, and1, ~op[1]);
	
	//for sw
	and (and2, op[0], op[1]);
	and (sw_signal, and2, op[2]);
	
	//for lw
	assign lw_signal = op[3];
   

endmodule 

