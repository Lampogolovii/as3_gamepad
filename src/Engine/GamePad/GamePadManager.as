package Engine.GamePad {
	import Engine.GamePad.Controllers.BaseGameController;
	import flash.ui.GameInputDevice;
	import flash.events.GameInputEvent;
	import flash.ui.GameInput;
	public class GamePadManager 
	{
		protected var fGameInput: GameInput = null; 
		protected var fControllers: Vector.< BaseGameController > = null; 
		protected var fI: int = 0;
		
		// Events 
		protected var fOnAttachedEvent: Function = null; 
		protected var fOnDetachedEvent: Function = null; 
		
		public function GamePadManager(): void
		{
			Init();
		}
		
		protected function GetEventFunc( aEvents: Object, aEventName: String ): Function
		{
			if(aEvents.hasOwnProperty( aEventName ))
				return aEvents[aEventName] as Function;
			return null;
		}
		
		public function SetEvents( aEvents: Object ): void
		{
			fOnAttachedEvent = GetEventFunc(aEvents, ConstGamePad.ONATTACH );
			fOnDetachedEvent = GetEventFunc(aEvents, ConstGamePad.ONDETACH );
		}
		
		protected function Init(): void
		{
			fControllers = new Vector.< BaseGameController >;
			fGameInput = new GameInput();
			AttachDevices();
			if(fGameInput)
			{
				fGameInput.addEventListener( GameInputEvent.DEVICE_ADDED, onDeviceAttached);
				fGameInput.addEventListener( GameInputEvent.DEVICE_REMOVED, onDeviceDetached );
			}
		}
		
		protected function AttachDevices(): void
		{
			for (var i:uint = 0; i < GameInput.numDevices; i++)
				Attach( GameInput.getDeviceAt(i) );
		}
		
		protected function onDeviceAttached( event:GameInputEvent ):void 
		{
			Attach( event.device );
		}		
		
		protected function onDeviceDetached( event:GameInputEvent ):void 
		{
			Detach( event.device );
		}	
		
		protected function Attach( aDevice: GameInputDevice): void
		{
			if (aDevice)
			{
				var id: int = ConstGamePad.GetIDByDeviceName( aDevice.name );
				if(id > ConstGamePad.NONE )
				{
					var controllerClass:Class = ConstGamePad.GetClassByID( id );
					if(controllerClass != null)
					{
						var controller: BaseGameController = new controllerClass(); 
						if(controller)
						{
							controller.SetInputDevice( aDevice );
							if (fControllers) 
								fControllers.push( controller );
							
							if(fOnAttachedEvent != null)
								fOnAttachedEvent( controller );
						}
					}
				}
			}			
		}
		
		protected function Detach( aDevice: GameInputDevice): void
		{
			var controller: BaseGameController = GetControllerByDevice( aDevice );
			if(controller && (fOnDetachedEvent != null))
				fOnDetachedEvent( controller );
		}
		
		protected function GetControllerByDevice( aDevice: GameInputDevice): BaseGameController
		{
			if( fControllers && aDevice )
			{
				for(fI = 0; fI < fControllers.length; fI++)
				{
					if( fControllers[fI] && fControllers[fI].Device && (fControllers[fI].Device == aDevice))
						return fControllers[fI];
				}
			}
			return null;
		}
	}
}