`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2024 13:02:52
// Design Name: 
// Module Name: sobel_data_buffer
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


module sobel_data_buffer(
    input clk,
    input rst,
    
    input [7:0] grayscale_i,
    input done_i,
    
    output [7:0] d0_o,
    output [7:0] d1_o,
    output [7:0] d2_o,
    output [7:0] d3_o,
    output [7:0] d4_o,
    output [7:0] d5_o,
    output [7:0] d6_o,
    output [7:0] d7_o,
    output [7:0] d8_o,
    output done_o       
    );

wire [7:0] double_line_fifo_data0;
wire [7:0] double_line_fifo_data1;
wire [7:0] double_line_fifo_data2;
wire       double_line_fifo_done;
    
   //----------------fifo double line buffer module------------
    fifo_double_line_buffer FIFO_DOUBLE_LINE_BUFFER(
    .clk(clk),
    .rst(rst),
    
    .we_i(done_i),
    .data_i(grayscale_i),
    
    .data0_o(double_line_fifo_data0),
    .data1_o(double_line_fifo_data1),
    .data2_o(double_line_fifo_data2),
    
    .done_o(double_line_fifo_done)
);
    
sobel_data_modulate SOBEL_DATA_MODULATE(
   .clk(clk),
   .rst(rst),
   
   .d0_i(double_line_fifo_data0),
   .d1_i(double_line_fifo_data1),
   .d2_i(double_line_fifo_data2),
   
   .done_i(double_line_fifo_done),
   
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

endmodule
