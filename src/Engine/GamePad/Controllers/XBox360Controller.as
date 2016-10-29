package Engine.GamePad.Controllers {
	import Engine.GamePad.ConstGamePad;
	import Engine.GamePad.Controllers.XBoxController;

	public class XBox360Controller extends XBoxController 
	{
		public function XBox360Controller() 
		{
			super();
			fID = ConstGamePad.XBOX_360;
		}
	}
}