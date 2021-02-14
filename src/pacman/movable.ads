with Ada.Finalization;
with levelTypes; use levelTypes;

package Movable is

	type Movable is new Ada.Finalization.Controlled with record
		position       : Vector;
		direction      : Movement  := None;
		start_pos      : Vector;
		below          : Character := ' ';
		representation : Character := '^';
	end record;

	procedure updatePosition(m : in out Movable);

	procedure revertPosition(m : in out Movable);

end Movable;
