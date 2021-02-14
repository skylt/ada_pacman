

package body movable is

	procedure updatePosition(m : in out Movable) is
	begin
		case m.direction is

		when Up =>
			m.position.y := m.position.y - 1;
		when Down =>
			m.position.y := m.position.y + 1;
		when Left =>
			m.position.x := m.position.x - 1;
		when Right =>
			m.position.x := m.position.x + 1;
		when None => null;
		end case;

	end updatePosition;


	procedure revertPosition(m: in out Movable) is
	begin
		case m.direction is

		when Up =>
			m.position.y := m.position.y + 1;
		when Down =>
			m.position.y := m.position.y - 1;
		when Left =>
			m.position.x := m.position.x + 1;
		when Right =>
			m.position.x := m.position.x - 1;
		when None => null;
		end case;

	end revertPosition;

end movable;
