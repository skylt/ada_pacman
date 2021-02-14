
with levelTypes;     use levelTypes;
with stmifaceTypes;  use stmifaceTypes;
with Movable.player;
with Movable;


package level is

	procedure displayText(x, y : Integer; str : String)
	  with Pre => x in Integer(Screen_Width'First) .. Integer(Screen_Width'Last) and
	              y in Integer(Screen_Height'First) .. Integer(Screen_Height'Last);

	procedure clearText(x, y, len : Integer)
	  with Pre => x in Integer(Screen_Width'First) .. Integer(Screen_Width'Last) and
	              y in Integer(Screen_Height'First) .. Integer(Screen_Height'Last) and
	              len in Integer(Screen_Width'First) .. Integer(Screen_Width'Last);

	procedure updateDisplay(x, y : Integer; c : Character)
	  with Pre => x in Integer(Screen_Width'First) .. Integer(Screen_Width'Last) and
	              y in Integer(Screen_Height'First) .. Integer(Screen_Height'Last);

	function checkPrintMap(printMap : PrintableMap) return Boolean;

	procedure drawMap(printMap : PrintableMap)
	  with Pre => checkPrintMap(printMap);

	procedure displayScore(score : Integer)
	  with Pre => score in 0 .. 9999;

	procedure displayLives(p : Movable.player.Life)
	  with Pre => p'Valid;

	function canGoHere(printMap : PrintableMap; char : Movable.Movable'Class) return boolean
	  with Pre => (char.representation = '&' or char.representation = 'X' or
				  char.representation = 'C');

end level;
