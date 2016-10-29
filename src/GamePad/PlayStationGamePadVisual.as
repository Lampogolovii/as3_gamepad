package GamePad {
	import GamePad.CommonGamePadVisual;

	public class PlayStationGamePadVisual extends CommonGamePadVisual 
	{
		public function PlayStationGamePadVisual() 
		{
			super();
		}
		
		override protected function CreateIcons(): void
		{
			fIcons = new mcIcons_PS_1();
		}		
		
		override protected function SetPositions(): void
		{
			fDPad.x = 130;
			fDPad.y = 200;
			fStickLeft.x = 30;
			fStickLeft.y = 120;
			
			fDPad.x = 30;
			fDPad.y = 120;
			fStickLeft.x = 130;
			fStickLeft.y = 200;
		}		
	}
}