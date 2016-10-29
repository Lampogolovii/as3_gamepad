package Engine.GamePad.Controls 
{
	import flash.events.Event;
	public class GamePadButton extends GamePadSimpleControl 
	{
		protected var fID: int = 0;
		protected var fChanged: Boolean = false;
		protected var fValue: Number = 0;
		protected var fMinimum: Number = 0;
		protected var fMinimumHold: Number = 0;
		protected var fMaximum: Number = 0;

		public function GamePadButton() 
		{
			super();
			fMinimumHold = 0.5;
			fMinimum = 0;
			fMaximum = 1;
		}
		
		public function SetID( aID: int ): void
		{
			fID = aID;
		}
		
		public function get ID(): int
		{
			return fID;
		}
		
		public function SetMinMaxValues( aMin: Number, aMax: Number ): void
		{
			fMinimum = aMin;
			fMaximum = aMax;
			fMinimumHold = (aMin + aMax) / 2;
			fValue = fMinimum;
		}
		
		public function get Held():Boolean 
		{
			return (fValue >= fMinimumHold) && (fValue <= fMaximum);
		}
		
		override public function Reset():void 
		{
			super.Reset();
			fValue = 0;
		}
		
		public function Value(): Number
		{
			return fValue;
		}		
		
		public function NormalizedValue(): Number
		{
			return ( fValue - fMinimum ) / (fMaximum - fMinimum);
		}		

		override protected function onChange(event:Event):void 
		{
			super.onChange( event );
			if(event.target == fControl)
				fValue = fControl.value;
		}		
	}
}
