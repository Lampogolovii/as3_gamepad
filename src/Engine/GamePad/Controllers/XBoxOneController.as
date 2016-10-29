package Engine.GamePad.Controllers {
	import Engine.GamePad.ConstGamePad;
	import Engine.GamePad.Controllers.XBoxController;

	public class XBoxOneController extends XBoxController 
	{
		public function XBoxOneController() 
		{
			super();
			fID = ConstGamePad.XBOX_ONE;
		}
	}
}