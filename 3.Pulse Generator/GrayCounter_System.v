`timescale 1ns / 1ps
// Additional Comments: Instantiation of the GrayCounter_Nbits and GrayCounter_Pulse models
module GrayCounter_System(clk, rst, leds);
  parameter N = 4;
  parameter distance = // How much for 1 Hz when clk period is 10 ns?
  input clk, rst;
  output [N-1:0] leds;
  wire pulse;
    
  // Instantiation of the GrayCounter_Pulse 
  // Here
	 
  // Instantiation of the gray_Nbits 
  // Here


endmodule
