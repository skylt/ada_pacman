with STM32;
with Stm32.GPIO; use Stm32.GPIO;
with HAL.GPIO;

with Last_Chance_Handler;  pragma Unreferenced (Last_Chance_Handler);

with STM32.Device; use STM32.Device;



with level;          use level;
with stmiface;       use stmiface;
with Movable.player; use Movable.player;
with LCD_Std_Out;

package body game is

	procedure init_game is
	begin
		Init;
		Clear;
	end init_game;


	procedure printEndGame(g : Game) is
	begin
		Clear;
		for I in 0 .. 5 loop
			LCD_Std_Out.Put_Line("");
		end loop;
		if g.curr_player.lives = 0 then
			LCD_Std_Out.Put_Line("   GAME OVER");
		else
			LCD_Std_Out.Put_Line("   YOU WON !");
		end if;

		delay 10.0;

	end printEndGame;


	procedure handlePlayerCollision(g : in out game) is
	begin
		if g.curr_player.position.x = g.curr_ghost.position.x and
		  g.curr_player.position.y = g.curr_ghost.position.y then
			g.curr_player.representation := 'X';
			updateDisplay(Integer(g.curr_player.position.x), Integer(g.curr_player.position.y),
				g.curr_player.representation);
			g.curr_player.lives := g.curr_player.lives - 1;
			displayLives(g.curr_player.lives);
			g.curr_ghost.position := g.curr_ghost.start_pos;
			g.curr_ghost.below := ' ';
			displayText(1, 13, "LOSE");
			delay 1.0;
			g.curr_player.representation := 'C';
			updateDisplay(Integer(g.curr_player.position.x), Integer(g.curr_player.position.y),
				g.curr_player.representation);
			updateGame(g, g.curr_ghost, True);
			updateGame(g, g.curr_player, False);
			clearText(1, 13, 4);
		end if;
	end handlePlayerCollision;


	procedure mainGameLoop is
		curr_game : Game;
		movGhost  : Movement := None;
		PointA    : GPIO_Point := (GPIO_B'Access, Pin_0);
		PointB    : GPIO_Point := (GPIO_B'Access, Pin_1);
		valPinA   : Integer;
		valPinB   : Integer;

	begin
		-- Init devices
		init_game;
		Set_Mode(PointA, HAL.GPIO.Input);
		Set_Mode(PointB, HAL.GPIO.Input);

		--loadLevel(game);
		loadMap(defaultMap, curr_game);
		curr_game.curr_ghost.direction := Movement'Val(random4.random(curr_game.curr_gen));
		curr_game.curr_player.direction := None;
		drawMap(curr_game.curr_printMap);
		displayScore(curr_game.curr_score);
		displayLives(curr_game.curr_player.lives);

		loop
			-- updatemap
			updateGame(curr_game, curr_game.curr_ghost, True);
			updateGame(curr_game, curr_game.curr_player, True);
			displayScore(curr_game.curr_score);

			-- check if pacman is dead
			handlePlayerCollision(curr_game);

			-- craft directions
			movGhost := checkCollision(curr_game, curr_game.curr_ghost);
			if movGhost /= None then
				curr_game.curr_ghost.direction := movGhost;
			end if;
			valPinA := (if PointA.Set then 1 else 0);
			valPinB := (if PointB.Set then 1 else 0);
			curr_game.curr_player.direction := getPacMove(curr_game.curr_player,
												 valPinA, valPinB);

			if curr_game.curr_food = 0 or curr_game.curr_player.lives = 0 then
				exit;
			end if;
		end loop;

		printEndGame(curr_game);

	end mainGameLoop;


	procedure loadMap (m : Map; g : out Game) is
		food : Integer := 0;
	begin
		for y in Height loop
			for x in Width loop
				g.curr_printMap(y)(Integer(x)) := AllTiles(m(y,x));
				case m(y, x) is
				when 2 | 3 =>
					food := food + 1;
				when 5 =>
					g.curr_player.start_pos.x := x;
					g.curr_player.start_pos.y := y;
					g.curr_player.position.x := x;
					g.curr_player.position.y := y;
				when 6 =>
					g.curr_ghost.start_pos.x := x;
					g.curr_ghost.start_pos.y := y;
					g.curr_ghost.position.x := x;
					g.curr_ghost.position.y := y;
				when others => null;
				end case;
			end loop;
		end loop;

		g.curr_food := food;
		g.curr_score := 0;
		random4.reset(g.curr_gen);

	end loadMap;


	procedure updateGame(g : in out Game; char : in out Movable.Movable'Class;
					  updatePos : Boolean) is
	begin
		if char.representation = 'C' then
			if char.below = '~' then
				g.curr_score := g.curr_score + 10;
				g.curr_food := g.curr_food - 1;
			end if;
			if char.below = '*' then
				g.curr_score := g.curr_score + 50;
				g.curr_food := g.curr_food - 1;
			end if;
			char.below := ' ';
		end if;

		if char.representation = '&' and char.below = 'C' then
			char.below := ' ';
		end if;

		if updatePos then
			g.curr_printMap(char.position.y)(Integer(char.position.x)) := char.below;
			updateDisplay(Integer(char.position.x), Integer(char.position.y), char.below);
			checkMov(g, char);
			char.below := g.curr_printMap(char.position.y)(Integer(char.position.x));
			updateDisplay(Integer(char.position.x), Integer(char.position.y), char.representation);
			g.curr_printMap(char.position.y)(Integer(char.position.x)) := char.representation;
		end if;

	end updateGame;


	procedure checkMov(g : Game; char : in out Movable.Movable'Class) is
		m: Movement := None;
	begin

		updatePosition(char);

		if not canGoHere(g.curr_printMap, char) then
			revertPosition(char);
			if char.representation = '&' then
				loop
					m := Movement'Val(random4.random(g.curr_gen));
					if m /= char.direction then
						exit;
					end if;
				end loop;
				char.direction := m;
			end if;
		end if;

		if char.representation = 'C' then
			char.direction:= None;
		end if;

	end checkMov;


	function checkCollision(g : Game; char : Movable.Movable'Class)
						 return Movement is
	begin
		if g.curr_ghost.position.x - 1 = char.position.x then
			return Up;
		end if;
		if g.curr_ghost.position.x + 1 = char.position.x then
			return Down;
		end if;
		if g.curr_ghost.position.y - 1 = char.position.y then
			return Left;
		end if;
		if g.curr_ghost.position.y + 1 = char.position.y then
			return Right;
		end if;
		return None;
	end checkCollision;


end game;
