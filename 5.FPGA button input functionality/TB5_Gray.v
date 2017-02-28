`timescale 1ns/100ps
`define cycle 10   
module TB5;
  parameter N = 4;
  parameter distance = 1000;  //
  reg clk, rst, clk_en, button;
  wire [N-1:0] leds;
  integer EndOfSimulation;  
  integer i, k;

  parameter ONE = 1'b1; 
   reg [N-1:0] leds_expected[0:15];
	/* {4'h0, 4'h1, 4'h3, 4'h2, 4'h6, 4'h7, 4'h5, 4'h4,
                                 4'hC, 4'hD, 4'hF, 4'hE, 4'hA, 4'hB, 4'h9, 4'h8}; */
                                 					 
  // Drive the reset and the EndOfSimulation signal
   initial 
     begin
	       EndOfSimulation = 0;
	      button= 0;
          rst = 1'b1;	  
	       clk = 1'b0 ;
          # (5*`cycle)
          rst = 1'b0;
          button=1;
			 # (5*`cycle)
          rst = 1'b0;
          	 # (5*`cycle)
          button=0;
             # (5*`cycle)
           button=1;
          # (8097152*`cycle)
          button=0;
          # (8097152*`cycle)
          button=1;
           # (8097152*`cycle)
           button=0;
           # (5*`cycle)
           button=1;
           # (5*`cycle)
            rst = 1'b1;
             # (15*`cycle)
        button=0;
           # (15*`cycle)
         button=1;
           # (8097152*`cycle)
            button=1;
            # (8097152*`cycle)
            button=0;
            # (5*`cycle)
         rst = 1'b1;
              # (5*`cycle)
         button=0;
            # (5*`cycle)
          button=1;
             # (5*`cycle)
        button=0;
            # (8097152*`cycle)
         button=1;
         # (8097152*`cycle)
         button=0;
          EndOfSimulation = 1;
	       # (2*`cycle)
	       $finish;
     end
	 
  // Drive the clock 
  always 
      # (`cycle/2) clk = ~clk;
	
  // Instantiate the System in the testbench  //Module #(params) InstanceName (...inputs&ouputs...)
  GrayCounter_System System (.clk(clk), .rst(rst), .button(button), .leds(leds));
  
endmodule


