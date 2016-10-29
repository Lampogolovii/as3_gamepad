package Engine.GamePad.Controllers {
	import Engine.GamePad.ConstGamePad;
	import Engine.GamePad.Controllers.CommonController;

	public class PS4Controller extends CommonController 
	{
		public function PS4Controller() 
		{
			super();
			fID = ConstGamePad.PS_4;			
		}
	}
}