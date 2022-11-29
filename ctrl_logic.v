module ctrl_logic (op, ctrl, addi_signal, sw_signal, lw_signal); //change andisignal 
    input [4:0] op;
	 output [16:0] ctrl;
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
	assign ctrl = a1 ? 17'b00000000000000100: a2 ? 17'b00000000000010110: a3 ? 17'b00000000000010111: a4 ? 17'b00000000000111001 : a5 ? 17'b00000001000000000: a6 ? 17'b00000000001001000 : a7 ? 17'b00000001110000100: a8 ? 17'b00000010000001000 : a9 ? 17'b01000000000001000: a10 ? 17'b10001100000000000 :a11 ?17'b00110000000000100 : 17'b0;
	
	
	and (and1, op[2], op[0]);
	and (addi_signal, and1, ~op[1]);
	
	//for sw
	and (and2, op[0], op[1]);
	and (sw_signal, and2, op[2]);
	
	//for lw
	assign lw_signal = op[3];
   

endmodule 

