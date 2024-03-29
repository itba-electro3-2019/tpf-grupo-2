module ball;
reg [9:0] ballX;
reg [8:0] ballY;
reg ball_inX, ball_inY;

always @(posedge clk)
if(ball_inX==0) ball_inX <= (CounterX==ballX) & ball_inY; else ball_inX <= !(CounterX==ballX+16);

always @(posedge clk)
if(ball_inY==0) ball_inY <= (CounterY==ballY); else ball_inY <= !(CounterY==ballY+16);

wire ball = ball_inX & ball_inY;

wire border = (CounterX[9:3]==0) || (CounterX[9:3]==79) || (CounterY[8:3]==0) || (CounterY[8:3]==59);
wire paddle = (CounterX>=PaddlePosition+8) && (CounterX<=PaddlePosition+120) && (CounterY[8:4]==27);
wire BouncingObject = border | paddle; // active if the border or paddle is redrawing itself

reg CollisionX1, CollisionX2, CollisionY1, CollisionY2;
always @(posedge clk) if(BouncingObject & (CounterX==ballX ) & (CounterY==ballY+ 8)) CollisionX1<=1;
always @(posedge clk) if(BouncingObject & (CounterX==ballX+16) & (CounterY==ballY+ 8)) CollisionX2<=1;
always @(posedge clk) if(BouncingObject & (CounterX==ballX+ 8) & (CounterY==ballY )) CollisionY1<=1;
always @(posedge clk) if(BouncingObject & (CounterX==ballX+ 8) & (CounterY==ballY+16)) CollisionY2<=1;


reg UpdateBallPosition;       // active only once for every video frame
always @(posedge clk) UpdateBallPosition <= (CounterY==500) & (CounterX==0);

reg ball_dirX, ball_dirY;
always @(posedge clk)
if(UpdateBallPosition)
begin
  if(~(CollisionX1 & CollisionX2))        // if collision on both X-sides, don't move in the X direction
  begin
    ballX <= ballX + (ball_dirX ? -1 : 1);
    if(CollisionX2) ball_dirX <= 1; else if(CollisionX1) ball_dirX <= 0;
  end

  if(~(CollisionY1 & CollisionY2))        // if collision on both Y-sides, don't move in the Y direction
  begin
    ballY <= ballY + (ball_dirY ? -1 : 1);
    if(CollisionY2) ball_dirY <= 1; else if(CollisionY1) ball_dirY <= 0;
  end
end



wire R = BouncingObject | ball | (CounterX[3] ^ CounterY[3]);
wire G = BouncingObject | ball;
wire B = BouncingObject | ball;

reg vga_R, vga_G, vga_B;
always @(posedge clk)
begin
  vga_R <= R & inDisplayArea;
  vga_G <= G & inDisplayArea;
  vga_B <= B & inDisplayArea;
end
endmodule : ball

