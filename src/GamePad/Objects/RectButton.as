package GamePad.Objects {
	import Engine.Utils.CommonUtils;
	import flash.display.Sprite;

	/**
	 * @author tiMMy
	 */
	public class RectButton extends BaseButton 
	{
		protected var fBack: Sprite = null;
		protected var fPressedBack: Sprite = null;
		
		public function RectButton() 
		{
			super();
		}
		
		override protected function Init(): void
		{
			super.Init();
			fBack = CommonUtils.CreateRasterizedSprite( new mcRectButton_Back() );
			fPressedBack = CommonUtils.CreateRasterizedSprite( new mcRectButton_1() );
			addChild( fBack );
			addChild( fPressedBack );
			fPressedBack.visible = false;
		}	
		
		override public function SetPressed( aValue: Boolean, aForced: Boolean ): void
		{
			super.SetPressed(aValue, aForced);
			fPressedBack.visible = aValue;
		}
	}
}