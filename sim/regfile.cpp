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

#include <verilated.h>
#include "Vregfile.h"
#include "verilated_vcd_c.h"

int main(int argc, char** argv, char** env) {
	// Pass all arguments to verilator.
	Verilated::commandArgs(argc, argv);

	// Instantiate register file.
        Vregfile *regfile = new Vregfile;

	// Setup tracing.
	Verilated::traceEverOn(true);
    	VerilatedVcdC* tfp = new VerilatedVcdC;
    	regfile->trace(tfp, 99);
	tfp->open("obj_dir/regfile.vcd");

	// Sim counter.
	int i = 0;

	// Cycle clock.
	regfile->clk ^= 1;
	regfile->eval();
	tfp->dump(i);
	i++;

	// Write 12 to register 28.
	regfile->clk ^= 1;
	regfile->rd = 28;
	regfile->data = 12;
	regfile->write_ctrl = 1;
	regfile->eval();
	tfp->dump(i);
	i++;

	// Cycle clock.
	regfile->clk ^= 1;
	regfile->eval();
	tfp->dump(i);
	i++;

	// Read value from register 28.
	regfile->write_ctrl = 0;
	regfile->clk ^= 1;
	regfile->rs2 = 28;
	regfile->eval();
	tfp->dump(i);
	i++;

	// Cycle clock.
	regfile->clk ^= 1;
	regfile->eval();
	tfp->dump(i);

	tfp->close();
	exit(EXIT_SUCCESS);
}
