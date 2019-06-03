/*
 *  main.v
 *
 *  Connect all modules and run.
 *
 *  @version: 1.0 (beta)
 *  @variant: // TODO: Add the variant.
 *  
 *  @authors:   Yaroslav Ivoylov
 *              Maeshi Sagalaev
 *
 */
module main(clock, reset, data, hex0, hex1, led);

    // ==========[ inputs ]==========
    input clock;        // CLOCK50
    input reset;        // KEY[0]
    input [3:0] data;   // SW[0]...SW[3]

    // ==========[ outputs ]==========
     output [6:0] hex0; // HEX[0]
     output [6:0] hex1; // HEX[1]
	  output [2:0] led;  // LED[0]...LED[2]

    // ==========[ wires ]==========[
    wire clk;
    wire [3:0] out0;
    wire [3:0] out1;

    // ==========[ low counter ]==========
    low_counter op_low_counter(
        .in(clock),
        .out(clk)
    );

    // ==========[ cdd ]==========
    cdd op_cdd(
        .clock(clk),
        .reset(reset),
        .data(data),
        .out0(out0),
        .out1(out1),
		  .led(led)
    );

    // ==========[ coders ]==========
    coder op_coder1(
        .in(out0),
        .out(hex0)
    );

    coder op_coder2(
        .in(out1),
        .out(hex1)
    );

endmodule
