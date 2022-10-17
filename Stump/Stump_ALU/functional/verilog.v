// Stump ALU
// Implement your Stump ALU here
//
// Created by Paul W Nutter, Feb 2015
//
// ** Update this header **
//

`include "Stump/Stump_definitions.v"

// 'include' definitions of function codes etc.
// e.g. can use "`ADD" instead of "'h0" to aid readability
// Substitute your own definitions if you prefer by
// modifying Stump_definitions.v

/*----------------------------------------------------------------------------*/

module Stump_ALU (input  wire [15:0] operand_A,		// First operand
                                 input  wire [15:0] operand_B,		// Second operand
		                          input  wire [ 2:0] func,		// Function specifier
		                          input  wire        c_in,		// Carry input
		                          input  wire        csh,  		// Carry from shifter
		                          output reg  [15:0] result,		// ALU output
		                          output reg  [ 3:0] flags_out);	// Flags {N, Z, V, C}


/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
/* Declarations of any internal signals and buses used                        */
reg [16:0] tmpresult;

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
/* Verilog code                                                               */
always@(*)begin
	flags_out = 0;
	case (func)
		3'b000: //add
			begin
				tmpresult = operand_A + operand_B;
				result = tmpresult[15:0];
				flags_out[3] = result[15];
				if (result == 0)
					flags_out[2] = 1'b1;
				if (operand_A[15] == operand_B[15] && operand_A[15] != result[15])
					flags_out[1] = 1'b1;
				flags_out[0] = tmpresult[16];
			end
		3'b001: //adc
			begin
				tmpresult = operand_A + operand_B + c_in;
				result = tmpresult[15:0];
				flags_out[3] = result[15];
				if (result == 0)
					flags_out[2] = 1'b1;
				if (operand_A[15] == operand_B[15] && operand_A[15] != result[15])
					flags_out[1] = 1'b1;
				flags_out[0] = tmpresult[16];
			end
		3'b010: //sub
			begin
				tmpresult = operand_A + ~operand_B + 1;
				result = tmpresult[15:0];
				flags_out[3] = result[15];
				if (result == 0)
					flags_out[2] = 1'b1;
				if (operand_A[15] != operand_B[15] && operand_B[15] == result[15])
					flags_out[1] = 1'b1;
				flags_out[0] = tmpresult[16];
			end
		3'b011: //sbc
			begin
				tmpresult = operand_A + (~operand_B + 1) + (~c_in + 1);
				result = tmpresult[15:0];
				flags_out[3] = result[15];
				if (result == 0)
					flags_out[2] = 1'b1;
				if (operand_A[15] != operand_B[15] && operand_B[15] == result[15])
					flags_out[1] = 1'b1;
				flags_out[0] = tmpresult[16];
			end
		3'b100: //and
			begin
				result = operand_A & operand_B;
				flags_out[3] = result[15];
				if (result == 0)
					flags_out[2] = 1'b1;
				flags_out[1] = 1'b0;
				flags_out[0] = csh;
			end
		3'b101: //or
			begin
				result = operand_A | operand_B;
				flags_out[3] = result[15];
				if (result == 0)
					flags_out[2] = 1'b1;
				flags_out[1] = 1'b0;
				flags_out[0] = csh;
			end
		3'b110: //ldst
			begin
				result = operand_A + operand_B;
				flags_out[3] = 1'bx;
				flags_out[2] = 1'bx;
				flags_out[1] = 1'bx;
				flags_out[0] = 1'bx;
			end
		3'b111: //bcc
			begin
				result = operand_A + operand_B;
				flags_out[3] = 1'bx;
				flags_out[2] = 1'bx;
				flags_out[1] = 1'bx;
				flags_out[0] = 1'bx;
			end
	endcase
end


/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/

/*----------------------------------------------------------------------------*/

endmodule

/*============================================================================*/

