package GamePad.Objects {
	import Engine.Utils.CommonUtils;
	import flash.text.TextFormatAlign;
	import Engine.Utils.TextUtils;
	import flash.text.TextField;
	import flash.display.Sprite;
	import GamePad.Objects.CircleButton;

	public class TextCircleButton extends CircleButton 
	{
		protected var fTextSprite: Sprite = null;
		
		public function TextCircleButton() 
		{
			super();
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
				var textField: TextField = TextUtils.CreateCustomTextField(25, 0xA09173, TextFormatAlign.CENTER, -3);
				textField.x = -21;
				textField.width = 40;
				textField.text = aText;
				CommonUtils.RasterizeToSprite( textField, fTextSprite );
				fTextSprite.y = int( -textField.textHeight / 2 - 2);
			}
		}
	}
}