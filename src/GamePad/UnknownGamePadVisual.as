package GamePad {
	import Engine.GamePad.Controls.GamePadButton;
	import GamePad.Objects.AxisProgress;
	import Engine.GamePad.Controllers.BaseGameController;
	import Engine.GamePad.Controllers.UnknownController;
	import GamePad.Objects.TextCircleButton;
	import flash.display.Sprite;

	public class UnknownGamePadVisual extends Sprite 
	{
		protected const COUNT_IN_COLUMN: int = 4;
		protected var fButtons: Vector.<TextCircleButton> = null;
		protected var fAxis: Vector.<AxisProgress> = null;
		protected var fController: UnknownController = null;
		protected var fI: int = 0;
		
		public function UnknownGamePadVisual() 
		{
		}
		
		public function SetController( aController: BaseGameController): void
		{
			if(aController is UnknownController)
			{
				fController = aController as UnknownController;
				InitButtons();
				InitAxis();
			}
		}
		
		protected function InitButtons(): void
		{
			if(!fButtons)
				fButtons = new Vector.<TextCircleButton>;
			var count: int = fController.GetButtonsCount();
			for(var index: int = fButtons.length; index < count; index++)
			{
				var i: int = Math.floor(index / COUNT_IN_COLUMN);
				var j: int = index % COUNT_IN_COLUMN;
				var button: TextCircleButton = new TextCircleButton();
				button.x = i * 70;
				button.y = j * 70;
				button.SetText( fController.GetButtonIDByIndex(index).toString() );
				fButtons.push( button );	
				addChild( button );
			}
			
			for(index = count; index < fButtons.length; index++)
				fButtons[index].visible = false;
		}
		
		protected function InitAxis(): void
		{
			if(!fAxis)
				fAxis = new Vector.<AxisProgress>;
			var count: int = fController.GetAxisCount();
			for(var index: int = fAxis.length; index < count; index++)
			{
				var axis: AxisProgress = new AxisProgress();
				axis.x = 400;
				axis.y = index * 40 - 10;
				axis.SetText( fController.GetAxisIDByIndex(index).toString() );
				fAxis.push( axis );	
				addChild( axis );
			}
			
			for(index = count; index < fAxis.length; index++)
				fAxis[index].visible = false;			
		}
		
		public function Update(): void
		{
			if( fController )
			{
				for(fI = 0; fI < fButtons.length; fI++)
				{
					var button: GamePadButton = fController.GetButtonByIndex(fI);
					fButtons[fI].SetPressed( button.Held, false);
				}
				
				for(fI = 0; fI < fAxis.length; fI++)
				{
					var button: GamePadButton = fController.GetAxisByIndex(fI);
					fAxis[fI].SetValue( button.NormalizedValue() );
				}
			}
		}
	}
}