module bcdToBinary(bcd,bin);
	input [8:0] bcd;
	output wire signed [7:0] bin;
	reg signed [7:0] temp;
	
	assign bin = temp;
	
	always @(bcd,temp)
		if(bcd[8]) temp = -10 * bcd[7:4] + bcd[3:0];
		else temp = 10 * bcd[7:4] + bcd[3:0];
endmodule