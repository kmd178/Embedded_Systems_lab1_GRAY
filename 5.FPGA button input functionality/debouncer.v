// Switch Debounce Module
// use your system clock for the clock input
// to produce a synchronous, debounced output
// .01 sec with a 100 Mhz clock
`timescale 1ns / 100ps
module debounce( clk,reset,button,stabilized_button);
		input clk;
		input reset;
		input button;
		output reg stabilized_button=0; //not 0??
		//carefull
		reg [19:0] clk_count=1'b0;  //(Depending on the FPGA system used.) For a 100mhz clock (period=10^-8) and for a 10ms delay, 20bits give the required 2^20cycles.(0.01048576seconds)
		wire check; ////ClockDividing using AND: When clk_hits 2^20 clock periods CHECK will give me a posedge
		reg saved_button_state;   //=0;
		reg [1:0] current_state;  //=0;
		 
		always @(posedge clk) //posedge reset) 
			begin
			        //if(reset)
			        //   clk_count<=0;
			        //else 
					   clk_count<=clk_count+ 1'b1;
			end
			
		assign check = &clk_count;  
		//ClockDividing using AND: When clk_hits 1048576 Cycles=(20b'1111111111111111111111) clock periods CHECK will give me a posedge
		//if the clock of the FPGA is 10mhz then 1048576 cycles equal a worst case of a 4*0.1048576seconds delay, 
		//making it necessary to be pressing the button for that much time to make an effect//////
		

		
		always @(posedge check, posedge reset) 
			begin
				if (reset)
						begin 
						current_state<=2'b00;  //00
						saved_button_state<=button; //button
						stabilized_button<=1'b0;  //A different module is utilized for Buttons than the Reset button  
						//itself in order for the system to regain partial functionality in the a case of a shortcircuited o
						//r stuck button,  the anti_bounce module will effectively nulify the malfunctioning button's effect when the reset button is pressed.
						end
				else 
					begin
						case(current_state)
								2'b00: //INITIAL STATE: CHECKING FOR CHANGE IN THE STATE OF THE BUTTON
										if (button== ~saved_button_state) 
											begin
												current_state<=2'b01;       //progress_state
												saved_button_state<=button;
											end
								2'b01:
										if (button== ~saved_button_state)
												current_state<=2'b00;        
										else 
											begin
												current_state<=2'b10;       //progress_state
												saved_button_state<=button;
											end
								2'b10:	
										if (button== ~saved_button_state)
												current_state<=2'b00;
										else 
											begin
												current_state<=2'b11;       //progress_state
												saved_button_state<=button;
											end 
								2'b11:
										if (button == ~saved_button_state) 
											current_state <= 2'b00; 
										else 
											begin
												current_state<=2'b00;        //Reinitialize FSM
												stabilized_button<=button; //PROGRESS THE RESULT IN THE OUTPUT
											end 
						endcase
				end
				
		end
		
endmodule
