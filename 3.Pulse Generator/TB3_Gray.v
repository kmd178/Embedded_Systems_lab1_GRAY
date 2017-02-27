`timescale 1ns / 100ps
`define cycle 10

module TB3;
  parameter N = 4;
  reg clk, rst, clk_en;
  wire [N-1:0] leds;
  integer i;

  parameter ONE = 1'b1; 
							 
  // Initial statement for signal initialization (reset, clk, EndOfSimulation)
   initial 
     begin
      clk=1'b0;
      rst=1'b0;
      #(4.25*`cycle) rst = 1'b1;
      for (i = 0; i < 15; i=i +1) 
          begin
            $display("na to %b",leds);
            #(`cycle);
          end
     end
	 
  // Always statement to drive the clock
  always 
	   #(`cycle / 2) clk=~clk;
   

   // Instantiation of the gray_Nbits 
  GrayCounter_System System(.clk(clk) , .rst(rst), .leds(leds));   
  
endmodule