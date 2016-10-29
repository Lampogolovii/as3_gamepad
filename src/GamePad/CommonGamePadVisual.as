package GamePad {
	import GamePad.Objects.ValueButton;
	import GamePad.Objects.BaseButton;
	import GamePad.Objects.RectButton;
	import GamePad.Objects.DirectionalPadVisual;
	import GamePad.Objects.StickVisual;
	import Engine.GamePad.Controllers.CommonController;
	import Engine.GamePad.Controllers.BaseGameController;
	import GamePad.Objects.IconCircleButton;
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class CommonGamePadVisual extends Sprite 
	{
		protected var fIcons: MovieClip = null;
		protected var fButtons: Vector.<BaseButton> = null;
		protected var fStickLeft: StickVisual = null;
		protected var fStickRight: StickVisual = null;
		protected var fDPad: DirectionalPadVisual = null;
		protected var fL1: RectButton = null;
		protected var fR1: RectButton = null;
		protected var fLeftT: ValueButton = null;
		protected var fRightT: ValueButton = null;
		
		protected var fI: int = 0;
		protected var fController: CommonController = null;
		
		public function CommonGamePadVisual() 
		{
			Init();
		}
		
		public function SetController( aController: BaseGameController): void
		{
			if(aController is CommonController)
				fController = aController as CommonController;
		}
		
		protected function CreateIcons(): void
		{
			fIcons = new mcIcons_XBox_1();
		}
		
		protected function Init(): void
		{
			CreateIcons();
			fButtons = new Vector.<BaseButton>;
			fStickLeft = new StickVisual();
			fStickRight = new StickVisual();
			fDPad = new DirectionalPadVisual();
			fL1 = new RectButton();
			fR1 = new RectButton();
			fLeftT = new ValueButton();
			fRightT = new ValueButton();
			
			PushButton(1,   0,   50);
			PushButton(2,   60,  0);
			PushButton(3,  -60,  0);
			PushButton(4,   0,  -50);
			fButtons.push( fL1 );
			fButtons.push( fR1 );
			
			fLeftT.x = fL1.x = 60;
			fRightT.x = fR1.x = 460 - fL1.x;	
			fL1.y = fR1.y = 10;
			fLeftT.y = fRightT.y = -30;
					
			fDPad.x = 130;
			fDPad.y = 200;
			fStickLeft.x = 30;
			fStickLeft.y = 120;
			fStickRight.x = 280;
			fStickRight.y = 200;
			addChild( fStickLeft );
			addChild( fStickRight );
			addChild( fDPad );
			addChild( fL1 );
			addChild( fR1 );
			addChild( fLeftT );
			addChild( fRightT );
			
			SetPositions();
		}
		
		protected function SetPositions(): void
		{
		}
		
		protected function PushButton( aFrame: int, aX: int, aY: int ): void
		{
			var button: IconCircleButton = new IconCircleButton();
			button.SetIcon( fIcons, aFrame );
			button.x = 400 + aX;
			button.y = 120 + aY;
			addChild( button );
			fButtons.push( button );
		}
		
		protected function SetPressed( aArray: Array ): void
		{
			for(fI = 0; fI < aArray.length; fI++)
			{
				if(( fI < fButtons.length ) && (aArray[fI] is Boolean))
					fButtons[fI].SetPressed( aArray[fI] as Boolean, false );
			}
		}
		
		public function Update(): void
		{
			if(fController)
			{
				if(fController.A && fController.B && fController.X && fController.Y)
				SetPressed( [ fController.A.Held, fController.B.Held, fController.X.Held, fController.Y.Held, fController.L1.Held, fController.R1.Held] );
				if(fStickLeft)
					fStickLeft. SetValue( fController.StickLeft.Held, fController.StickLeft.x, fController.StickLeft.y);
				if(fStickRight)
					fStickRight.SetValue( fController.StickRight.Held, fController.StickRight.x, fController.StickRight.y);
				fDPad.SetPressed( [fController.DirectionalPad.Left.Held, 
								   fController.DirectionalPad.Up.Held,
								   fController.DirectionalPad.Right.Held,
								   fController.DirectionalPad.Down.Held]);
				fLeftT.SetValue( fController.L2.NormalizedValue());
				fRightT.SetValue( fController.R2.NormalizedValue() );
			}		
		}
	}
}