package body Movable.player is

   function getPacMove(p: Player; valA, valB : Integer) return Movement is
   begin
		return Movement'Val(valA * 2 + valB);
   end getPacMove;


	procedure Initialize (self : in out Player) is
	begin
		self.representation := 'C';
	end Initialize;
end Movable.player;
