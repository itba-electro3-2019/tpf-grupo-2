//
// square: generate rectangle on screen
//
//////////////////////////////////////////////////////////////////////
module square(x,y,hcount,vcount,pixel);
parameter WIDTH = 64; // default width: 64 pixels
parameter HEIGHT = 64; // default height: 64 pixels
parameter COLOR = 3’b101; // default color: white
input [10:0] x,hcount;
input [9:0] y,vcount;
output [2:0] pixel;
reg [2:0] pixel;
always @ (x or y or hcount or vcount) begin
if ((hcount >= x && hcount < (x+WIDTH)) &&
(vcount >= y && vcount < (y+HEIGHT)))
pixel = COLOR;
else pixel = 0;
end
endmodule
