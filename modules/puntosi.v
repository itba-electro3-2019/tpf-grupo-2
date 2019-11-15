module puntaje(vidasi,x,y,rgbi);

	input vidasi;
	input x;
	input y;
	output [2:0] rgbi;
	
	localparam w = 5;
	localparam i1 = 10;
	localparam i2 = 20;
	localparam i3 = 30;
	localparam i4 = 40;
	localparam i5 = 50;
	localparam i6 = 60;
	localparam i7 = 70;
	
	wire pi1,pi2,pi3,pi4,pi5,pi6,pi7;
	reg [2:0]rgb_regi;
	
	assign pi1 = ((x>=i1) && (x<=i1+w) && (y>=5) && (y <=5+w))?1:0;
	assign pi2 = ((x>=i2) && (x<=i2+w) && (y>=5) && (y <=5+w))?1:0;
	assign pi3 = ((x>=i3) && (x<=i3+w) && (y>=5) && (y <=5+w))?1:0;
	assign pi4 = ((x>=i4) && (x<=i4+w) && (y>=5) && (y <=5+w))?1:0;
	assign pi5 = ((x>=i5) && (x<=i5+w) && (y>=5) && (y <=5+w))?1:0;
	assign pi6 = ((x>=i6) && (x<=i6+w) && (y>=5) && (y <=5+w))?1:0;
	assign pi7 = ((x>=i7) && (x<=i7+w) && (y>=5) && (y <=5+w))?1:0;
	case (vidasi)
		
		7 : begin
			assign rgb_regi = (pi1||pi2||pi3||pi4||pi5||pi6||pi7)?0:3'b111;
			end
		6 : begin
			assign rgb_regi = (pi1||pi2||pi3||pi4||pi5||pi6)?0:3b'111;
			end
		5 : begin
			assign rgb_regi = (pi1||pi2||pi3||pi4||pi5)?0:3b'111;
			end
		4 : begin
			assign rgb_regi = (pi1||pi2||pi3||pi4)?0:3b'111;
			end
		3:begin
			assign rgb_regi = (pi1||pi2||pi3)?0:3b'111;
			end
		2:begin
			assign rgb_regi = (pi1||pi2)?0:3b'111;
			end
		1:begin
			assign rgb_regi = (pi1)?0:3b'111;
			end
		0: begin
			if(x<=220 && y<10) begin
			assign rgb_regi = 3'b111;
			end
			end
		default:begin 
			if(x>=0 && x<= 640 && y >=0 && y<=10) assign rgb_regi =3'b111;
			end
	endcase
	assign rgbi = rgb_regi;
	
endmodule