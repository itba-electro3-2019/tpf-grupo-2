module Barrai(puls1, puls2, clk, posbarraiy);

    input clk;
    input puls1;
    input puls2;
    output reg [9:0] posbarraiy=60;

    reg clk3;
    reg [16:0] temp1=0;
    always @(posedge clk) begin
        temp1=temp1+1;
        clk3=temp1[16];
    end

    always@(posedge clk3)begin

        if(puls1)begin
            posbarraiy=posbarraiy-1;
            if (posbarraiy<=10) posbarraiy=10;
            else posbarraiy=posbarraiy;
            end
        else if(puls2)begin
            posbarraiy=posbarraiy+1;
            if (posbarraiy>=470) posbarraiy=470;
            else posbarraiy=posbarraiy;
            end
        else posbarraiy=posbarraiy;
    end

endmodule