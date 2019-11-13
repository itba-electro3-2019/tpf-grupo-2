module top_vga(
    input reset,
    input [2:0]sw,
    input puls1,
    input puls2,
    input puls3,
    input puls4,
    output hsync, vsync,
    output [2:0] rgb
    );
	
	wire clk48M;
    HSOSC inst2(
        .CLKHFPU(1'b1),
        .CLKHFEN(1'b1),
        .CLKHF(clk48M)
    );
	
	wire [2:0] rgb;
	assign {j01, j02, j03} = rgb;
 
    wire [9:0] w_posbarrady;
    wire [9:0] w_posbarraiy;
    wire [2:0] w_sw2;
    wire [9:0] w_posx;
    wire [9:0] w_posy;
    position posicion(.clk(clk48M), .posx(w_posx), .posy(w_posy), .posbarraiy(w_posbarraiy), .posbarrady(w_posbarrady));
    //color colores(.clk(clk),.sw2(w_sw2));
    Barrad barrad(.clk(clk48M), .puls3(puls3), .puls4(puls4), .posbarrady(w_posbarrady));
    Barrai Barrai(.clk(clk48M), .puls1(puls1), .puls2(puls2), .posbarraiy(w_posbarraiy));
    Imagen image(.clk(clk48M), .reset(reset),.sw(sw),.sw2(w_sw2), .hsync(hsync), .vsync(vsync),.rgb(rgb), 
    .posx(w_posx), .posy(w_posy), .posbarrady(w_posbarrady), .posbarraiy(w_posbarraiy));


endmodule 