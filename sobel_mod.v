`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2024 17:14:22
// Design Name: 
// Module Name: sobel_mod
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


module sobel_mod(
    input clk,
    input rst,
    
    input [7:0] cam_red_i,
    input [7:0] cam_green_i,
    input [7:0] cam_blue_i,
    
    input cam_done_i,
    
    output [7:0] sobel_red_o,
    output [7:0] sobel_green_o,
    output [7:0] sobel_blue_o,
    
    output sobel_done_o
    );
    
wire [7:0] sobel_grayscale_i;
wire sobel_grayscale_i_done;

wire [7:0] sobel_grayscale_o;
wire sobel_grayscale_o_done;

rgb_to_grayscale RGB_TO_GRAYSCALE(
    .clk(clk),
    .rst(rst),
    
    .red_i(cam_red_i),
    .green_i(cam_green_i),
    .blue_i(cam_blue_i),
    
    .done_i(cam_done_i),
    
    .grayscale_o(sobel_grayscale_i),
    .done_o(sobel_grayscale_i_done)
);

sobel_kernel SOBEL_KERNEL(
    .clk(clk),
    .rst(rst),
    
    .grayscale_i(sobel_grayscale_i),
    .done_i(sobel_grayscale_i_done),
    
    .grayscale_o(sobel_grayscale_o),
    .done_o(sobel_grayscale_o_done)
);


grayscale_to_rgb GRAYSCALE_TO_RGB(
    .clk(clk),
    .rst(rst),
   
    .grayscale_i(sobel_grayscale_o),
    .done_i(sobel_grayscale_o_done),
   
    .red_o(sobel_red_o),
    .green_o(sobel_green_o),
    .blue_o(sobel_blue_o),
   
     .done_o(sobel_done_o)
    );

endmodule
