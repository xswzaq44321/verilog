module Lab(
	input clock;
	input reset;
	input [0:3] in;
	output [0:6] out;
)
	output reg signal;
	input reg [0:3] tmp;
	sevenDisplay DIS(.data(tmp), .out(out));
	clk_div TIMER(.clk(clock), .rst(reset), .div_clk(signal));
	always@ (signal)
	begin
		if(!reset)
		begin
			tmp <= 0;
		end
		else
		begin
			tmp <= tmp + in;
		end
	end
endmodule

module sevenDisplay(
	input[0:3] data;
	output[0:6] out;
)
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
		default: out <= 7'b0000110;
	endcase
endmodule

`define TimeExpire 32'd25000000
module clk_div(
	input clk, rst;
	output div_clk;
)
	reg div_clk;
	reg [31:0] count;
	always@(posedge clk)
	begin
		if(!rst)
		begin
			count <= 32'd0;
			div_clk <= 1'b0;
		end
		if(count == TimeExpire)
		begin
			count <= 32'b0;
			div_clk <= ~div_clk;
		end
		else
		begin
			count <= count + 32'b1;
		end
	end
endmodule
