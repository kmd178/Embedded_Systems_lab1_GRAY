`timescale 1ns / 1ps
// Description: This FSM converts an input level signal to a single-cycle pulse. 
module GrayCounter_Pulse(input clk, input rst, input level, output reg pulse);

   reg [1:0] state;
   reg [1:0] nextstate;
   parameter S0 = 2'b00;
   parameter S1 = 2'b01;
   parameter S2 = 2'b10;
   
   // Compute next state of the FSM 
  always @(state, level)
      begin
			case(state)
				S0:
						begin
							
						end
				S1:
						begin
							
						end
				S2:
						begin
							
						end
				default: 
			endcase
      end
	  
	  // Set the new state 
	always @(posedge clk, negedge rst)
			begin
				if(rst == 1'b0)
					state <= 2'b0;
				else
					state <= nextstate;
	end
endmodule
