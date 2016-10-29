package Engine.GamePad.Controllers {
	import Engine.GamePad.Controls.GamePadDirectionalPad;
	import Engine.GamePad.Controls.GamePadStick;
	import Engine.GamePad.Controls.GamePadButton;
	import flash.ui.GameInputControl;
	import flash.ui.GameInputDevice;
	import Engine.GamePad.ConstGamePad;
	public class BaseGameController 
	{
		protected var fID: int = ConstGamePad.NONE;
		protected var fDevice: GameInputDevice = null;
		protected var fEnabled: Boolean = true;
		protected var fAttached: Boolean = false;
		protected var fControlMap: Vector.< GameInputControl > = null;
		protected var fTempInt: int = 0;
		
		public function BaseGameController(): void
		{
		}
		
		public function SetInputDevice( aDevice: GameInputDevice ): void
		{
			fDevice = aDevice;
			MapControls();
		}
		
		protected function CreateControlMap(): Vector.< GameInputControl >
		{
			var controlMap: Vector.< GameInputControl > = null;
			if(fDevice && (fDevice.numControls > 0) && (fDevice.getControlAt(0) is GameInputControl))
			{
				controlMap = new Vector.< GameInputControl >;
				for(var i: int = 0; i < fDevice.numControls; i++)
					controlMap.push(fDevice.getControlAt(i) as GameInputControl);
			}
			return controlMap;
		}		
		
		protected function MapControls(): void
		{
			if(fDevice)
				fControlMap = CreateControlMap();
		}
		
		public function get ID(): int
		{
			return fID;
		}
		
		public function get Device(): GameInputDevice
		{
			return fDevice;
		}
		
		public function get DeviceName(): String
		{
			if(fDevice)
				return fDevice.name;
			else
				return '';
		}
		
		public function IsAttached(): Boolean
		{
			return fAttached;
		}
		
		public function IsEnabled(): Boolean
		{
			return fEnabled;
		}
		
		public function SetEnable( aEnable: Boolean): void
		{
			fEnabled = true;
			fDevice.enabled = true;
		}
		
		protected function IsButtonByID( aID: String ): Boolean
		{
			return aID.indexOf( ConstGamePad.CONTROL_BUTTON_PREFIX ) > -1;
		}
		
		protected function IsAxisByID( aID: String ): Boolean
		{
			return aID.indexOf( ConstGamePad.CONTROL_AXIS_PREFIX ) > -1;
		}		
		
		protected function GetControlNumberBy( aID: String ): int
		{
			fTempInt = aID.indexOf('_');
			if(fTempInt > -1)
				return int(aID.substr( fTempInt + 1, aID.length - fTempInt));
			else
				return 0;
		}	
		
		protected function GetControlByID( aID: String ): GameInputControl
		{
			for( fTempInt = 0; fTempInt < fControlMap.length; fTempInt++)
			{
				if( fControlMap[fTempInt] && ( aID == fControlMap[fTempInt].id))
					return fControlMap[fTempInt];
			}
			return null;
		}
		
		protected function CreateButtonByInputControl( aInputControl: GameInputControl ): GamePadButton
		{
			if( aInputControl )
			{
				var button: GamePadButton = new GamePadButton();
				button.SetInputs( [ aInputControl ] );
				button.SetID( GetControlNumberBy( aInputControl.id) );
				return button;
			}
			else
				return null;
		}
		
		protected function CreateStickByInputControls( aX: GameInputControl, aY: GameInputControl, aButton: GameInputControl, aReversedY: Boolean ): GamePadStick
		{
			if( aX && aY && aButton )
			{
				var stick: GamePadStick = new GamePadStick();
				stick.SetInputs( [ aX, aY, aButton ] );
				stick.SetReversed( aReversedY );
				return stick;
			}
			else
				return null;
		}
		
		protected function CreateDirectionalPadByInputControls( aUp: GameInputControl, aDown: GameInputControl, aLeft: GameInputControl, aRight: GameInputControl ): GamePadDirectionalPad
		{
			if( aUp && aDown && aLeft && aRight )
			{
				var pad: GamePadDirectionalPad = new GamePadDirectionalPad();
				pad.SetInputs( [ aUp, aDown, aLeft, aRight ] );
				return pad;
			}
			else
				return null;
		}
	}
}