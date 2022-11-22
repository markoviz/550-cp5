/**
 * READ THIS DESCRIPTION!
 *
 * The processor takes in several inputs from a skeleton file.
 *
 * Inputs
 * clock: this is the clock for your processor at 50 MHz
 * reset: we should be able to assert a reset to start your pc from 0 (sync or
 * async is fine)
 *
 * Imem: input data from imem
 * Dmem: input data from dmem
 * Regfile: input data from regfile
 *
 * Outputs
 * Imem: output control signals to interface with imem
 * Dmem: output control signals and data to interface with dmem
 * Regfile: output control signals and data to interface with regfile
 *
 * Notes
 *
 * Ultimately, your processor will be tested by subsituting a master skeleton, imem, dmem, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file acts as a small wrapper around your processor for this purpose.
 *
 * You will need to figure out how to instantiate two memory elements, called
 * "syncram," in Quartus: one for imem and one for dmem. Each should take in a
 * 12-bit address and allow for storing a 32-bit value at each address. Each
 * should have a single clock.
 *
 * Each memory element should have a corresponding .mif file that initializes
 * the memory element to certain value on start up. These should be named
 * imem.mif and dmem.mif respectively.
 *
 * Importantly, these .mif files should be placed at the top level, i.e. there
 * should be an imem.mif and a dmem.mif at the same level as process.v. You
 * should figure out how to point your generated imem.v and dmem.v files at
 * these MIF files.
 *
 * imem
 * Inputs:  12-bit address, 1-bit clock enable, and a clock
 * Outputs: 32-bit instruction
 *
 * dmem
 * Inputs:  12-bit address, 1-bit clock, 32-bit data, 1-bit write enable
 * Outputs: 32-bit data at the given address
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
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
	 
	 alu1out, mux1out, signout, rwdout, dmwe2
);
    // Control signals data_operandA
    input clock, reset;

    // Imem
    output [11:0] address_imem;
    input [31:0] q_imem;

    // Dmem
    output [11:0] address_dmem;
    output [31:0] data;
    output wren;
    input [31:0] q_dmem;

    // Regfile
    output ctrl_writeEnable;
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    input [31:0] data_readRegA, data_readRegB;

    /* YOUR CODE STARTS HERE */
    //ctrl_logic
    //signextend17
    //dffe_ref
    //pc_12
    //mux2to132
    //regfile
    //address_dmem
	 
	 wire [14:0] ctrl_logic_code;
	 wire addi_signal;
	 wire sw_signal;
	 wire lw_signal;
	 
	 ctrl_logic ctr(q_imem[31:27], ctrl_logic_code, addi_signal, sw_signal, lw_signal);// output [4:0] ctrl_logic;
	 
	 output [31:0] signout;
	 
	 signextend17 s100(q_imem[16:0], signout);
	 
	 
	 
	 output [31:0]alu1out;
	 output [31:0] mux1out;
	 output dmwe2;
	 
	 wire[31:0]  temp_mux1out;
	 assign temp_mux1out = ctrl_logic_code[4] ? signout : data_readRegB; 
	 ///aluinb
	 
	 wire all0;
	 assign all0 = ctrl_logic_code[12];
	 assign mux1out = all0 ? 32'd0 : temp_mux1out;
	 
	 
	 wire isNotEqual, isLessThan, overflow, itype_signal;///
	 wire [4:0] alu_opcode;
	 
	 //assign addi, sw, lw aluopcode = 00000
	 wire or1;
	 or (or1, addi_signal, sw_signal);
	 or (itype_signal, or1, lw_signal);
	 assign alu_opcode = itype_signal ? 5'd0 : q_imem[6:2];
	 
	 
	 ///
	 alu a0(data_readRegA, mux1out, alu_opcode, q_imem[11:7],  alu1out, isNotEqual, isLessThan, overflow);
    
	 //imem
	 wire [11:0] temp_q, q, d, temp_q1;
	 wire [11:0] a_shrink_t, pc_alu_result_shrink, d_extend;
	 wire pc1_signal, bne_mux;
	 wire cout;
	 wire isNotEqual1, isLessThan1, overflow1;
	 wire [31:0] bne_extend, temp_q_extend, pc_alu_result;
	
	 ///assign d = q + 12'd1;
	 rca r1(q, 12'd1, 0, cout, d);
	 //get t for j and jal
	 assign a_shrink_t = q_imem[11:0];
	 assign pc1_signal = ctrl_logic_code[9];
	 
	 //get pc+n+1
	 wire bne_blt, true_isLessThan, bex_mux;
	 and (true_isLessThan, isNotEqual, ~isLessThan);
	 or (bne_blt, isNotEqual, true_isLessThan);
	 and (bne_mux, bne_blt, ctrl_logic_code[6]);//br
	 
	 and(bex_mux, isNotEqual, ctrl_logic_code[6]);//for bex instruction
	 
	 pc_12 pc1(temp_q, d, clock, 1'b1, reset);
	 
	 //select for j type
	 assign temp_q1 = pc1_signal ? a_shrink_t : temp_q;
	 
	 //jal for data_writereg
	 wire jal_signal;
	 signextend12 s103(d, d_extend);
	 assign jal_signal = ctrl_logic_code[8];
	 
	 
	 //select for bne, br
	 wire [11:0] temp_q2;
	 signextend17 s101(q_imem[16:0], bne_extend);
	 signextend12 s102(temp_q, temp_q_extend);
	 
	 alu a1(bne_extend, temp_q_extend, 5'd0, 5'd0, pc_alu_result, isNotEqual1, isLessThan1, overflow1);
	 
	 assign pc_alu_result_shrink = pc_alu_result[11:0];
	 assign temp_q2 = bne_mux ? pc_alu_result_shrink : temp_q1;
	 
	 // select for jr
	 wire [11:0] temp_data_readRegB, temp_q3, temp_q4;
	 wire pc2_signal;
	 assign pc2_signal = ctrl_logic_code[10];
	 assign temp_data_readRegB = data_readRegB[11:0];
	 assign temp_q3 = pc2_signal ? temp_data_readRegB : temp_q2;
	 
	 // foe bex
	 assign temp_q4 = bex_mux ? a_shrink_t : temp_q3;
	 
	 ////// need assign temp_qx to q first
	 assign address_imem = q;
	 
	 
	 //dmem
	 assign address_dmem = alu1out[11:0];///
	 assign data = data_readRegB;
	 assign wren = ~ctrl_logic_code[5];//dmwe = ctrl_logic[3]
	 
	 
    output [31:0] rwdout;
    // RWD
	 assign rwdout = ctrl_logic_code[0] ? q_dmem : alu1out;///
	 
	 assign ctrl_writeEnable = ctrl_logic_code[2]; // Rwe 
	 
	 
	 //overflow overflow registers
	 wire control2;
	 wire [31:0] mux_out2, mux_out3, mux_out4, temp_data_writeReg, temp_data_writeReg1, temp_data_writeReg2;
	 
	 
	 and (control2, q_imem[2], ctrl_logic_code[2]);
	 
	 
	 //select 1,3
	 assign mux_out2 = addi_signal ? 32'd2 : 32'd1;
	 
	 // select 2, 1/3
	 assign mux_out3 = control2 ? 32'h00000003 : mux_out2;
	 
	 wire nand1, nand2, and1;
	 nor (nand1, q_imem[30], q_imem[28]);
	 nor (nand2, q_imem[3], q_imem[4]);
	 and (and1, nand1, nand2);
	 
	 // select address
	 assign temp_data_writeReg = overflow ? mux_out3: rwdout;
	 assign temp_data_writeReg1 = and1 ? temp_data_writeReg : rwdout;
	 
	 //for jal address selection
	 assign temp_data_writeReg2 = jal_signal ? d_extend : temp_data_writeReg1;
	 
	 // for setx address selection
	 wire [31:0] a_extend_t;
	 wire setx_signal;
	 assign setx_signal = ctrl_logic_code[14];
	 signextend27 s105(q_imem[26:0], a_extend_t);
	 assign data_writeReg = setx_signal ? a_extend_t : temp_data_writeReg2;
	 
	 
	 //bex choose for ctrl_readrega
	 wire [4:0] temp_ctrl_readRegA;
	 wire rs_mux;
	 assign rs_mux = ctrl_logic_code[11];
	 assign temp_ctrl_readRegA = q_imem[21:17]; //$rs
	 assign ctrl_readRegA = rs_mux ? 5'd30 : temp_ctrl_readRegA;
	 
	 
	 assign ctrl_readRegB = ctrl_logic_code[3] ?  q_imem[26:22] : q_imem[16:12]; //rt
	 
	 wire [4:0] temp_rd;
	 wire [4:0] temp_ctrl_writeReg, temp_ctrl_writeReg1, temp_ctrl_writeReg2;
	 wire r31;
	 assign temp_rd = q_imem[26: 22]; // temp_rd
	 
	 assign r31 = ctrl_logic_code[7]; //r31
	 
	 //assign temp_ctrl_writeReg = ctrl_logic_code[0] ? temp_rd : temp_ctrl_writeReg;  
	 //assign ctrl_writeReg =overflow ? 5'b11110 : temp_ctrl_writeReg; //select $rstatus and $rd
	 assign temp_ctrl_writeReg = overflow ? 5'b11110 : temp_rd; //select $rstatus and $rd
	
	 assign temp_ctrl_writeReg1 = and1 ? temp_ctrl_writeReg : temp_rd;
	 
	 assign temp_ctrl_writeReg2 = r31 ? 5'd31 : temp_ctrl_writeReg1;
	 
	 // setx
	 wire r30;//r30
	 assign r30 = ctrl_logic_code[13];
	 assign ctrl_writeReg = r30 ? 5'd30 : temp_ctrl_writeReg2;
	 
	 
	 
endmodule


