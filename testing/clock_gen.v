`timescale 1ns / 1ps
module clock_gen(clk);

parameter PERIOD = 21;

output reg clk;

always
	begin: CLOCK_DRIVER
		clk <= 1'b0;
		#(PERIOD/2);
		clk <= 1'b1;
		#(PERIOD/2);
	end
endmodule