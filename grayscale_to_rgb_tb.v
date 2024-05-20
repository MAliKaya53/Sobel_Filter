`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2024 16:21:46
// Design Name: 
// Module Name: grayscale_to_rgb_tb
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

module grayscale_to_rgb_tb();

reg clk, rst;

reg [7:0] grayscale_i;
reg done_i;

wire [7:0] red_o, green_o, blue_o;
wire done_o;

grayscale_to_rgb GRAYSCALE_TO_RGB(
    .clk(clk),
    .rst(rst),
   
    .grayscale_i(grayscale_i),
    .done_i(done_i),
   
    .red_o(red_o),
    .green_o(green_o),
    .blue_o(blue_o),
   
     .done_o(done_o)
    );

initial clk = 1'b1;
always #(`clk_period/2) clk =~clk;

integer i;

initial begin
    rst = 1'b1;
    done_i = 1'b0;
    
    #(`clk_period);
    rst = 1'b0;
    done_i = 1'b1;
    
    for(i=0; i<9; i=i+1) begin
        grayscale_i = i + 1;
        #(`clk_period);
    end
    
    #(`clk_period);
    done_i = 1'b0;
    
    #(`clk_period);   
    $stop;
end

endmodule
