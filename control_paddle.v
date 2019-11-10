//Moving the paddle.
module control_paddle(up,down,right,left,minX,minY,maxX,maxY,vsync,vclock,reset);
input up,down,right,left,vsync,vclock, reset;
output [10:0] maxX,minX;
output [9:0] maxY,minY;
reg [10:0] maxX,minX;
reg [9:0] maxY,minY;
reg last_vsync;
parameter PADDLE_SPEED = 4;
always @ (posedge vclock) begin //When vsync goes low, we have finished a frame, so update positions for next frame
if(reset) begin
maxX <= 700;
maxY <= 700;
minX <= 400;
minY <= 400;
last_vsync <= vsync;
end else begin
last_vsync <= vsync;
if(vsync == 0 && last_vsync == 1) begin
if(up && ~down && minY > PADDLE_SPEED) begin
minY <= minY - PADDLE_SPEED;
maxY <= maxY - PADDLE_SPEED;
end else if(down && ~up && maxY < 767 - PADDLE_SPEED) begin
minY <= minY + PADDLE_SPEED;
maxY <= maxY + PADDLE_SPEED;
end else begin
minY <= minY;
maxY <= maxY;
end
if(left && ~right && minX > PADDLE_SPEED) begin
minX <= minX - PADDLE_SPEED;
maxX <= maxX - PADDLE_SPEED;
18
end else if(right && ~left && maxX < 1023 - PADDLE_SPEED) begin
minX <= minX + PADDLE_SPEED;
maxX <= maxX + PADDLE_SPEED;
end else begin
minX <= minX;
maxX <= maxX;
end
end
end
end
endmodule