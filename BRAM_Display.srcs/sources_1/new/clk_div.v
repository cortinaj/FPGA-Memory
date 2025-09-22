`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2025 10:24:47 PM
// Design Name: 
// Module Name: clk_div
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


module clk_div #(parameter DIVISOR = 100_000_000)(
    input wire clk_in,
    input wire rst,
    output reg clk_out
    );

 integer counter = 0;
    always @(posedge clk_in or posedge rst) begin
        if(rst) begin
            counter <= 0;
            clk_out <= 0;
         end else begin
            if (counter == ((DIVISOR/2) - 1)) begin 
            counter <= 0;
            clk_out <= ~clk_out;
          end else begin
            counter <= counter + 1;
          end
      end
end
endmodule
