module lab1(
	input clock,
	input reset,
	input [3:0] in,
	output [6:0] out
);
	wire signal;
	reg [3:0] acc;
	sevenDisplay DIS(.data(acc), .out(out));
	clk_div TIMER(.clk(clock), .rst(reset), .div_clk(signal));
	always@ (posedge signal)
	begin
		if(!reset)
		begin
			acc <= 0;
		end
		else
		begin
			acc <= acc + in;
		end
	end
endmodule

module sevenDisplay(
	input[3:0] data,
	output reg[6:0] out
);
	always@(data)
	begin
		case (data)
			4'b0000: out <= 7'b1000000;
			4'b0001: out <= 7'b1111001;
			4'b0010: out <= 7'b0100100;
			4'b0011: out <= 7'b0110000;
			4'b0100: out <= 7'b0011001;
			4'b0101: out <= 7'b0010010;
			4'b0110: out <= 7'b0000010;
			4'b0111: out <= 7'b1111000;
			4'b1000: out <= 7'b0000000;
			4'b1001: out <= 7'b0010000;
			4'b1010: out <= 7'b0001000;
			4'b1011: out <= 7'b0000011;
			4'b1100: out <= 7'b1000110;
			4'b1101: out <= 7'b0100001;
			4'b1110: out <= 7'b0000110;
			4'b1111: out <= 7'b0001110;
		endcase
	end
endmodule

`define TimeExpire 32'd25000000

module clk_div(
	input clk, 
	input rst,
	output reg div_clk
);
	reg [31:0] count;
	always@(posedge clk)
	begin
		if(!rst)
		begin
			count <= 32'd0;
			div_clk <= 1'b0;
		end
		if(count == `TimeExpire)
		begin
			count <= 32'd0;
			div_clk <= ~div_clk;
		end
		else
		begin
			count <= count + 32'd1;
		end
	end
endmodule
