//-- Description    : Verilog code for the 4-bit Gray --  with asynchronous reset
`timescale 1ns/1ps
 `define cycle 10
 module TB1;
   
   reg clk, rst, clk_en;
   wire [3:0] leds;
   //integer EndOfSimulation;  
   integer i;
 
   parameter ONE = 1'b1; 
                              
   // Initial statement for signal initialization (reset, clk)
    initial 
      begin
           clk=1'b0;
           rst=1'b1;
           #(4.25*`cycle) rst = 1'b0; //Instanciating asynchronous reset signal
           for (i = 0; i < 15; i=i +1) 
                begin
                    $display("na to %b",leds);
                    #(`cycle);
                end
           $stop;
      end
      
   // Always statement to drive the clock goes here
   always 
        #(`cycle / 2) clk=~clk;
    
   gray_4bits DUT(.clk(clk), .clk_en(ONE), .rst(rst), .state(leds));   
   
 endmodule

 /* Expacted Output:
  --  bin     hex
  --  0000    0
  --  0001    1
  --  0011    3
  --  0010    2
  --  0110    6
  --  0111    7
  --  0101    5
  --  0100    4
  --  1100    C
  --  1101    D
  --  1111    F
  --  1110    E
  --  1010    A
  --  1011    B
  --  1001    9
  --  1000    8
 */ 