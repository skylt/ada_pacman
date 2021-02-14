
with STM32.Board;  use STM32.Board;

package stmiface is

	procedure Clear
	  with Pre => Display.Initialized;

	procedure Init
	  with Post => Display.Initialized;

end stmiface;
