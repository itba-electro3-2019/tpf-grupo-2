module position(clk, posx, posy, posbarraiy, posbarrady, vidasi, vidasd, pierdei, pierded);
    input clk;
    input [9:0] posbarraiy;
    input [9:0] posbarrady;
    output reg [9:0] posx=280;
    output reg [9:0] posy=220;
	output reg[2:0] vidasi=7;
	output reg[2:0] vidasd=7;
	output pierdei;
	output pierded;
    reg clk2;
    reg [18:0] temp=0;
    reg dirx=0;
    reg diry=0;
    always @(posedge clk) begin
        temp=temp+1;
        clk2=temp[16];
    end
	
	assign pierdei = (vidasi == 0 ?  1 : 0);
	assign pierded = (vidasd == 0 ?  1 : 0);
 
    always @(posedge clk2) begin
        // Golpea diagonal abajo derecha
        if (dirx==0 & diry==0) begin
            posx=posx+1;
            posy=posy+1;
            if (posx>=610) begin
				posx=280;
				posy=220;
				vidasd=vidasd-1;
				dirx=1;
			end
            else dirx=0;
            if (posy>=460) diry=1;
            else diry=0;
 
            // Golpe Con la barra de la derecha
            if(posx>=30 & posx<=40 & posy>=posbarraiy & posy<=posbarraiy+100) 
            begin
            dirx=1;
            diry=0;
            end
            else if(posx<=600 & posx>=588 & posy>=posbarrady & posy<=posbarrady+100)
            begin
            dirx=1;
            diry=0;
            end
        end
 
        else if (dirx==1 & diry==0) begin
            posx=posx-1;
            posy=posy+1;
            if (posx<=10) begin
				posx=280;
				posy=220;
				vidasi=vidasi-1;
				dirx=0;
			end
            else dirx=1;
            if (posy>=460) diry=1;
            else diry=0;
 
			//Golpe con la barra de la izquierda
            if(posx>=30 & posx<=40 & posy>=posbarraiy & posy<=posbarraiy+100) 
            begin
            dirx=0;
            diry=0;
            end
            else if(posx<=600 & posx>=588 & posy>=posbarrady & posy<=posbarrady+100)
            begin
            dirx=0;
            diry=0;
            end
 
        end
        else if (dirx==0 & diry==1) begin
            posx=posx+1;
            posy=posy-1;
            if (posx>=610) begin
				posx=280;
				posy=220;
				vidasd=vidasd-1;
				dirx=1;
			end
            else dirx=0;
            if (posy<=10) diry=0;
            else diry=1;
 
            if(posx>=30 & posx<=40 & posy>=posbarraiy & posy<=posbarraiy+100) 
            begin
            dirx=1;
            diry=1;
            end
            else if(posx<=600 & posx>=588 & posy>=posbarrady & posy<=posbarrady+100)
            begin
            dirx=1;
            diry=1;
            end
 
        end
        if (dirx==1 & diry==1) begin
            posx=posx-1;
            posy=posy-1;
            if (posx<=10)begin
				posx=280;
				posy=220;
				vidasi=vidasi-1;
				dirx=0;
			end
            else dirx=1;
            if (posy<=10) diry=0;
            else diry=1;
 
            if(posx>=30 & posx<=40 & posy>=posbarraiy & posy<=posbarraiy+100) 
            begin
            dirx=0;
            diry=1;
            end
            else if(posx<=600 & posx>=588 & posy>=posbarrady & posy<=posbarrady+100)
            begin
            dirx=0;
            diry=1;
            end
        end        
    end
 
endmodule