`timescale 100us / 100us
module sw_clock(sw);

parameter PERIOD = 50;

output reg [2:0] sw;

always
	begin: CLOCK_DRIVER
		sw <= 3'b0;
		#(PERIOD/2);
		sw <= 3'b1;
		#(PERIOD/2);
	end
endmodule