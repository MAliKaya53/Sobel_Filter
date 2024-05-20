`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2024 15:37:00
// Design Name: 
// Module Name: sobel_data_modulate
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


module sobel_data_modulate(
    input clk,
    input rst,
    
    input [7:0] d0_i,
    input [7:0] d1_i,
    input [7:0] d2_i,
    
    input done_i,
    
    output reg[7:0] d0_o,
    output reg[7:0] d1_o,
    output reg[7:0] d2_o,
    output reg[7:0] d3_o,
    output reg[7:0] d4_o,
    output reg[7:0] d5_o,
    output reg[7:0] d6_o,
    output reg[7:0] d7_o,    
    output reg[7:0] d8_o, 
    
    output done_o         
    );
    
localparam ROWS = 480;
localparam COLS = 640;


reg [9:0] iRows, iCols;

reg [7:0] iCounter;
reg [7:0] data0, data1, data2, data3, data4, data5, data6, data7, data8;

assign done_o = (iCounter == 2) ? 1 : 0;


//----------handle with iRows and iCols--------------
always @(posedge clk) begin
    if(rst) begin
        iRows <= 0;
        iCols <= 0;
    end else begin
        if(done_o == 1) begin
            iCols <= (iCols == COLS - 1) ? 0 : iCols + 1;
            if(iCols == COLS - 1)
                iRows <= (iRows == ROWS - 1) ? 0 : iRows + 1;
        end    
    end
end

//-----------handle with 9 output data---------------
always @(*) begin
    if(rst) begin       
        d0_o <= 0;
        d1_o <= 0;
        d2_o <= 0;
        d3_o <= 0;
        d4_o <= 0;
        d5_o <= 0;
        d6_o <= 0;
        d7_o <= 0;
        d8_o <= 0;
    end else begin
        if(done_o == 1) begin 
        //------pos 1------------
            if(iRows == 0 && iCols == 0) begin
                d0_o <= 0;
                d1_o <= 0;
                d2_o <= 0;
                d3_o <= 0;
                d4_o <= data4;
                d5_o <= data5;
                d6_o <= 0;
                d7_o <= data7;
                d8_o <= data8;
           //------pos 2------------      
            end else if(iRows == 0 && iCols > 0 && iCols < COLS - 1)  begin
                d0_o <= 0;
                d1_o <= 0;
                d2_o <= 0;
                d3_o <= data3;
                d4_o <= data4;
                d5_o <= data5;
                d6_o <= data6;
                d7_o <= data7;
                d8_o <= data8;
            //------pos 3------------  
            end else if(iRows == 0 && iCols == COLS - 1) begin
                d0_o <= 0;
                d1_o <= 0;
                d2_o <= 0;
                d3_o <= data3;
                d4_o <= data4;
                d5_o <= 0;
                d6_o <= data6;
                d7_o <= data7;
                d8_o <= 0; 
            //------pos 4------------            
            end else if(iRows > 0 && iRows < ROWS - 1 &&iCols == 0) begin
                d0_o <= 0;
                d1_o <= data1;
                d2_o <= data2;
                d3_o <= 0;
                d4_o <= data4;
                d5_o <= data5;
                d6_o <= 0;
                d7_o <= data7;
                d8_o <= data8; 
           //------pos 5------------            
            end else if(iRows > 0 && iRows < ROWS - 1 && iCols > 0 && iCols < COLS - 1) begin
                d0_o <= data0;
                d1_o <= data1;
                d2_o <= data2;
                d3_o <= data3;
                d4_o <= data4;
                d5_o <= data5;
                d6_o <= data6;
                d7_o <= data7;
                d8_o <= data8;     
                //------pos 6------------        
            end else if(iRows > 0 && iRows < ROWS - 1 && iCols == COLS - 1) begin
                d0_o <= data0;
                d1_o <= data1;
                d2_o <= 0;
                d3_o <= data3;
                d4_o <= data4;
                d5_o <= 0;
                d6_o <= data6;
                d7_o <= data7;
                d8_o <= 0;
              //------pos 7------------             
            end else if(iRows == ROWS - 1 && iCols == 0) begin
                d0_o <= 0;
                d1_o <= data1;
                d2_o <= data2;
                d3_o <= 0;
                d4_o <= data4;
                d5_o <= data5;
                d6_o <= 0;
                d7_o <= 0;
                d8_o <= 0;
             //------pos 8------------             
            end else if(iRows == ROWS - 1 && iCols > 0 && iCols < COLS - 1) begin
                d0_o <= data0;
                d1_o <= data1;
                d2_o <= data2;
                d3_o <= data3;
                d4_o <= data4;
                d5_o <= data5;
                d6_o <= 0;
                d7_o <= 0;
                d8_o <= 0;         
            //------pos 9------------   
            end else if(iRows == ROWS - 1 && iCols == COLS - 1) begin
                d0_o <= data0;
                d1_o <= data1;
                d2_o <= 0;
                d3_o <= data3;
                d4_o <= data4;
                d5_o <= 0;
                d6_o <= 0;
                d7_o <= 0;
                d8_o <= 0;          
            end
        end
    end
end

//-----------handle with iCounter--------------------
always @(posedge clk) begin
    if(rst) begin
        iCounter <= 0;
    end else begin
        if(done_i == 1) begin
            iCounter <= (iCounter == 2) ? iCounter : iCounter + 1;
        end
    end
end

//--------shift data--------------
always @(posedge clk) begin
    if(rst) begin
         data0 <= 0;
         data1 <= 0;
         data2 <= 0;
         data3 <= 0;
         data4 <= 0;
         data5 <= 0;
         data6 <= 0;
         data7 <= 0;
         data8 <= 0;
    end
    else begin
        if(done_i == 1) begin
            data0 <= data1;
            data1 <= data2;
            data2 <= d2_i;
            
            data3 <= data4;
            data4 <= data5;
            data5 <= d1_i;
            
            data6 <= data7;
            data7 <= data8;
            data8 <= d0_i;
        end
    end
end







   
