// 

module lfsr(Q,g,clk,S,set);
	parameter N = 21;
	output [9:1] Q;
	input [N:1] g, S;
	input clk, set;
	reg [N:1] Ql;
	wire f;
	assign f = ^(g & Ql);
	assign Q = Ql[9:1];
	always @(posedge clk, negedge set)
		if (!set) Ql <= S;
		else Ql <= {Ql[N-1:1],f};
endmodule