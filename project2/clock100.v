// Divides down a 50MHz clock to 100Hz

module clock100(clk50M,clk100);
	parameter divisor = 250_000;
	input clk50M;
	output clk100;
	reg [18:0] count;
	always @(posedge clk50M) begin
		if(count >= 2*divisor - 1)
			count <= 0;
		else
			count <= count + 1'b1;
	end
	assign clk100 = (count < divisor) ? 1'b0 : 1'b1;
endmodule