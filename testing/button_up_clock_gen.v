`timescale 100us / 100us
module button_up_clock_gen(but_up);

parameter PERIOD = 40;

output reg but_up;

always
	begin: CLOCK_DRIVER
		but_up <= 1'b0;
		#(PERIOD/2);
		but_up <= 1'b1;
		#(PERIOD/2);
	end
endmodule