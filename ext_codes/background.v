//////////////////////////////////////////////////////////////////////
//
// background : sprite to draw the static background
//
//////////////////////////////////////////////////////////////////////
module background(hcount,vcount,pixel, vclock, hit_wall);
input [10:0] hcount;
input [9:0] vcount;
input vclock;
output [2:0] pixel;
wire [2:0] pixel;
input[3:0] hit_wall;
parameter NO_WALL = 4’d0;
parameter RIGHT_WALL = 4’d1;
parameter LEFT_WALL = 4’d2;
parameter TOP_WALL = 4’d3;
13
parameter BOTTOM_WALL = 4’d4;
parameter BACK_WALL = 4’d5;
parameter FRONT_WALL = 4’d6;
//wires hold status from lines. Lines also give whether the pixel is above the line or below.
wire toprightlow,toprighthigh,bottomrightlow,bottomrighthigh,topleftlow,toplefthigh,bottomleftlow,bottomlefthigh, aboveback, belowback, inback;
wire [2:0] flash_pixel,back_pixel,back_pixel2,back_pixel3, back_pixel4,topleft_pixel,topright_pixel,bottomright_pixel,bottomleft_pixel;
wire right_wall_zone, left_wall_zone, bottom_wall_zone, top_wall_zone, back_wall_zone;
assign right_wall_zone = bottomrighthigh & toprightlow;
assign left_wall_zone = bottomlefthigh & topleftlow;
assign bottom_wall_zone = bottomleftlow | bottomrightlow | belowback;
assign top_wall_zone = toplefthigh | toprighthigh | aboveback;
assign back_wall_zone = inback;
//Basic mechanism for flashing the walls
assign flash_pixel = (((hit_wall == LEFT_WALL) && left_wall_zone) ||
((hit_wall == RIGHT_WALL) && right_wall_zone) ||
((hit_wall == TOP_WALL) && top_wall_zone) ||
((hit_wall == BOTTOM_WALL) && bottom_wall_zone) ||
((hit_wall == BACK_WALL) && back_wall_zone)) ? 3’b111 : 0;
assign pixel = flash_pixel | back_pixel | topleft_pixel | topright_pixel | back_pixel2 | back_pixel3 | back_pixel4 |
bottomright_pixel | bottomleft_pixel;
//Draw the diagonal lines
drawline topleftline(hcount,vcount,topleft_pixel,vclock, topleftlow, toplefthigh);
drawline toprightline(hcount,vcount,topright_pixel,vclock, toprightlow,toprighthigh);
drawline bottomrightline(hcount,vcount,bottomright_pixel,vclock, bottomrightlow, bottomrighthigh);
drawline bottomleftline(hcount,vcount,bottomleft_pixel,vclock, bottomleftlow,bottomlefthigh);
//Draw the boxes
drawbox backbox(hcount, vcount, back_pixel, vclock, aboveback, belowback, inback);
wire above2,below2, in2, above3, below3, in3, above4,below4,in4;
drawbox backbox2(hcount, vcount, back_pixel2, vclock, above2, below2, in2);
defparam backbox2.MINX = 11’d352;
defparam backbox2.MAXX = 11’d671;
defparam backbox2.MINY = 10’d268; //was 273
defparam backbox2.MAXY = 10’d502;
14
drawbox backbox3(hcount, vcount, back_pixel3, vclock, above3, below3, in3);
defparam backbox3.MINX = 11’d305;
defparam backbox3.MAXX = 11’d717;
defparam backbox3.MINY = 10’d231; //was 245 //was 237
defparam backbox3.MAXY = 10’d540;
drawbox backbox4(hcount, vcount, back_pixel4, vclock, above4, below4, in4);
defparam backbox4.MINX = 11’d225; //was 221 //was 228
defparam backbox4.MAXX = 11’d800; //was 802
defparam backbox4.MINY = 10’d172; //was 196 //was 181
defparam backbox4.MAXY = 10’d600; //was 612 //was 604
defparam backbox.MINX = 11’d384;
defparam backbox.MAXX = 11’d640;
defparam backbox.MINY = 10’d288;
defparam backbox.MAXY = 10’d480;
defparam topleftline.X1 = 11’d0;
defparam topleftline.Y1 = 10’d0;
defparam topleftline.X2 = 11’d384;
defparam topleftline.Y2 = 10’d288;
defparam toprightline.X1 = 11’d640;
defparam toprightline.Y1 = 10’d288;
defparam toprightline.X2 = 11’d1024;
defparam toprightline.Y2 = 10’d0;
defparam bottomrightline.X1 = 11’d640;
defparam bottomrightline.Y1 = 10’d480;
defparam bottomrightline.X2 = 11’d1024;
defparam bottomrightline.Y2 = 10’d768;
defparam bottomleftline.X1 = 11’d384;
defparam bottomleftline.Y1 = 10’d480;
defparam bottomleftline.X2 = 11’d0;
defparam bottomleftline.Y2 = 10’d768;
endmodule