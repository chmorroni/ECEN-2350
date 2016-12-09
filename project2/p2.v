module p2(sw,bt,ssd3,ssd2,ssd1,ssd0,led,clk50M);
	input [9:0] sw;
	input [2:0] bt;
	input clk50M;
	output reg [6:0] ssd3;
	output reg [6:0] ssd2;
	output reg [6:0] ssd1;
	output reg [6:0] ssd0;
	output reg [9:0] led;
	
	reg [8:0] secretNumber, secretNumber_new;
	reg [7:0] guesses, guesses_new;
	reg [2:0] y, Y;
	reg [27:0] ssd_array;
	wire [8:0] Q, guess;
	wire [13:0] secretNumberSSD;
	wire [11:0] guessesBCD;
	wire [20:0] guessesSSD;
	wire clk100, clk1, start, reset, check;
	localparam S0=3'd0, S1=3'd1, S2=3'd2, S3=3'd3, S4=3'd4;
	
	assign start = bt[2];
	assign reset = bt[0];
	assign check = bt[1];
	assign guess = sw[8:0];
	
	clock100 U0(clk50M, clk100);
	clock1 U1(clk50M, clk1);
	lfsr U2(Q,9'b101111010,clk50M,'b1,check);
	bcdSevenSegment U3(secretNumber[3:0],secretNumberSSD[6:0]);
	bcdSevenSegment U4(secretNumber[7:4],secretNumberSSD[13:7]);
	binaryToBCD U5(guesses,guessesBCD);
	bcdSevenSegment U6(guessesBCD[3:0],guessesSSD[6:0]);
	bcdSevenSegment U7(guessesBCD[7:4],guessesSSD[13:7]);
	bcdSevenSegment U8(guessesBCD[11:8],guessesSSD[20:14]);
	
	always @(*) begin
		guesses_new <= guesses;
		secretNumber_new <= secretNumber;
		ssd_array <= {ssd3,ssd2,ssd1,ssd0};
		led <= 10'b0;
		case(y)
			S0: begin
					 ssd_array <= 28'b1111111_1111111_1111111_1111111;
					 if(start) Y <= S0; else Y <= S1;
				 end
			S1: if(!start) Y <= S1;
				 else begin
					 ssd_array <= 28'b1111111_1111111_1111111_1111111;
					 if(secretNumber[7:4] > 4'b0 && secretNumber[7:4] < 4'b1001 && secretNumber[3:0] > 4'b0 && secretNumber[3:0] < 4'b1001) Y <= S2; else Y <= S1;
					 guesses_new <= 8'b0;
				 end
			S2: begin
					 if(!start) Y <= S4;
					 else if(check) Y <= S2; else Y <= S3;
				 end
			S3: begin
					 if(!check) Y <= S3;
					 else if(secretNumber == guess) begin
						 guesses_new <= guesses + 8'b1;
						 Y <= S4;
					 end
					 else if((!secretNumber[8] && !guess[8] && (secretNumber[7:4] < guess[7:4] || (secretNumber[7:4] == guess[7:4] && secretNumber[3:0] < guess[3:0]))) || 
								(secretNumber[8] && (!guess[8] || secretNumber[7:4] > guess[7:4] || (secretNumber[7:4] == guess[7:4] && secretNumber[3:0] > guess[3:0])))) begin
						 guesses_new <= guesses + 8'b1;
						 ssd_array <= 28'b1000111_0100011_1111111_1111111; //lo
						 Y <= S2;
					 end
					 else begin
						 guesses_new <= guesses + 8'b1;
						 ssd_array <= 28'b0001011_1101111_1111111_1111111; //hi
						 Y <= S2;
					 end
				 end
			S4: begin
					 if(clk1) ssd_array <= {7'b1111111,~secretNumber[8],6'b111111,secretNumberSSD};
					 else begin
						 ssd_array <= {7'b1111111,guessesSSD};
						 led <= 10'b1111111111;
					 end
					 Y <= S4;
				 end
		endcase
	end
	
	always @(posedge clk50M, negedge reset) begin
		{ssd3,ssd2,ssd1,ssd0} <= ssd_array;
		if(!reset) begin
			y = S0;
			secretNumber <= Q[8:0];
		end
		else begin
			y <= Y;
			guesses <= guesses_new;
			if(Y == S1) secretNumber <= Q[8:0];
			else secretNumber <= secretNumber_new;
		end
	end
endmodule