`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2024 13:14:48
// Design Name: 
// Module Name: sobel_data_buffer_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`define clk_period 10

module sobel_data_buffer_tb( );

reg clk, rst;

reg [7:0] grayscale_i;
reg done_i;

wire [7:0] d0_o, d1_o, d2_o, d3_o, d4_o, d5_o, d6_o, d7_o, d8_o;

wire done_o;

sobel_data_buffer SOBEL_DATA_BUFFER(
    .clk(clk),
    .rst(rst),
   
    .grayscale_i(grayscale_i),
    .done_i(done_i),
   
     .d0_o(d0_o),
     .d1_o(d1_o),
     .d2_o(d2_o),
     .d3_o(d3_o),
     .d4_o(d4_o),
     .d5_o(d5_o),
     .d6_o(d6_o),
     .d7_o(d7_o),
     .d8_o(d8_o),
     .done_o(done_o)       
    );

initial clk = 1'b1;
always #(`clk_period/2) clk =~clk;

integer i;

initial begin
    rst = 1'b1;
    grayscale_i = 8'b0;
    done_i = 1'b0;
    
    #(`clk_period);
    rst = 1'b0;
    done_i = 1'b1;
    
    for(i=1; i<=36; i=i+1) begin
        grayscale_i = i;
        #(`clk_period);
    end
    
    done_i = 1'b0;
    
    #(`clk_period);
    $stop;
end












endmodule
