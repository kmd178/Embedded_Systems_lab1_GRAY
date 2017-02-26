//-- Description    : Verilog code for the 4-bit Gray --  with asynchronous reset
module gray_4bits (clk, clk_en, rst, state);
  input clk, clk_en, rst;
  output reg [3:0] state; //Gray counter register.
  reg auxbit; //Auxiliary bit necessary for the implementation of the 4bit-Gray counter.

  always @(posedge clk or rst) 
   begin
     if(rst) begin
     	state[3:0] <=4'b0000;
     	auxbit<=1;
     end 
     else begin
     //4bit-Gray counter logic.
     	auxbit<= ~auxbit;
     	state[0]<= auxbit^state[0];
     	state[1]<= (state[0]&&(~auxbit))^state[1];
     	state[2]<=(state[1]&&(~(state[0]||auxbit)))^state[2];
     	state[3]<=(~(state[0]||auxbit||state[1]))^state[3];
     end
  end
  
endmodule
