module puntaje(vidasi, vidasd,x,y,rgb);

	input vidasi;
	input vidasd;
	input x;
	input y;
	output [2:0] rgb;

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

	case (vidasi)

		7:begin
			if ((x>=i1 & x<=i1+w & y>=5 & y <=5+w)|(x>=i2 & x<=i2+w & y>=5 & y <=5+w)|(x>=i3 & x<=i3+w & y>=5 & y <=5+w)|(x>=i4 & x<=i4+w & y>=5 & y <=5+w)|(x>=i5 & x<=i5+w & y>=5 & y <=5+w)|(x>=i6 & x<=i6+w & y>=5 & y <=5+w)|(x>=i7 & x<=i7+w & y>=5 & y <=5+w))rgb=0;
			else if(x<=220 & y<10) rgb=3'b111;
			end
		6:begin
			if ((x>=i1 & x<=i1+w & y>=5 & y <=5+w)|(x>=i2 & x<=i2+w & y>=5 & y <=5+w)|(x>=i3 & x<=i3+w & y>=5 & y <=5+w)|(x>=i4 & x<=i4+w & y>=5 & y <=5+w)|(x>=i5 & x<=i5+w & y>=5 & y <=5+w)|(x>=i6 & x<=i6+w & y>=5 & y <=5+w))rgb=0;
			else if(x<=220 & y<10) rgb=3'b111;
			end
		5:begin
			if ((x>=i1 & x<=i1+w & y>=5 & y <=5+w)|(x>=i2 & x<=i2+w & y>=5 & y <=5+w)|(x>=i3 & x<=i3+w & y>=5 & y <=5+w)|(x>=i4 & x<=i4+w & y>=5 & y <=5+w)|(x>=i5 & x<=i5+w & y>=5 & y <=5+w))rgb=0;
			else if(x<=220 & y<10) rgb=3'b111;
			end
		4:begin
			if ((x>=i1 & x<=i1+w & y>=5 & y <=5+w)|(x>=i2 & x<=i2+w & y>=5 & y <=5+w)|(x>=i3 & x<=i3+w & y>=5 & y <=5+w)|(x>=i4 & x<=i4+w & y>=5 & y <=5+w))rgb=0;
			else if(x<=220 & y<10) rgb=3'b111;
			end
		3:begin
			if ((x>=i1 & x<=i1+w & y>=5 & y <=5+w)|(x>=i2 & x<=i2+w & y>=5 & y <=5+w)|(x>=i3 & x<=i3+w & y>=5 & y <=5+w))rgb=0;
			else if(x<=220 & y<10) rgb=3'b111;
			end
		2:begin
			if ((x>=i1 & x<=i1+w & y>=5 & y <=5+w)|(x>=i2 & x<=i2+w & y>=5 & y <=5+w))rgb=0;
			else if(x<=220 & y<10) rgb=3'b111;
			end
		1:begin
			if (x>=i1 & x<=i1+w & y>=5 & y <=5+w)rgb=0;
			else if(x<=220 & y<10) rgb=3'b111;
			end
		0: begin
			if(x<=220 & y<10) rgb=3'b111;
			end
	endcase

	case (vidasd)

		7:begin
			if ((x>=d1-w & x<=d1 & y>=5 & y <=5+w)|(x>=d2-w & x<=d2 & y>=5 & y <=5+w)|(x>=d3-w & x<=d3 & y>=5 & y <=5+w)|(x>=d4-w & x<=d4 & y>=5 & y <=5+w)|(x>=d5-w & x<=d5 & y>=5 & y <=5+w)|(x>=d6-w & x<=d6 & y>=5 & y <=5+w)|(x>=d7-w & x<=d7 & y>=5 & y <=5+w))rgb=0;
			else if(x>=220 & y<10) rgb=3'b111;
			end
		6:begin
			if ((x>=d1-w & x<=d1 & y>=5 & y <=5+w)|(x>=d2-w & x<=d2 & y>=5 & y <=5+w)|(x>=d3-w & x<=d3 & y>=5 & y <=5+w)|(x>=d4-w & x<=d4 & y>=5 & y <=5+w)|(x>=d5-w & x<=d5 & y>=5 & y <=5+w)|(x>=d6-w & x<=d6 & y>=5 & y <=5+w))rgb=0;
			else if(x>=220 & y<10) rgb=3'b111;
			end
		5:begin
			if ((x>=d1-w & x<=d1 & y>=5 & y <=5+w)|(x>=d2-w & x<=d2 & y>=5 & y <=5+w)|(x>=d3-w & x<=d3 & y>=5 & y <=5+w)|(x>=d4-w & x<=d4 & y>=5 & y <=5+w)|(x>=d5-w & x<=d5 & y>=5 & y <=5+w))rgb=0;
			else if(x>=220 & y<10) rgb=3'b111;
			end
		4:begin
			if ((x>=d1-w & x<=d1 & y>=5 & y <=5+w)|(x>=d2-w & x<=d2 & y>=5 & y <=5+w)|(x>=d3-w & x<=d3 & y>=5 & y <=5+w)|(x>=d4-w & x<=d4 & y>=5 & y <=5+w))rgb=0;
			else if(x>=220 & y<10) rgb=3'b111;
			end
		3:begin
			if ((x>=d1-w & x<=d1 & y>=5 & y <=5+w)|(x>=d2-w & x<=d2 & y>=5 & y <=5+w)|(x>=d3-w & x<=d3 & y>=5 & y <=5+w))rgb=0;
			else if(x>=220 & y<10) rgb=3'b111;
			end
		2:begin
			if ((x>=d1-w & x<=d1 & y>=5 & y <=5+w)|(x>=d2-w & x<=d2 & y>=5 & y <=5+w))rgb=0;
			else if(x>=220 & y<10) rgb=3'b111;
			end
		1:begin
			if ((x>=d1-w & x<=d1 & y>=5 & y <=5+w))rgb=0;
			else if(x>=220 & y<10) rgb=3'b111;
			end
		0: begin
			if(x>=220 & y<10) rgb=3'b111;
			end
		default:begin
			if(x>=0 & x<= 640 & y >=0 & y<=10) rgb =3'b111;
			end
	endcase

endmodule