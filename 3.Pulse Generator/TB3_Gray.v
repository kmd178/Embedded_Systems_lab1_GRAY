`timescale 1ns/1ps
`define cycle 10

module TB2;
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
  gray_Nbits DUT(.clk(clk), .clk_en(ONE), .rst(rst), .gray_out(leds));   
  
endmodule
/*
`timescale 1ns/1ps
`define cycle 10   // this is equivalent to defines in C

module TB3;
  parameter N = 4;
  parameter distance = 1000;  //
  reg clk, rst, clk_en;
  wire [N-1:0] leds;
  integer EndOfSimulation;  


  // Drive the reset and the EndOfSimulation signal
   initial 
     begin
	 // Your code goes here
     end
	 
  // Drive the clock 
  always 
    begin
         // Your code goes here
    end
	
 
  // Instantiate the System in the testbench
  // Your code goes here
  
endmodule
*/