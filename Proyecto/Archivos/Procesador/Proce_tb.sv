module Proce_tb();
	logic clk;
	logic start;
	logic reset;
	logic [31:0] WriteData, DataAdr,rd;
	logic MemWrite;
	// instantiate device to be tested
	Proce dut(clk, reset,start, WriteData,rd, DataAdr, MemWrite);
	// initialize test
	initial
	begin
		reset <= 1; # 22; reset <= 0;
	end
	// generate clock to sequence tests
	always
	begin
		clk <= 1; # 5; clk <= 0; # 5;
	end
	// check that 7 gets written to address 0x64
	// at end of program
	always @(negedge clk)
	begin
		start = 1;
		if(MemWrite) begin
			if(DataAdr === 100 & WriteData === 7) begin
				$display("Simulation succeeded");
				$stop;
			end else if (DataAdr !== 96) begin
				$display("Simulation failed");
				$stop;
			end
		end
	end
endmodule