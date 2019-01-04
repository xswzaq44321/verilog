module road_furious(
	input up,
	input down,
	input clock,
	input reset,
	output reg [7:0] row,
	output reg [7:0] col
);
integer frogindex;
wire[7:0] obsticles_row;
wire[7:0] obsticles_col;
reg moved;
reg display_switch;
integer i, j;
river RIVER(.clk(clock),.reset(reset),.out_row(obsticles_row),.out_col(obsticles_col));

initial 
begin
	frogindex = 0;
	display_switch = 0;
end

always@(clock)
begin
	if(display_switch == 0)
	begin
		display_switch <= 1;
		row = obsticles_row;
		col = obsticles_col;
	end
	else
	begin
		display_switch <= 0;
		row = 8'b11111111;
		col = 8'b00000000;
		col[4] = 1;
		row[frogindex] = 0;
	end
	
	if(reset)
	begin
		frogindex = 0;
	end
	else
	begin
		if(up && down)
		begin
			moved = 0;
		end
		else
		begin
		end
		if(!up && moved == 0)
		begin
			moved = 1;
			if(frogindex < 7)
			begin
				frogindex = frogindex + 1;
			end
		end
		else
		begin
		end
		if(!down && moved == 0)
		begin
			moved = 1;
			if(frogindex > 0)
			begin
				frogindex = frogindex - 1;
			end
		end
		else
		begin
		end
	end
end

endmodule

`define TimeExpire 32'd25000000

module river(clk,reset,out_row,out_col);

input clk, reset;
output[7:0]out_row,out_col;//dot matrix
reg [31:0]count,count2;
reg [3:0]map, control;
reg [7:0]out_row, out_col;
reg [2:0]button;


always@(posedge clk)
begin
	if(reset)
	begin
		count <= 32'd0;
		map <= 0;
	end
	else
	begin
		if(count == `TimeExpire)
		begin
			count<=32'd0;
			map = map + 1;
			if(map == 4)
				map = 0;
		end
		else
		begin
			count <= count + 32'd1;
		end
		
	end
end

always@(posedge clk)
begin
	if(count2 == 32'd50000)
	begin
		count2 = 32'd0;

		if(map == 4'd0)
		begin
			case (control)
				4'd0:
				begin
					out_col <= 8'b11000000;
					out_row <= 8'b11111101;
				end
				4'd1:
				begin
					out_col <= 8'b00110000;
					out_row <= 8'b11110111;
				end
				4'd2:
				begin
					out_col <= 8'b00001100;
					out_row <= 8'b11011111;
				end
			endcase
		end
		else if(map == 4'd1)
		begin
			case (control)
				4'd0:
				begin
					out_col <= 8'b00110000;
					out_row <= 8'b11111101;
				end
				4'd1:
				begin
					out_col <= 8'b00001100;
					out_row <= 8'b11110111;
				end
				4'd2:
				begin
					out_col <= 8'b00000011;
					out_row <= 8'b11011111;
				end
			endcase
		end
		
		else if(map == 4'd2)
		begin
			case (control)
				4'd0:
				begin
					out_col <= 8'b00001100;
					out_row <= 8'b11111101;
				end
				4'd1:
				begin
					out_col <= 8'b00000011;
					out_row <= 8'b11110111;
				end
				4'd2:
				begin
					out_col <= 8'b11000000;
					out_row <= 8'b11011111;
				end
			endcase
		end
		
		else
		begin
			case (control)
				4'd0:
				begin
					out_col <= 8'b00000011;
					out_row <= 8'b11111101;
				end
				4'd1:
				begin
					out_col <= 8'b11000000;
					out_row <= 8'b11110111;
				end
				4'd2:
				begin
					out_col <= 8'b00110000;
					out_row <= 8'b11011111;
				end
			endcase
		end
		control <= control + 4'd1;
		if(control > 4'd2)
			control <= 4'd0;

	end
	else
		count2 <= count2 + 32'd1;	
end


endmodule
