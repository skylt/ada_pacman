
with STM32.GPIO;
with HAL.Bitmap;   use HAL.Bitmap;
with BMP_Fonts;
with LCD_Std_Out; use LCD_Std_Out;


package body stmiface is

	BG : constant Bitmap_Color := (Alpha => 255, others => 64);

	procedure Clear is
	begin
		Display.Hidden_Buffer(1).all.Set_Source (BG);
		Display.Hidden_Buffer(1).all.Fill;
		LCD_Std_Out.Clear_Screen;
		Display.Update_Layer(1, Copy_Back => True);
	end Clear;


	procedure Init is
	begin

		Display.Initialize;
		Display.Initialize_Layer (1, ARGB_8888);
		LCD_Std_Out.Set_Font (BMP_Fonts.Font16x24);
		LCD_Std_Out.Current_Background_Color := BG;
		Clear;
		Put_Line("Init");
		delay 1.0;
	end Init;

end stmiface;
