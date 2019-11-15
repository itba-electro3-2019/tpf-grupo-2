module Imagen( 
    input clk, reset, 
    input [9:0]posx, 
    input [9:0]posy,
    input [9:0]posbarraiy,
    input [9:0]posbarrady,
	input [2:0]vidasi,
	input [2:0]vidasd,
    output hsync, 
	output vsync,
    output [2:0] rgb
    );
    //signal declaration
    reg [2:0] rgb_reg;
    wire video_on;
    wire [9:0] x,y;
 
	//PRUEBA
	localparam w = 5;
	localparam i1 = 10;
	localparam i2 = 20;
	localparam i3 = 30;
	localparam i4 = 40;
	localparam i5 = 50;
	localparam i6 = 60;
	localparam i7 = 70;
	localparam d1 = 630;
	localparam d2 = 620;
	localparam d3 = 610;
	localparam d4 = 600;
	localparam d5 = 590;
	localparam d6 = 580;
	localparam d7 = 570;
	
	wire pi1,pi2,pi3,pi4,pi5,pi6,pi7;
	wire pd1,pd2,pd3,pd4,pd5,pd6,pd7;
	
 
    //instantiate vga sync circuit
    vga_sync vsync_unit (.clk(clk), .hsync(hsync), . vsync(vsync), .pixel_x(x), .pixel_y(y));
	
	assign pi1 = ((x>=i1) && (x<=i1+w) && (y>=5) && (y <=5+w))?1:0;
	assign pi2 = ((x>=i2) && (x<=i2+w) && (y>=5) && (y <=5+w))?1:0;
	assign pi3 = ((x>=i3) && (x<=i3+w) && (y>=5) && (y <=5+w))?1:0;
	assign pi4 = ((x>=i4) && (x<=i4+w) && (y>=5) && (y <=5+w))?1:0;
	assign pi5 = ((x>=i5) && (x<=i5+w) && (y>=5) && (y <=5+w))?1:0;
	assign pi6 = ((x>=i6) && (x<=i6+w) && (y>=5) && (y <=5+w))?1:0;
	assign pi7 = ((x>=i7) && (x<=i7+w) && (y>=5) && (y <=5+w))?1:0;
	
	assign pd1 = (x>=d1-w && x<=d1 && y>=5 && y <=5+w)?1:0;
	assign pd2 = (x>=d2-w && x<=d2 && y>=5 && y <=5+w)?1:0;
	assign pd3 = (x>=d3-w && x<=d3 && y>=5 && y <=5+w)?1:0;
	assign pd4 = (x>=d4-w && x<=d4 && y>=5 && y <=5+w)?1:0;
	assign pd5 = (x>=d5-w && x<=d5 && y>=5 && y <=5+w)?1:0;
	assign pd6 = (x>=d6-w && x<=d6 && y>=5 && y <=5+w)?1:0;
	assign pd7 = (x>=d7-w && x<=d7 && y>=5 && y <=5+w)?1:0;
 
    //rgb buffer
     always @(posedge clk, posedge reset) begin
        if (reset) rgb_reg <= 0;
        else begin
            if (x>posx & x<(12+posx) & y>posy & y<(12+posy)) rgb_reg<=3'b111;
            else if (x>=0 & x<=10 & y>=0 & y<=480) rgb_reg<=3'b010;
            else if (x>=630 & x<=640 & y>=0 & y<=480) rgb_reg<=3'b010;
            else if (x>=0 & x<=320 & y>=0 & y<=10) begin 											//Dibuja las vidas del jugador de la izquierda
				case (vidasi)
		
					7 : begin
						if (pi1|pi2|pi3|pi4|pi5|pi6|pi7)rgb_reg = 3'b011;
						else if(x<=220 & y<=10) rgb_reg=3'b010;
						end
					6 : begin
						if (pi1|pi2|pi3|pi4|pi5|pi6)rgb_reg = 3'b011;
						else if(x<=220 & y<=10) rgb_reg=3'b010;
						end
					5 : begin
						if (pi1|pi2|pi3|pi4|pi5)rgb_reg = 3'b011;
						else if(x<=220 & y<=10) rgb_reg= 3'b010;
						end
					4 : begin
						if (pi1|pi2|pi3|pi4)rgb_reg = 3'b011;
						else if(x<=220 & y<=10) rgb_reg=3'b010;
						end
					3:begin
						if (pi1|pi2|pi3)rgb_reg = 3'b011;
						else if(x<=220 & y<=10) rgb_reg=3'b010;
						end
					2:begin
						if (pi1|pi2)rgb_reg = 3'b011;
						else if(x<=220 & y<=10) rgb_reg=3'b010;
						end
					1:begin
						if (pi1)rgb_reg = 3'b011;
						else if(x<=220 & y<=10) rgb_reg=3'b010;
						end
					0: begin
						if(x<=220 & y<=10) rgb_reg = 3'b010;
						end
					default:begin 
						if(x>=0 & x<= 640 & y >=0 & y<=10) rgb_reg =3'b111;
						end
				endcase
			end
			else if (x>=320 & x<=640 & y>=0 & y<=10) begin
				case (vidasd)    														//Dibuja las vidas del jugador de la derecha
		
					7:begin
						if (pd1|pd2|pd3|pd4|pd5|pd6|pd7) rgb_reg=3'b011;
						else if(x>=220 & y<=10) rgb_reg=3'b010;
						end
					6:begin
						if (pd1|pd2|pd3|pd4|pd5|pd6) rgb_reg=3'b011;
						else if(x>=220 & y<=10) rgb_reg=3'b010;
						end
					5:begin
						if (pd1|pd2|pd3|pd4|pd5) rgb_reg=3'b011;
						else if(x>=220 & y<=10) rgb_reg=3'b010;
						end
					4:begin
						if (pd1|pd2|pd3|pd4) rgb_reg=3'b011;
						else if(x>=220 & y<=10) rgb_reg=3'b010;
						end
					3:begin
						if (pd1|pd2|pd3) rgb_reg=3'b011;
						else if(x>=220 & y<=10) rgb_reg=3'b010;
						end
					2:begin
						if (pd1|pd2) rgb_reg=3'b011;
						else if(x>=220 & y<=10) rgb_reg=3'b010;
						end
					1:begin
						if (pd1) rgb_reg=3'b011;
						else if(x>=220 & y<=10) rgb_reg=3'b010;
						end
					0: begin
						if(x>=220 & y<=10) rgb_reg=3'b010;
						end
					default:begin 
						if(x>=0 & x<= 640 & y >=0 & y<=10) rgb_reg =3'b111;
						end
				endcase
			end
            else if (x>=0 & x<=640 & y>=470 & y<=480) rgb_reg<=3'b010;
            else if (y>=posbarraiy & y<=(100+posbarraiy) & x>=30 & x<=40) rgb_reg<=3'b110;
            else if (y>=posbarrady & y<=(100+posbarrady) & x>=600 & x<=610) rgb_reg<=3'b101;
            else rgb_reg <= 3'b000;
        end
    end
 
    // output
    //assign rgb = (video_on) ? rgb_reg : 3'b000;
	assign rgb = rgb_reg;
endmodule