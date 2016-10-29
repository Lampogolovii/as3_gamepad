package GamePad.Objects {
	import flash.display.MovieClip;
	import Engine.Utils.CommonUtils;
	import flash.display.Sprite;

	/**
	 * @author tiMMy
	 */
	public class DirectionalPadVisual extends Sprite {
		protected var fBack: Sprite = null;
		protected var fButtons: Vector.<Sprite> = null;
		protected var fI: int = 0;		
		
		public function DirectionalPadVisual() 
		{
			Init();
		}
		
		protected function Init(): void
		{
			fBack = CommonUtils.CreateRasterizedSprite( new mcArrowsBack_1() );
			fButtons = new Vector.<Sprite>;
			var clip: MovieClip = new mcArrows_1();
			
			addChild( fBack );
			PushButton(clip, 1);
			PushButton(clip, 2);
			PushButton(clip, 3);
			PushButton(clip, 4);
		}
		
		protected function PushButton( aClip: MovieClip, aFrame: int ): void
		{
			aClip.gotoAndStop( aClip.totalFrames );
			aClip.gotoAndStop( aFrame );
			var button: Sprite = CommonUtils.CreateRasterizedSprite( aClip );
			button.visible = false;
			addChild( button );
			fButtons.push( button );
		}
		
		public function SetPressed( aArray: Array ): void
		{
			for(fI = 0; fI < aArray.length; fI++)
			{
				if(( fI < fButtons.length ) && (aArray[fI] is Boolean))
					fButtons[fI].visible = aArray[fI] as Boolean;
			}
		}	
	}
}