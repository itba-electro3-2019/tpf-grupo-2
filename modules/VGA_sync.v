module vga_sync(
	input clk,
	output reg hsync = 1'b1,
	output reg vsync = 1'b1,
	output reg [9:0] pixel_x = 0,
	output reg [9:0] pixel_y = 0 
);

    localparam HD = 640;     // horizontal display area
    localparam HF = 48 ;     // h.front(left)border
    localparam HB = 16 ;     // h.back(right)border
    localparam HR = 96 ;     // h.retrace
    localparam VD = 480;     // vertical display area
    localparam VF = 10;      // v.front(top)border
    localparam VB = 33;      // v.back(bottom)border
    localparam VR = 2;       // v.retrace
	
	wire clk25M;
	pll pll(.ref_clk_i(clk),.rst_n_i(1'b1),.outcore_o(),.outglobal_o(clk25M));
	
	// end of horizontal counter (799)
    assign h_end = (pixel_x==(HD+HF+HB+HR-1));

	always@(posedge clk25M) begin
		if (h_end) begin
			if(pixel_y < VD+VF+VB+VR-1)			
				pixel_y <= pixel_y + 1;
			else pixel_y <= 0;			
		end
	end

	always@(posedge clk25M) begin
		if(pixel_x < HD+HF+HB+HR-1)			
			pixel_x <= pixel_x + 1;
		else 
			pixel_x <= 0;		
	end

	always @(posedge clk25M) begin
		if(pixel_x >= 0 && pixel_x < HD)3
			hsync <= 1;
		else 
			if (pixel_x >= HD && pixel_x < HD+HB)
				hsync <= 1;
			else 
				if (pixel_x >= HD+HB && pixel_x < HD+HB+HR)
					hsync <= 0;
				else 
					if (pixel_x < HD+HB+HF+HR)
						hsync <= 1;
	end

	always @(posedge clk25M) begin
		if(pixel_y <  VD)
			vsync <= 1;
		else 
			if (pixel_y >= VD && pixel_y < VD+VF)
				vsync <= 1;
			else 
				if (pixel_y >= VD+VF && pixel_y < VD+VF+VR)
					vsync <= 0;
				else 
					if (pixel_y < VD+VF+VR+VB)
						vsync <= 1;
	end

endmodule