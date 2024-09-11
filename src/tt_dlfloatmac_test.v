module testbench();
  reg [7:0] ui_in,uio_in;
  wire [7:0] uo_out, uio_out,uio_oe;
  reg  ena,clk, rst_n;
  
  tt_um_dlfloatmac dut(.ui_in(ui_in),
                    .uo_out(uo_out),
                    .uio_in(uio_in),
                    .uio_out(uio_out),
                    .uio_oe(uio_oe),
                    .ena(ena),
                    .clk(clk),
                    .rst_n(rst_n));
  
 initial 
  begin
    rst_n=0;
    clk = 1;
    forever #5 clk = ~clk; 
  end
  
   initial begin
    // logic [7:0]c1_out;
    
    #5 rst_n=1;
    //Test case 1: same sign +ve
    
     #5;
     uio_in=8'h3e;//a1=1.32
     ui_in=8'ha3;
     
     #10;
     uio_in=8'h40;//b1=2.45
     ui_in=8'h73;
     
     //Test case 2: same sign -ve
      #10;
     uio_in=8'hbe;//a=-1.32
     ui_in=8'ha3;
     
      #10;
     uio_in=8'hc0;//b=-2.45
     ui_in=8'h73;
     
     //Test case 3: diff sign -ve<+ve
      #10;
     uio_in=8'hbf;//a1=-1.89
     ui_in=8'hc7;
      
       #10;
     uio_in=8'h40;//b=2.67
     ui_in=8'hab;
     
     
     //Test case 4: same sign -ve>+ve
       #10;
     uio_in=8'hc0;//a=-2.45
     ui_in=8'h73;
     
      #10;
     uio_in=8'h3e;//b=1.32
     ui_in=8'ha3;
  
     //Test case 5: one operand is zero C_MUL IS ZERO
      #10;
     uio_in=8'h00;
     ui_in=8'h00;
     
      #10;
     uio_in=8'h3d;//b=0.98
     ui_in=8'heb;
     
     
      #10;
     uio_in=8'h21;//msb
     ui_in=8'hd7;//lsb
     
     
     #10;
     uio_in=8'h2c;//msb
     ui_in=8'h7c;//lsb
    
     
     //Test case 6: both are zero C_MUL IS ZERO
      #10;
     uio_in=8'h00;
     ui_in=8'h00;
     
      #10;
     uio_in=8'h00;
     ui_in=8'h00;
     
      #10;
     ui_in=8'h6f;//lsb
     uio_in=8'h43;//msb
     
     #10;
     ui_in=8'ha9;//lsb
     uio_in=8'h29;//msb
      
     
     //Test case 8: smallest -ve num & normal C_MUL IS ZERO
      #5;
     uio_in=8'h82;//-1.0x2^-30
     ui_in=8'h00;
     
      #10;
     uio_in=8'hbc;//-0.73
     ui_in=8'heb;
     
     #10;
     ui_in=8'h10;//lsb
     uio_in=8'h31;//msb
     
     #10;
     ui_in=8'hab;//lsb
     uio_in=8'h44;//msb
     
     //Test case 9: smallest +ve num & normal C_MUL IS ZERO
     
      #10;
     uio_in=8'h02;//a=1.0x2^-30
     ui_in=8'h00;
     
      #10;
     uio_in=8'hbc;//b=-0.73
     ui_in=8'heb;
     #10;
     ui_in=8'hdf;//lsb
     uio_in=8'h37;//msb
     
     #10;
     ui_in=8'h51;//lsb
     uio_in=8'h2c;//msb
     
     //Test case 10: smallest +ve & smallest +ve (underflow) C_MUL IS ZERO
      #10;
     uio_in=8'h02;//1.0x2^-30
     ui_in=8'h00;
     
      #10;
     uio_in=8'h02;//1.0x2^-30
     ui_in=8'h00;
    
      //Test case 11: smallest +ve & largest +ve
      #10;
     uio_in=8'h02;//1.0x2^-30
     ui_in=8'h00;
     
      #10;
     uio_in=8'h7d;//~1.117x2^31
     ui_in=8'hfe;
     //Test case 12: largest +ve & largest +ve 
      #10;
     uio_in=8'h7d;//~1.117x2^31
     ui_in=8'hfe;
     
      #10;
     uio_in=8'h7d;//~1.117x2^31
     ui_in=8'hfe;
     
      //Test case 13: normal  & largest +ve
      #10;
     uio_in=8'h3e;//1.32
     ui_in=8'ha3;
     
      #10;
     uio_in=8'h7d;//~1.117x2^31
     ui_in=8'hfe;
     
    
     //Test case 15: subnormal
     
      #10;
     uio_in=8'h01;
     ui_in=8'hb2;
     
      #10;
     uio_in=8'h79;
     ui_in=8'hfe;
     //Test case 16: underflow C_MUL IS ZERO
      #10;
     uio_in=8'h06;
     ui_in=8'h08;
     
      #10;
     uio_in=8'h86;
     ui_in=8'h18;
     
      //Test case 16: both are inf C_MUL IS FDFE
      #10;
     uio_in=8'hff;
     ui_in=8'hff;
     
      #10;
     uio_in=8'hff;
     ui_in=8'hff;
    
     //Test case 14: e1=63  C_MUL IS INF
      #10;
     uio_in=8'h7f;
     ui_in=8'hc0; 
      #10;
     uio_in=8'h3e;//1.32
     ui_in=8'ha3; 
       
     //Test case 18: one is inf  C_MUL IS INF
     
      #10;
     uio_in=8'hff;
     ui_in=8'hff;
     
      #10;
     uio_in=8'h3e;//b=1.34
     ui_in=8'hae;
          
     
     #40 $finish;
   end
  
  initial begin 
     $dumpfile("dump.vcd"); $dumpvars;
  end 
  /*
  initial begin
    $monitor("Time: %0t | ui_in: %0b | uio_in: %0b | uo_out: %0h" ,$time, ui_in, uio_in, uo_out);
    end */
  
endmodule  