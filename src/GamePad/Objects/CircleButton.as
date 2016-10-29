package GamePad.Objects {
	import Engine.Utils.CommonUtils;
	import flash.display.Sprite;

	public class CircleButton extends BaseButton 
	{
		protected var fBack: Sprite = null;
		protected var fPressedBack: Sprite = null;
		
		public function CircleButton() 
		{
			super();
		}
		
		override protected function Init(): void
		{
			super.Init();
			fBack = CommonUtils.CreateRasterizedSprite( new mcCircleButton_1() );
			fPressedBack = CommonUtils.CreateRasterizedSprite( new mcCircleButton_2() );
			addChild( fBack );
			addChild( fPressedBack );
			fPressedBack.visible = false;
		}	
		
		override public function SetPressed( aValue: Boolean, aForced: Boolean ): void
		{
			super.SetPressed(aValue, aForced);
			fBack.visible = !aValue;
			fPressedBack.visible = aValue;
		}
	}
}