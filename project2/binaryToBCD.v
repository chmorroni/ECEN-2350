module binaryToBCD(bin,bcd);
	input [7:0] bin;
	output reg [11:0] bcd;
	reg x;
	
	integer i;
	always @(bin) begin
		bcd = 11'b0;
		for(i=7;i>=0;i=i-1) begin
			if(bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 4'd3;
			if(bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 4'd3;
			if(bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 4'd3;
			{x,bcd} = {bcd,bin[i]};
		end
	end
endmodule