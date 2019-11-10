module position(clk, posx, posy, posbarraiy, posbarrady);
    input clk;
    input [9:0] posbarraiy;
    input [9:0] posbarrady;
    output reg [9:0] posx=600;
    output reg [9:0] posy=400;
 
    reg clk2;
    reg [18:0] temp=0;
    reg dirx=0;
    reg diry=0;
    always @(posedge clk) begin
        temp=temp+1;
        clk2=temp[18];
    end
 
    always @(posedge clk2) begin
 
        // Golpea diagonal abajo derecha
        if (dirx==0 & diry==0) begin
            posx=posx+1;
            posy=posy+1;
            if (posx>=610) dirx=1;
            else dirx=0;
            if (posy>=450) diry=1;
            else diry=0;
 
            // Golpe Con la Paleta
            if(posx>=30 & posx<=40 & posx>=posbarraiy & posx<=posbarraiy+100) 
            begin
            dirx=1;
            diry=0;
            end
            else if(posx>=610 & posx<=600 & posx>=posbarrady & posx<=posbarrady+100)
            begin
            dirx=1;
            diry=0;
            end
        end
 
        else if (dirx==1 & diry==0) begin
            posx=posx-1;
            posy=posy+1;
            if (posx<=10) dirx=0;
            else dirx=1;
            if (posy>=450) diry=1;
            else diry=0;
 
            if(posx>=30 & posx<=40 & posx>=posbarraiy & posx<=posbarraiy+100) 
            begin
            dirx=0;
            diry=1;
            end
            else if(posx>=610 & posx<=600 & posx>=posbarrady & posx<=posbarrady+100)
            begin
            dirx=0;
            diry=1;
            end
 
        end
        else if (dirx==0 & diry==1) begin
            posx=posx+1;
            posy=posy-1;
            if (posx>=610) dirx=1;
            else dirx=0;
            if (posy<=10) diry=0;
            else diry=1;
 
            if(posx>=30 & posx<=40 & posx>=posbarraiy & posx<=posbarraiy+100) 
            begin
            dirx=1;
            diry=0;
            end
            else if(posx>=610 & posx<=600 & posx>=posbarrady & posx<=posbarrady+100)
            begin
            dirx=0;
            diry=1;
            end
 
        end
        if (dirx==1 & diry==1) begin
            posx=posx-1;
            posy=posy-1;
            if (posx<=10) dirx=0;
            else dirx=1;
            if (posy<=10) diry=0;
            else diry=1;
 
            if(posx>=30 & posx<=40 & posx>=posbarraiy & posx<=posbarraiy+100) 
            begin
            dirx=0;
            diry=1;
            end
            else if(posx>=610 & posx<=600 & posx>=posbarrady & posx<=posbarrady+100)
            begin
            dirx=0;
            diry=1;
            end
        end        
    end
 
endmodule