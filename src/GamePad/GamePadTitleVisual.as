package GamePad {
	import Engine.GamePad.Controllers.BaseGameController;
	import flashx.textLayout.formats.TextAlign;
	import Engine.Utils.TextUtils;
	import Engine.Utils.CommonUtils;
	import flash.text.TextField;
	import flash.display.Sprite;

	public class GamePadTitleVisual extends Sprite 
	{
		protected var fBack: Sprite = null;
		protected var fTitle: TextField = null;
		
		public function GamePadTitleVisual() 
		{
			Init();
		}
		
		protected function Init(): void
		{
			fBack = CommonUtils.CreateRasterizedSprite( new mcConnectedBack_1() );
			fTitle = TextUtils.CreateCustomTextField(20, 0x000000, TextAlign.LEFT, 0);
			fTitle.alpha = 0.3;
			fTitle.width = 530;
			fTitle.x = 30;
			fTitle.y = 7;
			fTitle.selectable = true;
			fTitle.mouseEnabled = true;
			
			addChild( fBack );
			addChild( fTitle );
			SetConnectedController( null );
		}
		
		public function SetConnectedController( aController: BaseGameController ): void
		{
			if(aController)
				fTitle.text = 'Connected: ' + aController.DeviceName;
			else
				fTitle.text = 'No connected device...';
		}
	}
}