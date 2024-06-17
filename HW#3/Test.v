module Test();

	reg clock;

	FUM_MIPS single_cycle_microarchitecture(clock);

	initial begin
		clock = 0;
	end

	always #50 clock = ~clock;

endmodule