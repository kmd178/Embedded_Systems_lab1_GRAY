`timescale 1ns / 100ps
// Additional Comments: Instantiation of the GrayCounter_Nbits and GrayCounter_Pulse models
module GrayCounter_System(clk, rst, leds);
  parameter N = 4;
  //parameter distance = // How much for 1 Hz when clk period is 10 ns?
  input clk, rst;
  output [N-1:0] leds;
  wire pulse;
    
  GrayCounter_Pulse SecondPulse (clk, rst, pulse);// Instantiation of the GrayCounter_Pulse 
 
  gray_Nbits Counter(pulse, 1'b0 , rst, leds);// Instantiation of the gray_Nbits 


endmodule