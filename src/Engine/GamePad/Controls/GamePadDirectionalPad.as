package Engine.GamePad.Controls 
{
	public class GamePadDirectionalPad extends GamePadControl 
	{
		protected var fUp:GamePadButton = null;
		protected var fDown:GamePadButton = null;
		protected var fLeft:GamePadButton = null;
		protected var fRight:GamePadButton = null;

		public function GamePadDirectionalPad(): void 
		{
			super();
		}
		
		/**
		 * @param Array: Up, Down, Left, Right
		 */		
		override public function SetInputs( aInputs: Array ): void
		{
			fUp    = CreateButtonControl( aInputs, 0 );
			fDown  = CreateButtonControl( aInputs, 1 );
			fLeft  = CreateButtonControl( aInputs, 2 );
			fRight = CreateButtonControl( aInputs, 3 );
		}	
		
		override public function Reset():void 
		{
			super.Reset();
			if( fUp )
				fUp.Reset();
			if( fDown )
				fDown.Reset();
			if( fLeft )
				fLeft.Reset();
			if( fRight )
				fRight.Reset();
		}
		
		public function get Left(): GamePadButton
		{
			return fLeft;
		}
		
		public function get Right(): GamePadButton
		{
			return fRight;
		}
		
		public function get Up(): GamePadButton
		{
			return fUp;
		}
		
		public function get Down(): GamePadButton
		{
			return fDown;
		}
	}
}
