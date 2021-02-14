pragma Ada_2012;
package body Movable.ghost is

	procedure Initialize (self : in out Ghost) is
	begin
		self.representation := '&';
	end Initialize;

end Movable.ghost;
