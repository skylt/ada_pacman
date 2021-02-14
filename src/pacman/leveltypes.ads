package levelTypes is

	type Width is new Integer range 1 .. 14
	  with Default_Value => 14;
	
	type Height is new Integer range 1 .. 11
	  with Default_Value => 11;

	type Vector is record
		x:	Width;
		y:	Height;
	end record;
	
	type Movement is (Left, Up, Right, Down, None)
	  with Default_Value => None;
	
	type Tile is array (1 .. 7) of Character;
	AllTiles: Tile := ('#', '~', '*', '+', 'C', '&', ' ');

	type Map is array(Height, Width) of integer;
	type PrintableMap is array(Height) of String(1 .. 14);
	
	defaultMap : Map := (
	(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
	(1, 1, 2, 2, 3, 2, 2, 2, 2, 2, 2, 2, 2, 1),
	(1, 2, 2, 1, 1, 1, 1, 1, 2, 1, 1, 1, 2, 1),
	(1, 2, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1),
	(1, 2, 2, 2, 2, 1, 4, 4, 4, 1, 2, 1, 2, 1),
	(1, 2, 1, 1, 1, 1, 7, 6, 7, 1, 2, 1, 2, 1),
	(1, 2, 2, 2, 2, 1, 1, 1, 1, 1, 2, 2, 2, 1),
	(1, 2, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 2, 1),
	(1, 2, 1, 1, 1, 2, 1, 2, 1, 1, 1, 1, 2, 1),
	(1, 2, 2, 5, 2, 2, 1, 2, 2, 2, 2, 3, 2, 1),
	(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1));

	
	
end levelTypes;
