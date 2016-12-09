module seven_segment(sw,d0,d1,NEG,DEC);
	input [3:0] sw;
	input NEG;
	input DEC;
	output [6:0] d0;
	output [6:0] d1;
	
	reg [6:0] d0;
	reg [6:0] d1;
	
	always @(*)
	begin
		if(DEC == 0 && NEG == 0) // normal operation: positive numbers displayed as hex
		begin
			d0[0] = (~sw[3]&~sw[2]&~sw[1]&sw[0]) | (~sw[3]&sw[2]&~sw[1]&~sw[0]) | (sw[3]&~sw[2]&sw[1]&sw[0]) | (sw[3]&sw[2]&~sw[1]&sw[0]);
			d0[1] = (sw[2]&sw[1]&~sw[0]) | (sw[3]&sw[1]&sw[0]) | (sw[3]&sw[2]&~sw[0]) | (~sw[3]&sw[2]&~sw[1]&sw[0]);
			d0[2] = (sw[3]&sw[2]&~sw[0]) | (sw[3]&sw[2]&sw[1]) | (~sw[3]&~sw[2]&sw[1]&~sw[0]);
			d0[3] = (sw[2]&sw[1]&sw[0]) | (~sw[3]&~sw[2]&~sw[1]&sw[0]) | (~sw[3]&sw[2]&~sw[1]&~sw[0]) | (sw[3]&~sw[2]&sw[1]&~sw[0]);
			d0[4] = (~sw[3]&sw[0]) | (~sw[2]&~sw[1]&sw[0]) | (~sw[3]&sw[2]&~sw[1]);
			d0[5] = (~sw[3]&~sw[2]&sw[0]) | (~sw[3]&~sw[2]&sw[1]) | (~sw[3]&sw[1]&sw[0]) | (sw[3]&sw[2]&~sw[1]&sw[0]);
			d0[6] = (~sw[3]&~sw[2]&~sw[1]) | (~sw[3]&sw[2]&sw[1]&sw[0]) | (sw[3]&sw[2]&~sw[1]&~sw[0]);
			d1[0] = 1;
			d1[1] = 1;
			d1[2] = 1;
			d1[3] = 1;
			d1[4] = 1;
			d1[5] = 1;
			d1[6] = 1;
		end
		else if(DEC == 1 && NEG == 0) // positive numbers displayed as decimal
		begin
			d0[0] = (sw[2]|sw[0]) & (sw[3]|~sw[1]) & (~sw[2]|~sw[0]) & (~sw[3]|sw[1]);
			d0[1] = (~sw[3]&sw[2]&~sw[1]&sw[0]) | (~sw[3]&sw[2]&sw[1]&~sw[0]) | (sw[3]&sw[2]&sw[1]&sw[0]);
			d0[2] = (~sw[3]&~sw[2]&sw[1]&~sw[0]) | (sw[3]&sw[2]&~sw[1]&~sw[0]);
			d0[3] = (sw[2]|sw[0]) & (~sw[3]|sw[1]) & (sw[3]|sw[2]|~sw[1]) & (sw[3]|~sw[1]|sw[0]) & (~sw[2]|sw[1]|~sw[0]) & (~sw[3]|~sw[2]|~sw[0]);
			d0[4] = (sw[0])|(~sw[3]&sw[2]&~sw[1])|(sw[3]&sw[2]&sw[1]);
			d0[5] = (~sw[3]&~sw[2]&sw[0]) | (~sw[3]&~sw[2]&sw[1]) | (~sw[3]&sw[1]&sw[0]) | (~sw[2]&sw[1]&sw[0]) | (sw[3]&sw[2]&~sw[1]);
			d0[6] = (~sw[3]&~sw[2]&~sw[1]) | (sw[3]&~sw[2]&sw[1]) | (~sw[3]&sw[2]&sw[1]&sw[0]);
			d1[0] = (sw[3]) & (sw[2]|sw[1]);
			d1[1] = 0;
			d1[2] = 0;
			d1[3] = (sw[3]) & (sw[2]|sw[1]);
			d1[4] = (sw[3]) & (sw[2]|sw[1]);
			d1[5] = (sw[3]) & (sw[2]|sw[1]);
			d1[6] = 1;
		end
		else // negative numbers
		begin
			d0[0] = (sw[2]&~sw[1]&~sw[0]) | (~sw[3]&~sw[2]&~sw[1]&sw[0]) | (sw[3]&sw[2]&sw[1]&sw[0]);
			d0[1] = (sw[3]&~sw[2]&sw[1]) | (~sw[3]&sw[2]&~sw[1]&sw[0]) | (~sw[3]&sw[2]&sw[1]&~sw[0]);
			d0[2] = (~sw[3]&~sw[2]&sw[1]&~sw[0]) | (sw[3]&sw[2]&sw[1]&~sw[0]);
			d0[3] = (~sw[2]&~sw[1]&sw[0]) | (sw[2]&~sw[1]&~sw[0]) | (sw[2]&sw[1]&sw[0]);
			d0[4] = (sw[0]) | (sw[2]&~sw[1]);
			d0[5] = (~sw[3]&~sw[2]&sw[0]) | (~sw[3]&~sw[2]&sw[1]) | (~sw[3]&sw[1]&sw[0]) | (sw[3]&~sw[1]&sw[0]) | (sw[3]&sw[2]&sw[1]);
			d0[6] = (~sw[3]&~sw[2]&~sw[1]) | (~sw[2]&~sw[1]&sw[0]) | (sw[2]&sw[1]&sw[0]);
			d1[0] = 1;
			d1[1] = 1;
			d1[2] = 1;
			d1[3] = 1;
			d1[4] = 1;
			d1[5] = 1;
			d1[6] = ~sw[3];
		end
	end
	
endmodule
