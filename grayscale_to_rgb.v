`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2024 16:13:02
// Design Name: 
// Module Name: grayscale_to_rgb
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


module grayscale_to_rgb(
    input clk,
    input rst,
    
    input [7:0] grayscale_i,
    input done_i,
    
    output reg [7:0] red_o,
    output reg [7:0] green_o,
    output reg [7:0] blue_o,
    
    output reg done_o
    );

always @(posedge clk) begin
    if(rst) begin
        red_o   <= 8'd0;
        green_o <= 8'd0;
        blue_o  <= 8'd0;
        done_o  <= 1'd0;
    end else begin
        if(done_i) begin
            red_o   <= grayscale_i;
            green_o <= grayscale_i;
            blue_o  <= grayscale_i;
        end
        
        done_o <= done_i;
    end
end


endmodule
