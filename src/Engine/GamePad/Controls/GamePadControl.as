package Engine.GamePad.Controls 
{
	import flash.ui.GameInputControl;
	import flash.events.Event;
	
	public class GamePadControl 
	{
		public function GamePadControl(): void 
		{
		}
		
		public function SetInputs( aInputs: Array ): void
		{
		}
		
		protected function GetInput( aObject: Object ): GameInputControl
		{
			if(aObject != null)
				return aObject as GameInputControl; 
			else
				return null;
		}

		public function Reset():void 
		{
		}

		protected function onChange( event:Event ):void 
		{
		}
		
		protected function CreateButtonControl( aInputs: Array, aIndex: int ): GamePadButton
		{
			var button: GamePadButton = null;
			if((aInputs.length > aIndex) && (GetInput( aInputs[aIndex] ) != null))	
			{
				button = new GamePadButton();
				button.SetInputs( [GetInput( aInputs[aIndex] )] );
			}
			return button;
		}
		
		protected function SetButtonMinMaxValues( aButton: GamePadButton, aMin: Number, aMax: Number): void
		{
			if( aButton )
				aButton.SetMinMaxValues( aMin, aMax );
		}		
	}
}
