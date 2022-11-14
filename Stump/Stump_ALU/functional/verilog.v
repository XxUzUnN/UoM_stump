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

// Stump ALU


module Stump_ALU (input  wire [15:0] operand_A,
                                 input  wire [15:0] operand_B,
		                          input  wire [ 2:0] func,
		                          input  wire        c_in,
		                          input  wire        csh,
		                          output wire  [15:0] result,
		                          output wire  [ 3:0] flags_out);

wire [16:0] U;
wire [15:0] W, T, D, E,F ;
wire X;

or   I1[15:0] (E, operand_A, W);
and I2[15:0] (D, operand_A, W);
xor I3[15:0] (T, operand_A,W, U[15:0]);
and I4 (flags_out[1], ~func[2], X);
or   I5[15:0] (U[16:1], F, D);
buf I6 (flags_out[3], result[15]);
buf I7 (flags_out[2], ~|result);
xor I8 (X, U[16], U[15]);
and I9[15:0] (F, E, U[15:0]);

assign W = (func[2:1] == 1) ? ~operand_B : operand_B;
assign flags_out[0] = (func[2:1]==0) ? U[16] : (func[2:1]==1) ? ~U[16] : csh;
assign U[0] = (func==1) ? c_in : (func==2) ? 1 : (func==3) ? ~c_in : 0;
assign result = (func==4) ? D : (func==5) ? E : T;



endmodule

/*============================================================================*/






// /*----------------------------------------------------------------------------*/
//
// module Stump_ALU (input  wire [15:0] operand_A,		// First operand
//                                  input  wire [15:0] operand_B,		// Second operand
// 		                          input  wire [ 2:0] func,		// Function specifier
// 		                          input  wire        c_in,		// Carry input
// 		                          input  wire        csh,  		// Carry from shifter
// 		                          output reg  [15:0] result,		// ALU output
// 		                          output reg  [ 3:0] flags_out);	// Flags {N, Z, V, C}
//
//
// /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
// /* Declarations of any internal signals and buses used                        */
// reg [16:0] tmpresult;
//
// /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
//
// /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
// /* Verilog code                                                               */
// always@(*)begin
// 	flags_out = 0;
// 	case (func)
// 		3'b000: //add
// 			begin
// 				tmpresult = operand_A + operand_B;
// 				result = tmpresult[15:0];
// 				flags_out[3] = result[15];
// 				if (result == 0)
// 					flags_out[2] = 1'b1;
// 				if (operand_A[15] == operand_B[15] && operand_A[15] != result[15])
// 					flags_out[1] = 1'b1;
// 				flags_out[0] = tmpresult[16];
// 			end
// 		3'b001: //adc
// 			begin
// 				tmpresult = operand_A + operand_B + c_in;
// 				result = tmpresult[15:0];
// 				flags_out[3] = result[15];
// 				if (result == 0)
// 					flags_out[2] = 1'b1;
// 				if (operand_A[15] == operand_B[15] && operand_A[15] != result[15])
// 					flags_out[1] = 1'b1;
// 				flags_out[0] = tmpresult[16];
// 			end
// 		3'b010: //sub
// 			begin
// 				tmpresult = operand_A + ~operand_B + 1;
// 				result = tmpresult[15:0];
// 				flags_out[3] = result[15];
// 				if (result == 0)
// 					flags_out[2] = 1'b1;
// 				if (operand_A[15] != operand_B[15] && operand_B[15] == result[15])
// 					flags_out[1] = 1'b1;
// 				flags_out[0] = tmpresult[16];
// 			end
// 		3'b011: //sbc
// 			begin
// 				tmpresult = operand_A + (~operand_B + 1) + (~c_in + 1);
// 				result = tmpresult[15:0];
// 				flags_out[3] = result[15];
// 				if (result == 0)
// 					flags_out[2] = 1'b1;
// 				if (operand_A[15] != operand_B[15] && operand_B[15] == result[15])
// 					flags_out[1] = 1'b1;
// 				flags_out[0] = tmpresult[16];
// 			end
// 		3'b100: //and
// 			begin
// 				result = operand_A & operand_B;
// 				flags_out[3] = result[15];
// 				if (result == 0)
// 					flags_out[2] = 1'b1;
// 				flags_out[1] = 1'b0;
// 				flags_out[0] = csh;
// 			end
// 		3'b101: //or
// 			begin
// 				result = operand_A | operand_B;
// 				flags_out[3] = result[15];
// 				if (result == 0)
// 					flags_out[2] = 1'b1;
// 				flags_out[1] = 1'b0;
// 				flags_out[0] = csh;
// 			end
// 		3'b110: //ldst
// 			begin
// 				result = operand_A + operand_B;
// 				flags_out[3] = 1'bx;
// 				flags_out[2] = 1'bx;
// 				flags_out[1] = 1'bx;
// 				flags_out[0] = 1'bx;
// 			end
// 		3'b111: //bcc
// 			begin
// 				result = operand_A + operand_B;
// 				flags_out[3] = 1'bx;
// 				flags_out[2] = 1'bx;
// 				flags_out[1] = 1'bx;
// 				flags_out[0] = 1'bx;
// 			end
// 		default:
// 			begin
// 				result = 0;
// 				flags_out[3] = 1'bx;
// 				flags_out[2] = 1'bx;
// 				flags_out[1] = 1'bx;
// 				flags_out[0] = 1'bx;
// 			end
// 	endcase
// end
//
//
// /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
//
// /*----------------------------------------------------------------------------*/
//
// endmodule

/*============================================================================*/

