module signextend27 (input [26:0]in, output[31:0] out);
	assign out = {{5{in[26]}}, in};
endmodule 

