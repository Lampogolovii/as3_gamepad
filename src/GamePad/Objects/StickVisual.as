package GamePad.Objects {
	import Engine.Utils.CommonUtils;
	import flash.display.Sprite;

	/**
	 * @author tiMMy
	 */
	public class StickVisual extends Sprite 
	{
		protected const deltaPos: int = 30;
		protected var fBack: Sprite = null;
		protected var fJoystick: Sprite = null;
		protected var fPressedJoystick: Sprite = null;
		public function StickVisual() 
		{
			Init();
		}
		
		protected function Init(): void
		{
			fBack = CommonUtils.CreateRasterizedSprite( new mcStick_Back_1() );
			fJoystick = CommonUtils.CreateRasterizedSprite( new mcStick_1() );
			fPressedJoystick = CommonUtils.CreateRasterizedSprite( new mcStick_2() );
			fPressedJoystick.visible = false;
			addChild( fBack );
			addChild( fJoystick );
			addChild( fPressedJoystick );
		}
		
		public function SetValue( aPressed: Boolean, aX: Number, aY: Number ): void
		{
			fJoystick.x = fPressedJoystick.x = aX * deltaPos;
			fJoystick.y = fPressedJoystick.y = -aY * deltaPos;
			fJoystick.visible = !aPressed;
			fPressedJoystick.visible = aPressed;
		}		
	}
}