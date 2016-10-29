package GamePad.Objects {
	import Engine.Utils.CommonUtils;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import GamePad.Objects.CircleButton;

	public class IconCircleButton extends CircleButton 
	{
		protected var fIcon: Sprite = null;
		
		public function IconCircleButton() 
		{
			super();
		}
		
		public function SetIcon( aMovieClip: MovieClip, aFrame: int ): void
		{
			aMovieClip.gotoAndStop( aMovieClip.totalFrames );
			aMovieClip.gotoAndStop( aFrame );
			fIcon = CommonUtils.CreateRasterizedSprite( aMovieClip );
			addChild( fIcon );
		}		
	}
}