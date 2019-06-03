/*
 *  coder.v
 *
 *  Decode data from 3 to 7 discharges.
 */
module coder(in, out);

    // ==========[ inputs ]==========
    input [3:0] in;

    // ==========[ outputs ]==========
    output [6:0] out;

    // ==========[ regs ]==========
    reg [6:0] code;

    // ==========[ assigns ]==========
    assign out = code;

    // TODO: Fix the alphabet codes.
    // ==========[ alphabet ]==========
    always@* begin
        case (in)
            3'b000: code = 7'b1111111; // void
            3'b001: code = 7'b1000001; // U
            3'b010: code = 7'b0001100; // P
            3'b011: code = 7'b1000110; // C
            3'b100: code = 7'b0001001; // H
            3'b101: code = 7'b0001110; // F
            3'b110: code = 7'b0001000; // A
            3'b111: code = 7'b1110111; // _
        endcase
    end

endmodule
