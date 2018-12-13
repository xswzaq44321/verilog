module lab2(clk,Reset,in,out);
	
	input clk,in,Reset;
	output [6:0] out;
	
	//reg [6:0] out;
	reg [2:0] State,NextState;
	//wire [6:0] tout;
	wire div_clk;
	parameter S0=0,S1=1,S2=2,S3=3,S4=4,S5=5;
	
	clk_div c1(.clk(clk),.rst(Reset),.div_clk(div_clk));
	sevenDIS DIS(.in(State),.out(out));
	
always@(posedge div_clk)
begin
		if(Reset)
			State <= S0;
		else
		begin
			State <= NextState;
			case(State)
		S0:begin
				if(in)
					NextState = S1;
				else
					NextState = S0;
			end
		S1:begin
				if(in)
					NextState = S2;
				else
					NextState = S0;
			end
		S2:begin
				if(in)
					NextState = S4;
				else
					NextState = S3;
			end
		S3:begin
				if(in)
					NextState = S3;
				else
					NextState = S4;
			end
		S4:begin
				if(in)
					NextState = S5;
				else
					NextState = S0;
			end
		S5:begin
				if(in)
					NextState = S5;
				else
					NextState = S2;
			end
		
	endcase
		end
		//out <= tout;
end
/*always@(State)
begin
	case(State)
		S0:begin
				if(in)
					NextState = S1;
				else
					NextState = S0;
			end
		S1:begin
				if(in)
					NextState = S2;
				else
					NextState = S0;
			end
		S2:begin
				if(in)
					NextState = S4;
				else
					NextState = S3;
			end
		S3:begin
				if(in)
					NextState = S3;
				else
					NextState = S4;
			end
		S4:begin
				if(in)
					NextState = S5;
				else
					NextState = S0;
			end
		S5:begin
				if(in)
					NextState = S5;
				else
					NextState = S2;
			end
		
	endcase
end*/	
endmodule 

`define TimeExpire 32'd25000000

module clk_div(clk,rst,div_clk);
	input clk,rst;
	output div_clk;
	
	reg div_clk;
	reg[31:0] count;
	
	always@(posedge clk)
	begin
		if(rst)
		begin
			count <= 32'd0;
			div_clk <= 1'b0;
		end
		else
		begin
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
	end
	
endmodule 

module sevenDIS(in,out);
	input [2:0]in;
	output [6:0]out;
	
	reg [6:0]out;

	always@(in)
	begin
		case(in)
			0:out <= 7'b1000000;
			1:out <= 7'b1111001;
			2:out <= 7'b0100100;
			3:out <= 7'b0110000;
			4:out <= 7'b0011001;
			5:out <= 7'b0010010;
			default: out <= out;
		endcase 
	end
endmodule 
