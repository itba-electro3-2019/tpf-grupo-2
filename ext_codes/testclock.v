module testclock;
    reg clkk,rstt;
    wire [2:0]cc;

    count uut(cc, clkk, rstt);

    initial
        begin
		clkk = 1'b1;
		rstt = 1'b1;
		#1
		clkk = 1'b0;
		rstt = 1'b0;
		#1
		clkk = 1'b1;
		rstt = 1'b0;
		#1
		clkk = 1'b0;
		rstt = 1'b0;
		#1
		clkk = 1'b1;
		rstt = 1'b0;
		#1
		clkk = 1'b0;
		rstt = 1'b0;
		#1
		clkk = 1'b1;
		rstt = 1'b0;
		#1
		$finish;
        end
endmodule