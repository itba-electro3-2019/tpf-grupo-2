//////////////////////////////////////////////////////////////////////
//
// circle: generate circle on screen
//
//////////////////////////////////////////////////////////////////////
module circle(x,y,radius_squared,hcount,vcount,pixel,ball_color,vclock);
input [10:0] x,hcount,radius_squared;
input [9:0] y,vcount;
input vclock;
input [2:0] ball_color;
output [2:0] pixel;
reg [10:0] stage1_hcount, last_hcount;
reg [9:0] stage1_vcount, last_vcount;
reg [10:0] hcountdiff;
reg [9:0] vcountdiff;
reg [22:0] vcountsquared;
reg [22:0] hcountsquared;
reg [2:0] pixel;
always @ (posedge vclock) begin
//Stage 0. hold count locally
last_hcount <= hcount;
last_vcount <= vcount;
//Stage 1. store the hcount and vcount offset properly
stage1_hcount <= last_hcount >= 11’d1340 ? last_hcount - 11’d1340 : last_hcount + 4;
stage1_vcount <= last_vcount >= 10’d802 ? last_vcount - 10’d802 : last_vcount + 4;
//Stage 2. calculate differences
hcountdiff <= ((stage1_hcount > x) ? stage1_hcount - x : x - stage1_hcount);
vcountdiff <= ((stage1_vcount > y) ? stage1_vcount - y : y - stage1_vcount);
//Stage 3. square them
hcountsquared <= hcountdiff * hcountdiff;
vcountsquared <= vcountdiff * vcountdiff;
//Stage 4. compute pixel
if(hcountsquared + vcountsquared <= radius_squared) pixel <= ball_color;
17
else pixel <= 0;
end
endmodule