//////////////////////////////////////////////////////////////////////
//
// drawline: generate a line on screen between
// (x1,y1) and (x2,y2)
//
//////////////////////////////////////////////////////////////////////
module drawline(hcount,vcount,pixel, vclock, toolow,toohigh);
parameter COLOR = 3’b111; // default color: white
parameter THICKNESS = 2’b11; //Thickness of the line
parameter X1 = 11’d152;
parameter Y1 = 10’d144;
parameter X2 = 11’d872;
parameter Y2 = 10’d144;
input [10:0] hcount;
input [9:0] vcount;
35
input vclock; //65 MHz clock
output [2:0] pixel;
output toolow, toohigh;
reg toolow,toohigh;
reg [2:0] pixel;
wire [17:0] slope; //Going to shift left to avoid fractions
wire negslope,argnegative,shouldnegate;
reg [9:0] stage1_vcount, stage2_vcount, stage3_vcount, last_vcount;
reg [10:0] stage1_hcount, stage2_hcount, stage3_hcount, last_hcount;
reg [29:0] stage2_slope_product, stage3_slope_product;
reg stage2_shouldnegate, stage3_shouldnegate;
parameter VERTICAL_LINE = 10’b1111111111; //If the slope is this high, I’ll just draw a vertical line
assign slope = (X2 == X1) ? VERTICAL_LINE : (((Y2 > Y1) ? (Y2-Y1) : (Y1-Y2)) << 8)
/
((X2 > X1) ? (X2-X1) : (X1-X2)); //I don’t want to deal with signed division or multiplication.
//Slope will always be positive, so I need to know whether it started negative
assign negslope = (((X2 > X1) && (Y1 > Y2)) ||
((X1 > X2) && (Y2 > Y1))
); //Will be 1 if the slope was negative
assign argnegative = (X1 > stage1_hcount); //Denotes that the (hcount - X1) is negative
assign shouldnegate = (argnegative ^ negslope); //Tells which case I should follow (do I subtract or add the slope product?)
wire [29:0] slope_product;
assign slope_product = slope*( (stage1_hcount > X1) ? (stage1_hcount - X1) : (X1 - stage1_hcount) );
always @ (posedge vclock) begin
//Stage 0. Store vcount and hcount
last_vcount <= vcount;
last_hcount <= hcount;
36
//Stage 1. Store values
stage1_vcount <= last_vcount >= 10’d802 ? last_vcount - 10’d802 : last_vcount + 4;
stage1_hcount <= last_hcount >= 11’d1340 ? last_hcount - 11’d1340 : last_hcount + 4;
//Stage 2. Compute slope product and if it is negative
stage2_slope_product <= slope_product;
stage2_shouldnegate <= shouldnegate;
stage2_vcount <= stage1_vcount;
stage2_hcount <= stage1_hcount;
//Stage 3 Give multiply another clock cycle to do its magic
stage3_slope_product <= stage2_slope_product;
stage3_shouldnegate <= stage2_shouldnegate;
stage3_vcount <= stage2_vcount;
stage3_hcount <= stage2_hcount;
//Stage 4. Output the pixel
if(slope == VERTICAL_LINE) pixel <= ((stage3_hcount <= X1 + THICKNESS) &&
(stage3_hcount >= X1 - THICKNESS) &&
(stage3_vcount >= ((Y2 > Y1) ? Y1 : Y2)) &&
(stage3_vcount <= ((Y2 > Y1) ? Y2 : Y1))
) ? COLOR : 0; //If it’s a vertical line, just check X
else case(stage3_shouldnegate)
1’b0: pixel <= ((stage3_vcount <= ((stage3_slope_product >> 8) + Y1 + THICKNESS)) &&
(stage3_vcount >= ((stage3_slope_product >> 8) + Y1 - THICKNESS)) &&
(stage3_vcount >= ((Y2 > Y1) ? ((Y1 < THICKNESS) ? 0 : Y1 - THICKNESS) : ((Y2 < THICKNESS) ? 0 : Y2 - THICKNESS))) &&
(stage3_vcount <= ((Y2 > Y1) ? Y2 + THICKNESS : Y1 + THICKNESS)) &&
(stage3_hcount >= ((X2 > X1) ? ((X1 < THICKNESS) ? 0 : X1 - THICKNESS) : ((X2 < THICKNESS) ? 0 : X2 - THICKNESS))) &&
(stage3_hcount <= ((X2 > X1) ? X2 + THICKNESS : X1 + THICKNESS))
) ? COLOR : 0;
1’b1: pixel <= ((stage3_vcount <= (Y1 - (stage3_slope_product >> 8) + THICKNESS)) &&
(stage3_vcount >= (Y1 - (stage3_slope_product >> 8) - THICKNESS)) &&
(stage3_vcount >= ((Y2 > Y1) ? ((Y1 < THICKNESS) ? 0 : Y1 - THICKNESS) : ((Y2 < THICKNESS) ? 0 : Y2 - THICKNESS))) &&
(stage3_vcount <= ((Y2 > Y1) ? Y2 + THICKNESS : Y1 + THICKNESS)) &&
(stage3_hcount >= ((X2 > X1) ? ((X1 < THICKNESS) ? 0 : X1 - THICKNESS) : ((X2 < THICKNESS) ? 0 : X2 - THICKNESS))) &&
(stage3_hcount <= ((X2 > X1) ? X2 + THICKNESS : X1 + THICKNESS))
) ? COLOR : 0;
default: pixel <= 0;
endcase
37
//Now compute if the pixel was below the line or above the line or neither
if(slope == VERTICAL_LINE) toolow <= 0;
else case(stage3_shouldnegate)
1’b0: toolow <= ((stage3_vcount >= ((stage3_slope_product >> 8) + Y1 + THICKNESS)) &&
(stage3_hcount >= ((X2 > X1) ? ((X1 < THICKNESS) ? 0 : X1 - THICKNESS) : ((X2 < THICKNESS) ? 0 : X2 - THICKNESS))) &&
(stage3_hcount <= ((X2 > X1) ? X2 + THICKNESS : X1 + THICKNESS))
) ? 1 : 0;
1’b1: toolow <= ((stage3_vcount >= (Y1 - (stage3_slope_product >> 8) + THICKNESS)) &&
(stage3_hcount >= ((X2 > X1) ? ((X1 < THICKNESS) ? 0 : X1 - THICKNESS) : ((X2 < THICKNESS) ? 0 : X2 - THICKNESS))) &&
(stage3_hcount <= ((X2 > X1) ? X2 + THICKNESS : X1 + THICKNESS))
) ? 1 : 0;
default: toolow <= 0;
endcase
if(slope == VERTICAL_LINE) toohigh <= 0;
else case(stage3_shouldnegate)
1’b0: toohigh <= ((stage3_vcount <= ((stage3_slope_product >> 8) + Y1 - THICKNESS)) &&
(stage3_hcount >= ((X2 > X1) ? ((X1 < THICKNESS) ? 0 : X1 - THICKNESS) : ((X2 < THICKNESS) ? 0 : X2 - THICKNESS))) &&
(stage3_hcount <= ((X2 > X1) ? X2 + THICKNESS : X1 + THICKNESS))
) ? 1 : 0;
1’b1: toohigh <= ((stage3_vcount <= (Y1 - (stage3_slope_product >> 8) - THICKNESS)) &&
(stage3_hcount >= ((X2 > X1) ? ((X1 < THICKNESS) ? 0 : X1 - THICKNESS) : ((X2 < THICKNESS) ? 0 : X2 - THICKNESS))) &&
(stage3_hcount <= ((X2 > X1) ? X2 + THICKNESS : X1 + THICKNESS))
) ? 1 : 0;
default: toohigh <= 0;
endcase
end
endmodule