package Engine.Utils {
	import flash.display.DisplayObject;
	import flash.display.Stage;
	
	public class AppScales 
	{
		static protected const FLASH_WIDTH: Number = 700;
		static protected const FLASH_HEIGHT: Number = 525;
		
		static protected var fStage: Stage = null;
		static protected var fAppScale: Number = 1;
		static protected var fFullScreenWidth: Number = 1;
		static protected var fFullScreenHeight: Number = 1;
		static protected var fViewWidth: Number = 1;
		static protected var fViewHeight: Number = 1;		
		
		static public function SetStage(aWidth: Number, aHeight: Number): void
		{
			fFullScreenWidth = aWidth;
			fFullScreenHeight = aHeight;
			var sX: Number = aWidth / FLASH_WIDTH;
			var sY: Number = aHeight / FLASH_HEIGHT;
			fAppScale = Math.min(sX, sY);
			
			fViewWidth = aWidth / fAppScale;
			fViewHeight = aHeight / fAppScale;
		}
		
		static public function GetFullScreenWidth(): Number
		{
			return fFullScreenWidth;
		}
		
		static public function GetFullScreenHeight(): Number
		{
			return fFullScreenHeight;
		}
		
		static public function GetStageWidth(): Number
		{
			return fViewWidth;
		}
		
		static public function GetStageHeight(): Number
		{
			return fViewHeight;
		}
		
		static public function GetDeltaViewWidth(): Number
		{
			return GetStageWidth() - FLASH_WIDTH;
		}
		
		static public function GetDeltaViewHeight(): Number
		{
			return GetStageHeight() - FLASH_HEIGHT;
		}
		
		static public function GetDeltaViewHalfWidth(): Number
		{
			return int(GetDeltaViewWidth() / 2);
		}
		
		static public function GetDeltaViewHalfHeight(): Number
		{
			return int(GetDeltaViewHeight() / 2);
		}
		
		static public function GetDeltaToLeft(): Number
		{
			return GetDeltaViewHalfWidth();
		}
		
		static public function GetDeltaToRight(): Number
		{
			return GetDeltaViewHalfWidth();
		}
		
		static public function GetDeltaToTop(): Number
		{
			return GetDeltaViewHalfHeight();
		}
		
		static public function GetDeltaToBottom(): Number
		{
			return GetDeltaViewHalfHeight();
		}
		
		static public function GetAppScale(): Number
		{
			return fAppScale;
		}
		
		static public function FloorAppPosition( aPosition: Number): Number
		{
			return Math.round( aPosition * fAppScale ) / fAppScale;	
		}		
	}
}
