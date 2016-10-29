package GamePad.Objects {
	import Engine.Utils.CommonUtils;
	import flash.display.Sprite;

	public class ValueButton extends Sprite 
	{
		protected var fBack: Sprite = null;
		protected var fValue: Sprite = null;
		protected var fMask: Sprite = null;
		
		public function ValueButton() 
		{
			Init();
		}
		
		protected function Init(): void
		{
			fBack = CommonUtils.CreateRasterizedSprite( new mcRectButton_Back() );
			fValue = CommonUtils.CreateRasterizedSprite( new mcRectButton_1() );
			fMask = CommonUtils.CreateRasterizedSprite( new mcRectButton_Mask() );
			addChild( fBack );
			addChild( fValue );
			addChild( fMask );
			fMask.x = -36;
			fMask.scaleX = 0;
			fValue.mask = fMask;
		}
		
		public function SetValue( aValue: Number ): void
		{
			fMask.scaleX = aValue;
		}
	}
}