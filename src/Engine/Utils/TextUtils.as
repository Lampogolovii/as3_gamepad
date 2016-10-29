package Engine.Utils
{
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class TextUtils
	{
		[Embed(source = "/Matiz.ttf", fontName = "MyEvogriaBold", embedAsCFF = "false")]
		protected static var EmbedFont:Class;
		
		protected static var fTempInt: uint = 0;
		protected static var fTempNumber: Number = 0;
		protected static var fTempString: String = '';
		protected static var fFixed: int = 0;
		
		public function TextUtils()
		{
		}
		
		static public function CreateTextFormat(aFont: String, aSize: int, aColor: uint, aAlign: String, aSpacing: Number): TextFormat
		{
			var result: TextFormat = new TextFormat();
			result.font = aFont;
			result.size = aSize;
			result.align = aAlign;
			result.color = aColor;
			result.letterSpacing = aSpacing;
			return result;
		}
		
		static public function CreateTextField(): TextField
		{
			var result: TextField = new TextField();
			return result;
		}
		
		static public function CreateCustomTextField(aSize: int, aColor: uint, aAlign: String, aSpacing: Number): TextField
		{
			var result: TextField = new TextField();
			result.mouseEnabled = false;
			result.mouseWheelEnabled = false;
			result.selectable = false;
			result.width = 52;
			result.defaultTextFormat = CreateTextFormat('MyEvogriaBold', aSize, aColor, aAlign, aSpacing);
			result.embedFonts = true;
			return result;
		}
		
		static protected var c: Vector.<String> = new <String> ['k', 'm', 'b', 't'];
		
		static public function EnergyIntToText(aValue: Number): String
		{
			return FormatInt(aValue, 2);
		}		
		
		static public function MoneyIntToText(aValue: Number): String
		{
			return FormatInt(aValue, 3);
		}		
		
		static public function FormatInt(aValue: Number, aValuesCount: int): String
		{
			fTempNumber = aValue;
			
			if( fTempNumber < 1000)
				return String(fTempNumber);
			
			var iter: int = 0;
			while(fTempNumber >= 1000)
			{
				fTempNumber = fTempNumber / 1000;
				iter++;
			}
			
			if(aValuesCount == 3)
			{
				if(fTempNumber >= 100)
					fFixed = 0;
				else if(fTempNumber >= 10)
					fFixed = 1;
				else if(fTempNumber >= 1)
					fFixed = 2;
			}
			else if (aValuesCount == 2)
			{
				if(fTempNumber >= 10)
					fFixed = 0;
				else if(fTempNumber >= 1)
					fFixed = 1;
			}
			
			fTempString = fTempNumber.toFixed( fFixed );
			
			if(fFixed > 0)
			{
				while(fTempString.charAt( fTempString.length - 1 ) == '0')
					fTempString = fTempString.slice(0, fTempString.length - 1);
					
				if(fTempString.charAt( fTempString.length - 1 ) == '.')
					fTempString = fTempString.slice(0, fTempString.length - 1);
			}
			
			return fTempString + ' ' + c[iter - 1];
		}		
		
	}
}