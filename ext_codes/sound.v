module sound(
    input clk25,
	 input[1:0] point,
	 input[1:0] lose,
	 output speaker
	 );

reg [16:0] counter;
			
always @(posedge clk25)
	counter <= counter + 1;

assign speaker = (point != 2'b00) ? counter[16]:
			        (lose != 2'b00) ? counter[15]:
						0;

endmodule