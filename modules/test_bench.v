
`timescale 100us / 100us
module hello_world;

    reg rst;
  // My signal definitions
    wire clk;
    reg but_up;
    reg but_down;
    wire [2:0] rgb;
    wire hsync;
    wire vsync;
    reg [2:0] sw;
	wire video_on;
	wire p_tick;
	wire [9:0] pixel_x,pixel_y;

    clock_gen clk_gen(clk);
    //sw_clock sw_clock(sw);

    //button_up_clock_gen button_up_clock_gen(but_up);

    vga_sync uut(clk,rst, hsync, vsync, video_on,p_tick,pixel_x,pixel_y);

endmodule
