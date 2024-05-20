`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2024 14:50:14
// Design Name: 
// Module Name: fifo_double_line_buffer
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


module fifo_double_line_buffer(
    input clk,
    input rst,
    
    input we_i,
    input [7:0] data_i,
    
    output [7:0] data0_o,
    output [7:0] data1_o,
    output [7:0] data2_o,
    
    output done_o
    );
 
wire [7:0] fifo1_data, fifo2_data;
wire fifo1_done, fifo2_done;  

assign data0_o = data_i;
assign data1_o = fifo1_data;
assign data2_o = fifo2_data;

assign done_o = fifo1_done; 
    
fifo_single_line_buffer FIFO_SINGLE_LINE_BUFFER_01(
    .clk(clk),
    .rst(rst),
    
    .we_i(we_i),
    .data_i(data_i),
    
    .data_o(fifo1_data),
    .done_o(fifo1_done)
);
    
fifo_single_line_buffer FIFO_SINGLE_LINE_BUFFER_02(
    .clk(clk),
    .rst(rst),
    
    .we_i(fifo1_done),
    .data_i(fifo1_data),
    
    .data_o(fifo2_data),
    .done_o(fifo2_done)
);   
    
