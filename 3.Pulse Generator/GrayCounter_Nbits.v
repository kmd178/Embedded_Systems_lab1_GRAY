module gray_Nbits (clk, clk_en, rst, gray_out);
  parameter N = 4; //Number of bits used for the Gray Counter
  input clk,clk_en,rst;
  output [N-1:0] gray_out; //Output Gray Counter
  reg [N:0] state=0;
  reg [N:0] toggle;
  integer n,j;
  
  // The state of the Gray counter
  always @(posedge clk, negedge rst)
    begin
	     if (rst == 1'b0)
		    state<= 1<<N; // Initialize state with 1000..00
	     else
	       begin
	        state[0]<=(toggle[0])? (!state[0]) : (state[0]); // Main part of code
	        state[1]<=(toggle[1])? (!state[1]) : (state[1]); 
	        for  (n=2 ; n<=N ; n=n+1)
	           begin
	               state[n]<=(toggle[n])? (!state[n]) : (state[n]); 
	           end
	       end      
	 end

  // The combinational logic produces the toggle[N:0] signals
  always @(state) //(state) 
    begin     
        toggle[0] =  1'b1;    //each active clock
        toggle[1] = state[0]; //when bit0 is 1	
        for (n=2; n<N; n=n+1) 
            begin
                toggle[n]= (state[n-1]==1); // Variable bit range selection: state[n-2:0]==0 is not valid in verilog syntax 
                for (j=0; j<=n-2 ; j=j+1)  //: for loop implementation of state[n-2:0]==0
                   toggle[n]= (toggle[n] && state[j]==0);
	        end
	    toggle[N]= state[N-2:0]==0; 
	end
	
    assign gray_out=state[N:1];
endmodule
