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

#include <verilated.h>
#include "Valu.h"

QData aluExec(Valu*& alu, QData a, QData b) {
	alu->arg1 = a;
	alu->arg2 = b;
	alu->eval();
	return alu->result;
}

QData opAnd(Valu*& alu, QData a, QData b) {
	alu->op = 0;
	return aluExec(alu, a, b);
}

QData opOr(Valu*& alu, QData a, QData b) {
	alu->op = 1;
	return aluExec(alu, a, b);
}

QData opAdd(Valu*& alu, QData a, QData b) {
	alu->op = 2;
	return aluExec(alu, a, b);
}

QData opSub(Valu*& alu, QData a, QData b) {
	alu->op = 3;
	return aluExec(alu, a, b);
}

int main(int argc, char** argv, char** env) {
	// Pass all arguments to verilator.
	Verilated::commandArgs(argc, argv);

        // Initialize ALU. We don't trace in this test as the module is not
        // clocked.
        Valu *alu = new Valu;

	if (opAnd(alu, 1, 2) != (1 & 2)) {
		exit(EXIT_FAILURE);
	}
	if (opOr(alu, 1, 2) != (1 | 2)) {
		exit(EXIT_FAILURE);
	}
	if (opAdd(alu, 1, 2) != 3) {
		exit(EXIT_FAILURE);
	}
	if (opSub(alu, 2, 1) != 1) {
		exit(EXIT_FAILURE);
	}
	exit(EXIT_SUCCESS);
}
