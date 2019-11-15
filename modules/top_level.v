module top_vga(
    input reset, 
    input puls1,
    input puls2,
    input puls3,
    input puls4,
    output hsync, 
	output vsync,
    output [2:0] rgb
    );
	
	wire clk48M;
    HSOSC inst2(
        .CLKHFPU(1'b1),
        .CLKHFEN(1'b1),
        .CLKHF(clk48M)
    );
	
	//wire reset,puls1,puls2,puls3,puls4;
	
	//assign reset = 0;
	//assign puls1=0;
	//assign puls2=0;
	//assign puls3=0;
	//assign puls4=0;
 
    wire [9:0] w_posbarrady;
    wire [9:0] w_posbarraiy;
    wire [9:0] w_posx;
    wire [9:0] w_posy;
	wire[2:0] vidas_i;
	wire [2:0] vidas_d;
	wire pierde_i;
	wire pierde_d;
	
	Imagen image(.clk(clk48M), .reset(reset), .hsync(hsync), .vsync(vsync),.rgb(rgb),.posx(w_posx), .posy(w_posy), .posbarrady(w_posbarrady), .posbarraiy(w_posbarraiy),.vidasi(vidas_i),.vidasd(vidas_d));
    position posicion(.clk(clk48M), .posx(w_posx), .posy(w_posy), .posbarraiy(w_posbarraiy), .posbarrady(w_posbarrady),.vidasi(vidas_i),.vidasd(vidas_d),.pierdei(pierde_i),.pierded(pierde_d));
    Barrad barrad(.clk(clk48M), .puls3(puls3), .puls4(puls4), .posbarrady(w_posbarrady));
    Barrai Barrai(.clk(clk48M), .puls1(puls1), .puls2(puls2), .posbarraiy(w_posbarraiy));

endmodule 