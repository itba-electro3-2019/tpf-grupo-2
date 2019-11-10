module Control(clk2, posx, count1, count2);
     input [9:0]posx; 
     input clk2;
     output reg count1;
     output reg count2;
 
    reg [3:0]next_state;
    reg [3:0]current_state;
 
    parameter inicio=0, i1=1, d1=2;
    always@(posx or current_state) begin
    case (current_state)
 
        inicio: begin
                        count1=0;
                        count2=0;
                        if (posx==10) next_state=i1;
                        else if (posx==620) next_state=d1;
                        else next_state=inicio;
                    end    
 
        i1: begin
                        count1=1;
                        count2=0;
                        next_state=inicio;
                    end                        
 
        d1: begin
                        count1=0;
                        count2=1;
                        next_state=inicio;
                    end            
 
                            default: begin
                                    count1=0;
                                    count2=0;
                                    next_state=inicio;
                            end
 
        endcase
        end
        always @(negedge clk2) begin
 
        current_state=next_state;
 
    end
 
endmodule