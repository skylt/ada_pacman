with LCD_Std_Out; use LCD_Std_Out;


package body level is

	procedure displayText(x, y : Integer; str : String) is
	begin
		for I in str'Range loop
			updateDisplay(x + I - 1, y, str(I));
		end loop;
	end displayText;

	procedure clearText(x, y, len : Integer) is
	begin
		for I in 1 .. len loop
			updateDisplay(I + x - 1, y, ' ');
		end loop;
	end clearText;

	procedure updateDisplay(x, y : Integer; c : Character) is
	begin
		Put((x - 1) * 16 + 1, (y - 1) * 24 + 4, c);
	end updateDisplay;

	function checkPrintMap(printMap : PrintableMap) return Boolean is
	begin
		for I in PrintMap'Range loop
			if printMap(I)'Length /= Width'Last then
				return False;
			end if;
		end loop;
		return True;
	end checkPrintMap;

	procedure drawMap(printMap: PrintableMap) is
	begin
		for y in Height loop
			Put_Line(printMap(y));
		end loop;
	end drawMap;

	procedure displayScore(score : Integer) is
		s : constant String := Integer'Image(score);
	begin
		displayText(1, 12, "SCORE");
		displayText(6, 12, s);
	end displayScore;

	procedure displayLives(p : Movable.player.Life) is
		liveCount: constant Character:= Integer'Image(Integer(p))(2);
	begin
		displayText(6, 13, "| LIVES");
		updateDisplay(14, 13, liveCount);
	end displayLives;

	function canGoHere(printMap : PrintableMap; char : Movable.Movable'Class) return boolean is
	begin
	case printMap(char.position.y)(Integer(char.position.x)) is
		when '#' =>
			return false;
		when '+' =>
			return char.representation = '&';
		when others => return true;
	end case;
end canGoHere;


end level;
