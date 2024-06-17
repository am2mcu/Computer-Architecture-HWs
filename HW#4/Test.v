module Test();

	reg clock, reset;

	Pipeline PipelineArchitecture(clock, reset);

	initial begin
		clock = 0;
		reset = 0;
	end

	always #100 clock = ~clock;

endmodule