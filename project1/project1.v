module project1(sw,d0,d1,d2dp,d2,d3,led);
	parameter n = 2;
	input [9:0] sw;
	output [6:0] d0;
	output [6:0] d1;
	output d2dp;
	output [6:0] d2;
	output [6:0] d3;
	output [9:0] led;
	
	wire [9:0] sw;
	wire [6:0] d0;
	wire [6:0] d1;
	wire [9:0] led;
	wire GT, EQ, LT;
	
	assign d2dp = ~sw[9] | sw[8];
	assign led[9:5] = {5{GT | EQ}};
	assign led[4:0] = {5{LT | EQ}};
	
	seven_segment DISP0(sw[3:0],d0,d1,sw[8],sw[9]);
	seven_segment DISP1(sw[7:4],d2,d3,sw[8],sw[9]);
	comp_2n COMP(sw[7:4],sw[3:0],GT,EQ,LT,sw[8]);
	defparam COMP.n = n;
	
endmodule
