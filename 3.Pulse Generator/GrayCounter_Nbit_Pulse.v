`timescale 1ns / 100ps
// This is the code that generates a pulse for a single cycle every "distance"
// cycles. Note that "distance" * clock period = 1 sec
module GrayCounter_Pulse(input clk, input rst, output pulse);
  parameter distance = 100000000;// Number of cycles within 1 second. For a 100mHz clock (10ns period): 100000000 cycles
  reg [27:0] counter; //integer counter;
  
  always @(posedge clk, negedge rst)
    begin
	     if (rst == 1'b0) 
		  	 counter<=0;	// asynchronous reset goes here
		  else if (pulse)
             counter<=0;
          else 
			 counter<=counter+ 1'b1;
	 end
	 
	 assign pulse= &(counter^~distance); //when counter==distance, the pulse signal is generated for one cycle.
			  
endmodule
