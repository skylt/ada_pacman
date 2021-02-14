with ada.numerics.Discrete_Random;

with levelTypes;     use levelTypes;
with Movable;        use Movable;
with Movable.ghost;
with Movable.player;

package game is

	subtype randRange is integer range 0..3;
	package random4 is new ada.numerics.discrete_random(randRange);

	type Game is record
		curr_ghost    : ghost.Ghost;
		curr_player   :	player.Player;
		curr_printMap :	PrintableMap;
		curr_food     : Integer;
		curr_score    : Integer;
		curr_gen      : random4.Generator;
	end record;

	procedure printEndGame(g : Game);

	procedure mainGameLoop;

	procedure loadMap (m : Map; g : out Game);

	procedure updateGame(g : in out Game; char : in out Movable.Movable'Class;
					 updatePos : Boolean);

	procedure checkMov(g : Game; char : in out Movable.Movable'Class);

	function checkCollision(g : Game; char : Movable.Movable'Class)
						 return Movement;

end game;
