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

module uart_tx(
    input clk,
    input send,
    input [7:0] data,
    output reg notif,
    output reg out
    );

    reg [2:0] state;

    // states
    localparam s_idle = 3'b000;
    localparam s_start_bit = 3'b001;
    localparam s_data_bit = 3'b010;
    localparam s_stop_bit = 3'b011;
    localparam s_cleanup = 3'b100;

    // clock cycles per bit transmitted
    // 100000000 / 9600 ~= 10416
    parameter cycles = 10416;

    integer clock_count = 0;
    integer bit_index = 7;
    
    always @(posedge clk) begin
        case (state)
        s_idle:
            begin
                notif <= 1'b0;
                out <= 1'b1;
                if (send == 1'b1)
                    begin
                        clock_count <= 0;
                        bit_index <= 7;
                        state <= s_start_bit;
                    end
                else
                    begin
                        state <= s_idle;
                    end
            end
        s_start_bit:
            begin
                notif <= 1'b1;
                out <= 1'b0;
                if (clock_count < cycles-1)
                    begin
                        clock_count <= clock_count+1;
                        state <= s_start_bit; 
                    end
                else
                    begin
                        clock_count <= 0;
                        state <= s_data_bit;
                    end
            end
        s_data_bit:
            begin
                notif <= 1'b1;
                out <= data[bit_index];
                if (clock_count < cycles-1)
                    begin
                        clock_count <= clock_count+1;
                        state <= s_data_bit;    
                    end
                else
                    begin
                        clock_count <= 0;
                        if (bit_index > 0)
                            begin
                                bit_index <= bit_index-1;
                                state <= s_data_bit;
                            end
                        else
                            begin
                                bit_index <= 7;
                                state <= s_stop_bit;
                            end
                    end
            end
        s_stop_bit:
            begin
                notif <= 1'b1;
                out <= 1'b1;
                if (clock_count < cycles-1)
                    begin
                        clock_count <= clock_count+1;
                        state <= s_stop_bit;    
                    end
                else
                    begin
                        clock_count <= 0;
                        state <= s_cleanup;
                    end
            end
        s_cleanup:
            begin
                notif <= 1'b1;
                out <= 1'b1;
                state <= s_idle;
            end
        default:
            state <= s_idle;
        endcase
    end
endmodule
