
`timescale 100us / 100us
module hello_world;

    reg rst;
  // My signal definitions
    wire clk;
    wire but_up;
    reg but_down;
    wire [2:0] rgb;
    wire hsync;
    wire vsync;
    reg [2:0] sw;

    clock_gen clk_gen(clk);
    //sw_clock sw_clock(sw);

    button_up_clock_gen button_up_clock_gen(but_up);

    top_vga uut(clk, rst, sw,but_up,but_down,but_up,but_down, hsync, vsync, rgb );

      initial begin
	rst = 1'b0;
	#10
    sw = 2'b0;
	rst = 1'b1;
	#10
	rst = 1'b0;
    but_down = 1'b0;
    rst = 1'b0;
    #1000000;
    $finish;

    end
endmodule
