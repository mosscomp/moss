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

// timescale is formatted as <time_unit> / <time_precision>
`timescale 1ns / 1ps

module top(
    input clk,
    input uart_txd_in,
    output uart_rxd_out,
    output [1:0]led
    );

    wire [7:0] data;
    wire send;
    
    uart_rx uart_rx(.clk(clk), .in(uart_txd_in), .notif(led[0]), .data(data), .send(send));
    uart_tx uart_tx(.clk(clk), .send(send), .data(data), .notif(led[1]), .out(uart_rxd_out));

endmodule
