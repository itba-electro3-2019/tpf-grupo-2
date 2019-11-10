module Barrai(puls3, puls4, clk, posbarrady);

    input clk;
    input puls3;
    input puls4;
    output reg [9:0] posbarrady=60;

    reg clk3;
    reg [16:0] temp1=0;
    always @(posedge clk) begin
        temp1=temp1+1;
        clk3=temp1[16];
    end

    always@(posedge clk3)begin

        if(puls3)begin
            posbarrady=posbarrady-1;
            if (posbarrady<=10) posbarrady=10;
            else posbarrady=posbarrady;
            end
        else if(puls4)begin
            posbarrady=posbarrady+1;
            if (posbarrady>=470) posbarrady=470;
            else posbarrady=posbarrady;
            end
        else posbarrady=posbarrady;
    end

endmodule