package Engine.GamePad.Controllers {
	import Engine.GamePad.ConstGamePad;
	import Engine.GamePad.Controllers.CommonController;

	public class PS3Controller extends CommonController 
	{
		public function PS3Controller() 
		{
			super();
			fID = ConstGamePad.PS_3;
		}
	}
}