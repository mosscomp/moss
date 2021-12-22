/*
Copyright 2020 The Moss Authors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

`timescale 1ns / 1ps

// ALU is passed a control signal and two arguments. It returns the result of
// the operation, which should be the same size as the arguments.
module alu(
    input [1:0] op,
    input [63:0] arg1, arg2,
    output reg [63:0] result
    );

    // operations
    localparam op_and = 2'b00;
    localparam op_or = 2'b01;
    localparam op_add = 2'b10;
    localparam op_sub = 2'b11;

    always @(op, arg1, arg2) begin
        case (op)
            op_and: begin
                result = arg1 & arg2;
            end
            op_or: begin
                result = arg1 | arg2;
            end
            op_add: begin
                result = arg1 + arg2;
            end
            op_sub: begin
                result = arg1 - arg2;
            end
        endcase
    end
endmodule