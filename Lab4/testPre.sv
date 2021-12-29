`timescale 1ns / 1ps

module testPre;

    logic clk, reset;
    logic [31:0] writedata, dataadr;
    logic memwrite;
    
    
    top DUT( .clk (clk), .reset(reset), .writedata(writedata), .dataadr(dataadr), .memwrite(memwrite) );
    
    initial begin
        reset = 0; #60;
        reset = 1; #60;
        reset = 0; #60;
    end
    
    always begin
        clk = 1'b1; 
        #20; // high for 20 * timescale = 20 ns
    
        clk = 1'b0;
        #20; // low for 20 * timescale = 20 ns
    end
 
endmodule
