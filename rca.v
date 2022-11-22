module full_adder(a, b, cin1, sum1, cout1);
   input a, b, cin1;
   output sum1, cout1;
	wire xor1, and1, and2;
   xor (xor1, a, b);
   xor (sum1, xor1, cin1);
   and (and1, xor1, cin1);
   and (and2, a, b);
   or (cout1, and1, and2);
endmodule

module rca(in1, in2,cin, cout, sum);
   input cin;
   input [11:0] in1, in2;
   output [11:0] sum;
   output cout;
   wire c1, c2, c3,c4,c5,c6,c7,c8,c9,c10, c11;
   full_adder a1(in1[0], in2[0], cin, sum[0], c1);
   full_adder a2(in1[1], in2[1], c1, sum[1], c2);
   full_adder a3(in1[2], in2[2], c2, sum[2], c3);
   full_adder a4(in1[3], in2[3], c3, sum[3], c4);
	full_adder a5(in1[4], in2[4], c4, sum[4], c5);
	full_adder a6(in1[5], in2[5], c5, sum[5], c6);
	full_adder a7(in1[6], in2[6], c6, sum[6], c7);
	full_adder a8(in1[7], in2[7], c7, sum[7], c8);
	full_adder a9(in1[8], in2[8], c8, sum[8], c9);
	full_adder a10(in1[9], in2[9], c9, sum[9], c10);
	full_adder a11(in1[10], in2[10], c10, sum[10], c11);
	full_adder a12(in1[11], in2[11], c11, sum[11], cout);
	
endmodule
   