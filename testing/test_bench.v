
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

    button_up_clock_gen button_up_clock_gen(but_up);

    top_vga uut(clk, rst, sw,but_up,but_down,but_up,but_down, hsync, vsync, rgb );

    initial begin
    but_down = 1'b0;
    sw = 1'b0;
    rst = 1'b0;
    #10000000;
    $finish;

    end
endmodule
