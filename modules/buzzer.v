module buzzer (clk,buzz_on);
	input clk;
	output buzz_on;
	
	reg [18:0]buzz_time=0;
	reg clk2
	always @(posedge clk) begin
        buzz_time=buzz_time+1;
        clk2=buzz_time[16];
    end
endmodule