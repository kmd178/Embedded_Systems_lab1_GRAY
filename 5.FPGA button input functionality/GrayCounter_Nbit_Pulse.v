`timescale 1ns / 100ps
// Description: This FSM converts an input level signal to a single-cycle pulse. 
module GrayCounter_Pulse(input clk, input rst, input level, output reg pulse);

   reg [1:0] state=S0;
   reg [1:0] nextstate=S0;
   parameter S0 = 2'b00;
   parameter S1 = 2'b01;
   parameter S2 = 2'b10;
   
   // Compute next state of the FSM 
  always @(state, level)
      begin
			case(state)
				S0:
							if(level)
							     begin
                                     nextstate=S2;
                                     pulse=1;
                                 end
							else
							     nextstate=S1;
				S1:
							if(level)
							     begin
                                     nextstate=S2;
                                     pulse=1;
                                 end
							else
							     nextstate=S0;
				S2:
						begin
						    pulse=0;
							if(!level)
							     nextstate=S0;
						end
				default: begin
				        pulse=0;
				        nextstate=S0;
				       end
			endcase
      end
	  
	  // Set the new state 
	always @(posedge clk, posedge rst)
			begin
				if(rst)
					state <= S0;
				else
					state <= nextstate;
	end
endmodule
