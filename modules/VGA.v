module Imagen( 
    input clk, reset, 
    input [9:0]posx, 
    input [9:0]posy,
    input [2:0]sw,
    input [2:0]sw2, 
    input [9:0]posbarraiy,
    input [9:0]posbarrady,
    output hsync, vsync,
    output [2:0] rgb
    );
    //signal declaration
    reg [2:0] rgb_reg;
    wire video_on;
     wire [9:0] x,y;
 
    //instantiate vga sync circuit
    vga_sync vsync_unit (.clk(clk), .reset(reset), .hsync(hsync), . vsync(vsync), .video_on(video_on), . p_tick(), .pixel_x(x), .pixel_y(y));
 
    //rgb buffer
     always @(posedge clk, posedge reset) begin
        if (reset) rgb_reg <= 0;
        else begin
            if (x>posx & x<(12+posx) & y>posy & y<(12+posy)) rgb_reg<=3'b111;
            else if (x>=0 & x<=10 & y>=0 & y<=480) rgb_reg<=3'b111;
            else if (x>=630 & x<=640 & y>=0 & y<=480) rgb_reg<=3'b111;
            else if (x>=0 & x<=640 & y>=0 & y<=10) rgb_reg<=3'b111;
            else if (x>=0 & x<=640 & y>=470 & y<=480) rgb_reg<=3'b111;
            else if (y>=posbarraiy & y<=(100+posbarraiy) & x>=30 & x<=40) rgb_reg<=3'b111;
            else if (y>=posbarrady & y<=(100+posbarrady) & x>=600 & x<=610) rgb_reg<=3'b111;
            else rgb_reg <= sw;
        end
    end
 
    // output
    assign rgb = (video_on) ? rgb_reg : 3'b000;
endmodule