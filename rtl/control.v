/*
Copyright 2023 The Moss Authors.

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

module control (
    // NOTE(hasheddan): only need 5 bits of opcode, 2 least significant bits are always 2'b11.
    input [4:0] opcode,
    output reg branch,
    output reg jump,
    output reg mem_read,
    output reg mem_to_reg,
    output reg [1:0] alu_op,
    output reg mem_write,
    output reg alu_src,
    output reg reg_write
);

  localparam OPCODE_ALU_RR = 5'b01100;
  localparam OPCODE_ALU_IMM = 5'b00100;
  localparam OPCODE_LOAD = 5'b00100;
  localparam OPCODE_JUMP_INDIRECT = 5'b11001;
  localparam OPCODE_STORE = 5'b01000;
  localparam OPCODE_BRANCH_CONDITIONAL = 5'b11000;
  localparam OPCODE_JUMP_LINK = 5'b11011;

  // NOTE(hasheddan): because we are using a single cycle implementation, we don't have to
  // maintain state for control signals.
  always @(*) begin
    case (opcode)
      OPCODE_ALU_RR: begin
        branch = 1'b0;
        jump = 1'b0;
        mem_read = 1'b0;
        mem_to_reg = 1'b0;
        alu_op = 2'b10;
        mem_write = 1'b0;
        alu_src = 1'b0;
        reg_write = 1'b1;
      end
      OPCODE_ALU_IMM: begin
        branch = 1'b0;
        jump = 1'b0;
        mem_read = 1'b0;
        mem_to_reg = 1'b0;
        alu_op = 2'b10;
        mem_write = 1'b0;
        alu_src = 1'b1;
        reg_write = 1'b1;
      end
      OPCODE_LOAD: begin
        branch = 1'b0;
        jump = 1'b0;
        mem_read = 1'b1;
        mem_to_reg = 1'b1;
        alu_op = 2'b00;
        mem_write = 1'b0;
        alu_src = 1'b1;
        reg_write = 1'b1;
      end
      OPCODE_JUMP_INDIRECT: begin
        branch = 1'b0;
        jump = 1'b1;
        mem_read = 1'b1;
        mem_to_reg = 1'b1;
        alu_op = 2'b00;
        mem_write = 1'b0;
        alu_src = 1'b0;  // DC
        reg_write = 1'b1;
      end
      OPCODE_STORE: begin
        branch = 1'b0;
        jump = 1'b0;
        mem_read = 1'b0;
        mem_to_reg = 1'b0;  // DC
        alu_op = 2'b00;
        mem_write = 1'b1;
        alu_src = 1'b1;
        reg_write = 1'b0;
      end
      OPCODE_BRANCH_CONDITIONAL: begin
        branch = 1'b1;
        jump = 1'b0;
        mem_read = 1'b0;
        mem_to_reg = 1'b0;  // DC
        alu_op = 2'b01;
        mem_write = 1'b1;
        alu_src = 1'b0;
        reg_write = 1'b0;
      end
      OPCODE_JUMP_LINK: begin
        branch = 1'b0;
        jump = 1'b1;
        mem_read = 1'b0;
        mem_to_reg = 1'b1;
        alu_op = 2'b10;
        mem_write = 1'b0;
        alu_src = 1'b1;
        reg_write = 1'b0;
      end
      default: begin
        // TODO(hasheddan): raise interrupt.
        branch = 1'b0;
        jump = 1'b0;
        mem_read = 1'b0;
        mem_to_reg = 1'b0;
        alu_op = 2'b00;
        mem_write = 1'b0;
        alu_src = 1'b0;
        reg_write = 1'b0;
      end
    endcase
  end
endmodule
