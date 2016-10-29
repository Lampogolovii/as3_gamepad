package Engine.GamePad.Controls 
{
	public class GamePadStick extends GamePadDirectionalPad 
	{
		protected static const JOYSTICK_THRESHOLD:Number = 0.5;

		protected var fAxisX: GamePadButton;
		protected var fAxisY: GamePadButton;
		protected var fButton: GamePadButton;
		protected var fReversedY: Boolean = false;
		
		public function GamePadStick() 
		{
			super();
		}
		
		/**
		 * @param Array: X, Y, Button
		 */		
		override public function SetInputs( aInputs: Array ): void
		{
			fAxisX = CreateButtonControl( aInputs, 0 );
			fAxisY = CreateButtonControl( aInputs, 1 );
			fButton = CreateButtonControl( aInputs, 2 );
			
			fUp    = CreateButtonControl( aInputs, 1 );
			fDown  = CreateButtonControl( aInputs, 1 );
			fLeft  = CreateButtonControl( aInputs, 0 );
			fRight = CreateButtonControl( aInputs, 0 );
			
			SetButtonMinMaxValues(fLeft,  -1,                 -JOYSTICK_THRESHOLD );
			SetButtonMinMaxValues(fRight, JOYSTICK_THRESHOLD,  1 );
			SetUpDownButtonsValues();
		}	
		
		public function SetReversed( aValue: Boolean ): void
		{
			fReversedY = aValue;
			SetUpDownButtonsValues();
		}
		
		protected function SetUpDownButtonsValues(): void
		{
			if( fReversedY )
			{
				SetButtonMinMaxValues(fUp,      JOYSTICK_THRESHOLD,  1 );
				SetButtonMinMaxValues(fDown,    -1,                 -JOYSTICK_THRESHOLD );
			}
			else;
			{
				SetButtonMinMaxValues(fUp,    -1,                 -JOYSTICK_THRESHOLD );
				SetButtonMinMaxValues(fDown,  JOYSTICK_THRESHOLD,  1 );
			}
		}
		
		override public function Reset():void 
		{
			super.Reset();
			if( fButton )
				fButton.Reset();
			if( fAxisX )
				fAxisX.Reset();
			if( fAxisY )
				fAxisY.Reset();
		}		
		
		public function get Held():Boolean 
		{
			if(fButton)
				return fButton.Held;
			else
				return false;
		}
		
		public function get x():Number 
		{
			if(fAxisX)
				return fAxisX.Value();
			else
				return 0;
		}
		
		public function get y():Number 
		{
			if(fAxisY)
			{
				if(fReversedY)
					return -fAxisY.Value();
				else
					return fAxisY.Value();
			}
			else
				return 0;
		}
		
		public function get angle():Number 
		{
			return Math.atan2(y, x);
		}
		
		public function get rotation():Number 
		{
			return (Math.atan2(-y, x) + (Math.PI / 2));
		}
		
		public function get distance():Number 
		{
			return Math.min(1, Math.sqrt(x * x + y * y));
		}
	}
}
