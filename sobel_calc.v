`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2024 15:41:55
// Design Name: 
// Module Name: sobel_calc
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


module sobel_calc(
    input clk,
    input rst,
    
    input [7:0] d0_i,
    input [7:0] d1_i,
    input [7:0] d2_i,
    input [7:0] d3_i,
    input [7:0] d4_i,
    input [7:0] d5_i,
    input [7:0] d6_i,
    input [7:0] d7_i,
    input [7:0] d8_i,
    input done_i,
    
    output reg [7:0] grayscale_o,
    output done_o
    );

reg [9:0] gx_p; // positive value
reg [9:0] gx_n; // negative value
reg [9:0] gx_d; // x data

reg [9:0] gy_p; // positive value
reg [9:0] gy_n; // negative value
reg [9:0] gy_d; // y data

reg [9:0] g_sum; // gx_d + gy_d

reg [3:0] done_shift;

always @(posedge clk) begin
    if(rst) begin
        gx_p <= 0;
        gx_n <= 0;
    end else begin
        gx_p <= d6_i + (d3_i << 1) + d0_i;
        gx_n <= d8_i + (d5_i << 1) + d2_i;
    end
end

always @(posedge clk) begin
    if(rst) begin
        gy_p <= 0;
        gy_n <= 0;
    end else begin
        gy_p <= d0_i + (d1_i << 1) + d2_i;
        gy_n <= d6_i + (d7_i << 1) + d8_i;
    end
end

always @(posedge clk) begin
    if(rst) begin
        gx_d <= 0;
    end else begin
        gx_d <= (gx_p >= gx_n) ? (gx_p - gx_n): (gx_n - gx_p);
    end
end

always @(posedge clk) begin
    if(rst) begin
        gy_d <= 0;
    end else begin
        gy_d <= (gy_p >= gy_n) ? (gy_p - gy_n): (gy_n - gy_p);
    end
end

always @(posedge clk) begin
    if(rst) begin
        g_sum <= 0;
    end else begin
        g_sum <= gx_d + gy_d;
    end
end

always @(posedge clk) begin
    if(rst) begin
        grayscale_o <= 0;
    end else begin
        grayscale_o <= (g_sum >= 8'd60) ? 8'd225 : g_sum[7:0];
    end
end

always @(posedge clk) begin
    if(rst) begin
        done_shift <= 0;
    end else begin
        done_shift <= {done_shift[2:0], done_i};
    end
end

assign done_o = done_shift[3];

endmodule
