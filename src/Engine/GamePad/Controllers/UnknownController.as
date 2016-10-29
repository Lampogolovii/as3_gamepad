package Engine.GamePad.Controllers {
	import Engine.GamePad.Controls.GamePadButton;
	import Engine.GamePad.ConstGamePad;
	import Engine.GamePad.Controllers.BaseGameController;

	public class UnknownController extends BaseGameController 
	{
		protected var fButtons: Vector.< GamePadButton > = null;
		protected var fAxis: Vector.< GamePadButton > = null;
		
		public function UnknownController() 
		{
			super();
			fID = ConstGamePad.UNKNOWN;
		}
		
		override protected function MapControls(): void
		{
			super.MapControls();
			if(fDevice)
			{
				if(!fButtons )
					fButtons = new Vector.< GamePadButton >;
				if(!fAxis)
					fAxis = new Vector.< GamePadButton >;
				for(var i: int = 0; i < fControlMap.length; i++)
				{
					var button: GamePadButton = CreateButtonByInputControl( fControlMap[i] )
					
					if(IsButtonByID(fControlMap[i].id))
						fButtons.push( button );
					else if(IsAxisByID(fControlMap[i].id))
					{
						button.SetMinMaxValues( fControlMap[i].minValue, fControlMap[i].maxValue );
						fAxis.push( button );
					}
				}
			}
		}
		
		public function GetButtonsCount(): int
		{
			if(fButtons)
				return fButtons.length;
			else
				return 0;
		}
		
		public function GetAxisCount(): int
		{
			if(fAxis)
				return fAxis.length;
			else
				return 0;
		}

		public function GetButtonByIndex( aIndex: int ): GamePadButton
		{
			if(fButtons)
			{
				if((aIndex >= 0) && (aIndex < fButtons.length)) 
					return fButtons[aIndex];
				else
					return null;
			}
			else
				return null;
		}

		public function GetAxisByIndex( aIndex: int ): GamePadButton
		{
			if(fAxis)
			{
				if((aIndex >= 0) && (aIndex < fAxis.length)) 
					return fAxis[aIndex];
				else
					return null;
			}
			else
				return null;
		}
		
		public function GetButtonIDByIndex( aIndex: int ): int
		{
			return fButtons[aIndex].ID;
		}
		
		public function GetAxisIDByIndex( aIndex: int ): int
		{
			return fAxis[aIndex].ID;
		}
	}
}