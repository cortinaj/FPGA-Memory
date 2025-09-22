`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2025 09:37:58 AM
// Design Name: 
// Module Name: Seven_Seg_Decoder
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


module Seven_Seg_Decoder(
    input wire [3:0] hex,
    output reg [6:0] segs // (a, b, c, d, e, f, g)
    );
    
    always @* begin
        case (hex)
            4'h0: segs = 7'b1111110;
            4'h1: segs = 7'b0110000;
            4'h2: segs = 7'b1101101;
            4'h3: segs = 7'b1111001;
            4'h4: segs = 7'b0110011;
            4'h5: segs = 7'b1011011;
            4'h6: segs = 7'b1011111;
            4'h7: segs = 7'b1110000;
            4'h8: segs = 7'b1111111;
            4'h9: segs = 7'b1110011;
            4'hA: segs = 7'b1110111;
            4'hB: segs = 7'b0011111;
            4'hC: segs = 7'b1001110;
            4'hD: segs = 7'b0111101;
            4'hE: segs = 7'b1001111;
            4'hF: segs = 7'b1000111;
            default: segs = 7'b0000000;
        endcase
    end
    
endmodule
