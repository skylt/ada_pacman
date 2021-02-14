with Movable;


package Movable.player is

	type Life is new integer range 0 .. 3;

	type Player is new Movable with record
		lives          : Life        :=	Life'Last;
	end record;

	function getPacMove(p: Player; valA, valB : Integer) return Movement
	  with Pre => valA in 0 | 1 and valB in 0 | 1;

	procedure Initialize (self : in out Player);


end Movable.player;
