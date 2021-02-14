package stmifaceTypes is
   
	type Screen_Width is new Integer range 1 .. 14
	  with Default_Value => 14;
	
	type Screen_Height is new Integer range 1 .. 13
	  with Default_Value => 13;
	
end stmifaceTypes;
