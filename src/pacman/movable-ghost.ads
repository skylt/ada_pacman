package Movable.ghost is

	type Ghost is new Movable with null record;

	procedure Initialize(self: in out Ghost);

end Movable.ghost;
