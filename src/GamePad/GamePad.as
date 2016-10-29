package GamePad {
	import Engine.GamePad.ConstGamePad;
	import Engine.GamePad.Controllers.BaseGameController;
	import Engine.Utils.CommonUtils;
	import flash.events.Event;
	import Engine.GamePad.GamePadManager;
	import flash.display.Sprite;

	public class GamePad extends Sprite 
	{
		protected var fGamePadManager: GamePadManager = null;
		
		// visual
		protected var fBack: Sprite = null;
		protected var fTitle: GamePadTitleVisual = null;
		
		protected var fUnknownVisual: UnknownGamePadVisual = null;
		protected var fXBoxGamePad: CommonGamePadVisual = null;
		protected var fPSGamePad: CommonGamePadVisual = null;
		protected var fCurrentController: BaseGameController = null;
		
		public function GamePad() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		protected function onAddedToStage( e: Event ): void
		{
			stage.frameRate = 60;
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.ENTER_FRAME, onUpdate );
			Init();
		}
		
		protected function Init(): void
		{
			fGamePadManager = new GamePadManager;
			fGamePadManager.SetEvents( {ONATTACH: onAttachController, ONDETACH: onDetachController });
			
			fBack = CommonUtils.CreateRasterizedSprite( new mcBack_1 );
			fTitle = new GamePadTitleVisual();
			fTitle.x = 15;
			fTitle.y = 20;
			
			fUnknownVisual = new UnknownGamePadVisual();
			fXBoxGamePad = new XBoxGamePadVisual();
			fPSGamePad = new PlayStationGamePadVisual();
			
			fPSGamePad.x = fXBoxGamePad.x = fUnknownVisual.x = 70;
			fPSGamePad.y = fXBoxGamePad.y = fUnknownVisual.y = 120;
						
			addChild( fBack );
			addChild( fTitle );
			addChild( fUnknownVisual );
			addChild( fXBoxGamePad );
			addChild( fPSGamePad );
			
			UpdateCurrentController();
		}
		
		protected function IsXBox( aID: int ): Boolean
		{
			return (aID == ConstGamePad.XBOX_ONE) || (aID == ConstGamePad.XBOX_360);
		}
		
		protected function IsPS( aID: int ): Boolean
		{
			return (aID == ConstGamePad.PS_3) || (aID == ConstGamePad.PS_4);
		}
		
		protected function onAttachController( aController: BaseGameController ): void
		{
			fCurrentController = aController;
			fTitle.SetConnectedController( aController );
			aController.SetEnable( true );
			
			if( !SetController( aController.ID, aController ) )
				aController.SetEnable( false );
				
			UpdateCurrentController();
		}
		
		protected function onDetachController( aController: BaseGameController ): void
		{
			if(aController == fCurrentController)
			{
				fCurrentController = null;
				fTitle.SetConnectedController( null );
				
				SetController( aController.ID, null );			
			}
			UpdateCurrentController();
		}
		
		protected function SetController( aID: int, aController: BaseGameController ): Boolean
		{
			var result: Boolean = true;
			
			if( aID == ConstGamePad.UNKNOWN)
				fUnknownVisual.SetController( aController );
			else if( IsXBox( aID ))
				fXBoxGamePad.SetController( aController );
			else if( IsPS( aID ))
				fPSGamePad.SetController( aController );
			else
				return result = false;
				
			return result;
		}
		
		protected function UpdateCurrentController(): void
		{
			fUnknownVisual.visible = (fCurrentController != null) && (fCurrentController.ID == ConstGamePad.UNKNOWN);
			fXBoxGamePad.visible = (fCurrentController != null) && IsXBox(fCurrentController.ID);
			fPSGamePad.visible = (fCurrentController != null) && IsPS(fCurrentController.ID);
		}
		
		protected function onUpdate( e: Event ): void
		{
			fUnknownVisual.Update();
			fXBoxGamePad.Update();
			fPSGamePad.Update();
		}
	}
}