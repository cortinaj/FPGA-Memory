`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2025 09:31:42 PM
// Design Name: 
// Module Name: top
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


module top(
    input clk,
    input rst,
    input [7:0] sw,
    input [4:0] PB,
    output [7:0] led,
    output [6:0] seg,
    output reg [1:0] an
    );
    
    //Wires and Reg
    reg [7:0] addr_ptr = 8'b0; //Pointer to current address
    reg increment = 0; //Tracks auto increment
    reg [3:0] hex_to_display;
    reg active_digit;
    
    wire [7:0] dout; //Wire for output
    wire clk_1Hz; //output wire for clk divider
    wire refresh_clk;
    wire[7:0] bram_addr; //Utilize SW or PB
    wire [6:0] seg0, seg1;
    
    assign bram_addr = (sw!= 8'b0) ? sw : addr_ptr;
    
    // Instantiate Clock Divider
    clk_div #(.DIVISOR(50_000_000)) div1Hz(.clk_in(clk),
                                           .rst(PB[0]),
                                           .clk_out(clk_1Hz)
                                           );
    //Instantiate Clock Refresh
    clk_div #(.DIVISOR(50_000)) div1kHz ( 
        .clk_in(clk),
        .rst(PB[0]),
        .clk_out(refresh_clk)
    );
    //Instantiate BRAM 
    blk_mem_gen_0 BRAM1(.clka(clk),
                        .ena(1'b1),
                        .addra(bram_addr),
                        .douta(dout)
                        );
                        
    //Control Logic
    always @(posedge clk) begin
        if(PB[0]) begin
            addr_ptr <= 8'b0;
            increment <= 0;
        end else begin
            case (PB[4:1])
                4'b0001: addr_ptr <= 8'b0;
                4'b0010: addr_ptr <= addr_ptr +1;
                4'b0100: increment <= 1;
                4'b1000: increment <= 0;
                default:;
            endcase
         end
     end
     
     //Auto Increment Logic
     always @(posedge clk_1Hz) begin
        if(increment)
            addr_ptr <= addr_ptr + 1;
     end
     

     
 // Decoder
    always @(posedge refresh_clk or posedge PB[0]) begin
        if (PB[0])
            active_digit <= 0;
        else
            active_digit <= ~active_digit;
    end
    
    always @(*) begin
    case (active_digit)
        1'b0: begin
            an = 2'b10;           // right digit
            hex_to_display = dout[3:0];
        end
        1'b1: begin
            an = 2'b01;           // left digit
            hex_to_display = dout[7:4];
        end
    endcase
end
Seven_Seg_Decoder decoder (
    .hex(hex_to_display),
    .segs(seg)
);   
     assign led = dout;
     
     
endmodule
