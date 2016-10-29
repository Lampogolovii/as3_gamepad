package Engine.GamePad.Controllers {
	import flash.ui.GameInputControl;
	import Engine.GamePad.ConstGamePad;
	import Engine.GamePad.Controls.*;

	public class CommonController extends BaseGameController
	{
		protected var fA: GamePadButton = null;
		protected var fB: GamePadButton = null;
		protected var fX: GamePadButton = null;
		protected var fY: GamePadButton = null;
		protected var fStickLeft: GamePadStick = null;
		protected var fStickRight: GamePadStick = null;
		protected var fDirectionalPad: GamePadDirectionalPad = null;
		protected var fL1: GamePadButton = null;
		protected var fR1: GamePadButton = null;
		protected var fL2: GamePadButton = null;
		protected var fR2: GamePadButton = null;
		
		override protected function MapControls(): void
		{
			super.MapControls();
			InitCommonControls();
		}	
		
		protected function InitCommonControls(): void
		{
			if( fDevice )
			{
				var buttons: Vector.<int> = ConstGamePad.CreateCommonVectorByID( ConstGamePad.GetIDByDeviceName( fDevice.name ) );
				fA = CreateCommonButton( 0 );
				fB = CreateCommonButton( 1 );
				fX = CreateCommonButton( 2 );
				fY = CreateCommonButton( 3 );
				fDirectionalPad = CreateCommonDirectionalPad( 4, 5, 6, 7 );
				fStickLeft = CreateCommonStick( 8, 9, 10 ); 
				fStickRight = CreateCommonStick( 11, 12, 13 ); 
				fL1 = CreateCommonButton( 14 );
				fR1 = CreateCommonButton( 15 );
				fL2 = CreateCommonButtonOrAxis( 16 );
				fR2 = CreateCommonButtonOrAxis( 17 );
			}
				
			function CreateCommonButton( aIndex: int ): GamePadButton
			{
				return CreateButtonByInputControl( GetInputControlByIntID( buttons[aIndex], ConstGamePad.CONTROL_BUTTON ) );
			}
				
			function CreateCommonButtonOrAxis( aIndex: int ): GamePadButton
			{
				var gameInput: GameInputControl = GetInputControlByIntID( buttons[aIndex], ConstGamePad.CONTROL_BUTTON );
				if(!gameInput)
					gameInput = GetInputControlByIntID( buttons[aIndex], ConstGamePad.CONTROL_AXIS );
					
				if( gameInput )
				{
					var button: GamePadButton = CreateButtonByInputControl( gameInput );
					if(button)
						button.SetMinMaxValues( gameInput.minValue, gameInput.maxValue ); 
					return button;
				}
				else
					return null;
			}
				
			function CreateCommonStick( aIndexX: int, aIndexY: int, aIndexButton: int ): GamePadStick
			{
				return CreateStickByInputControls( GetInputControlByIntID( buttons[aIndexX], ConstGamePad.CONTROL_AXIS ),
												   GetInputControlByIntID( buttons[aIndexY], ConstGamePad.CONTROL_AXIS ),
												   GetInputControlByIntID( buttons[aIndexButton], ConstGamePad.CONTROL_BUTTON),
												   buttons[aIndexY] < 0 );
			}
				
			function CreateCommonDirectionalPad( aUp: int, aDown: int, aLeft: int, aRight: int ): GamePadDirectionalPad
			{
				return CreateDirectionalPadByInputControls( GetInputControlByIntID( buttons[aUp], ConstGamePad.CONTROL_BUTTON ),
															GetInputControlByIntID( buttons[aDown], ConstGamePad.CONTROL_BUTTON),
															GetInputControlByIntID( buttons[aLeft], ConstGamePad.CONTROL_BUTTON),
															GetInputControlByIntID( buttons[aRight], ConstGamePad.CONTROL_BUTTON));
			}
			
			function GetInputControlByIntID( aID: int, aType: int ): GameInputControl
			{
				return GetControlByID( ConstGamePad.GetPrefixByType(aType) + Math.abs(aID).toString() );
			}
		}
		
		public function get A(): GamePadButton
		{
			return fA; 
		}
		
		public function get B(): GamePadButton
		{
			return fB; 
		}
		
		public function get X(): GamePadButton
		{
			return fX; 
		}
		
		public function get Y(): GamePadButton
		{
			return fY; 
		}
		
		public function get L1(): GamePadButton
		{
			return fL1; 
		}
		
		public function get R1(): GamePadButton
		{
			return fR1; 
		}
		
		public function get L2(): GamePadButton
		{
			return fL2; 
		}
		
		public function get R2(): GamePadButton
		{
			return fR2; 
		}
		
		public function get StickLeft(): GamePadStick
		{
			return fStickLeft; 
		}
		
		public function get StickRight(): GamePadStick
		{
			return fStickRight; 
		}
		
		public function get DirectionalPad(): GamePadDirectionalPad
		{
			return fDirectionalPad; 
		}
	}
}