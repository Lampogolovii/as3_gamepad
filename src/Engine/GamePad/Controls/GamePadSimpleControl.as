package Engine.GamePad.Controls {
	import flash.events.Event;
	import flash.ui.GameInputControl;

	public class GamePadSimpleControl extends GamePadControl 
	{
		protected var fControl: GameInputControl = null;
		
		public function GamePadSimpleControl() 
		{
			super();
		}
		
		override public function SetInputs( aInputs: Array ): void
		{
			super.SetInputs( aInputs );
			if(aInputs.length > 0)
			{
				fControl = GetInput( aInputs[0] );
				if (fControl != null) 
					fControl.addEventListener(Event.CHANGE, onChange);
			}
		}
		
		override protected function onChange(event:Event): void 
		{
			super.onChange( event );
		}		
	}
}