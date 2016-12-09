`timescale 1ns/1ns
module comp_2n_tb();
	parameter n = 2;

	reg clk;
	reg [4*n - 1:0] count;
	wire [2*(n-1) + 1:0] x;
	wire [2*(n-1) + 1:0] y;
	wire GTo, EQo, LTo;
	
	initial begin
	   clk = 1;
	   count = -1;
	end
	
	assign {x,y} = count;
	comp_2n MUT(x,y,GTo,EQo,LTo);
	defparam MUT.n = n;
	
	always #1 clk = ~clk;
	always @(posedge clk)
	begin
		count = count + 1;
		if((x > y) != GTo || (x < y) != LTo || (x == y) != EQo)
		    $display ("x=%b, y=%b, GTo=%b, EQo=%b, LTo=%b",x,y,GTo,EQo,LTo);
	end
	
endmodule
