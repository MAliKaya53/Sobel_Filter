`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2024 17:32:15
// Design Name: 
// Module Name: sobel_kernel
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


module sobel_kernel(
    input clk,
    input rst,
    
    input [7:0] grayscale_i,
    input done_i,
    
    output [7:0] grayscale_o,
    output done_o
    );

wire [7:0] data [0:8];
wire sobel_data_buffer_done;

sobel_data_buffer SOBEL_DATA_BUFFER(
    .clk(clk),
    .rst(rst),
   
    .grayscale_i(grayscale_i),
    .done_i(done_i),
   
     .d0_o(data[0]),
     .d1_o(data[1]),
     .d2_o(data[2]),
     .d3_o(data[3]),
     .d4_o(data[4]),
     .d5_o(data[5]),
     .d6_o(data[6]),
     .d7_o(data[7]),
     .d8_o(data[8]),
     .done_o(sobel_data_buffer_done)       
    );


sobel_calc SOBEL_CALC(
     .clk(clk),
     .rst(rst),
    
     .d0_i(data[0]),
     .d1_i(data[1]),
     .d2_i(data[2]),
     .d3_i(data[3]),
     .d4_i(data[4]),
     .d5_i(data[5]),
     .d6_i(data[6]),
     .d7_i(data[7]),
     .d8_i(data[8]),
     .done_i(sobel_data_buffer_done),
     
     .grayscale_o(grayscale_o),
     .done_o(done_o)
    );

endmodule
