// Divides down a 50MHz clock to 1Hz

module clock1(clk50M,clk1);
	parameter divisor = 25_000_000;
	input clk50M;
	output clk1;
	reg [26:0] count;
	always @(posedge clk50M) begin
		if(count >= 2*divisor - 1)
			count <= 0;
		else
			count <= count + 1'b1;
	end
	assign clk1 = (count < divisor) ? 1'b0 : 1'b1;
endmodule