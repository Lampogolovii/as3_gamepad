package GamePad.Objects {
	import flash.text.TextFormatAlign;
	import Engine.Utils.TextUtils;
	import flash.text.TextField;
	import Engine.Utils.CommonUtils;
	import flash.display.Sprite;

	public class AxisProgress extends Sprite 
	{
		protected var fBack: Sprite = null;
		protected var fTextSprite: Sprite = null;
		protected var fProgress: Sprite = null;
		
		public function AxisProgress() 
		{
			Init();
		}
		
		protected function Init(): void
		{
			fBack = CommonUtils.CreateRasterizedSprite( new mcAxis_Back() );
			fProgress = CommonUtils.CreateRasterizedSprite( new mcAxisProgress_1() );
			addChild( fBack );
			addChild( fProgress );
		}
		
		public function SetText( aText: String ): void
		{
			if(!fTextSprite)
			{
				fTextSprite = new Sprite();
				addChild( fTextSprite );
			}
			if(fTextSprite)
			{
				var textField: TextField = TextUtils.CreateCustomTextField(25, 0x4F9183, TextFormatAlign.RIGHT, -3);
				textField.x = -75;
				textField.width = 40;
				textField.text = aText;
				CommonUtils.RasterizeToSprite( textField, fTextSprite );
				fTextSprite.y = int( -textField.textHeight / 2 - 2);
			}
		}
		
		public function SetValue( aValue: Number ): void
		{
			fProgress.x = aValue * (80 - 17 - 17);
		}
	}
}