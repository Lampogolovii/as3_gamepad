package Engine.GamePad 
{
	import Engine.GamePad.Controllers.*;
	
	public class ConstGamePad 
	{
		static public const NONE: int = -1;
		static public const UNKNOWN: int = 0;
		static public const XBOX_ONE: int = 1;
		static public const XBOX_360: int = 2;
		static public const PS_3: int = 3;
		static public const PS_4: int = 4;
		static public const OUYA: int = 5;
		
		static public const ONATTACH: String = 'ONATTACH';
		static public const ONDETACH: String = 'ONDETACH';
		
		static public const CONTROL_NONE: int = 0;
		static public const CONTROL_BUTTON: int = 1;
		static public const CONTROL_AXIS: int = 2;
		static public const CONTROL_BUTTON_PREFIX: String = 'BUTTON_';
		static public const CONTROL_AXIS_PREFIX: String = 'AXIS_';
		
		static public function GetClassByID( aID: int ): Class
		{
			 switch( aID )
			 {
				case NONE:
					return null;
				case UNKNOWN:
					return UnknownController;
				case XBOX_ONE:
					return XBoxOneController;
				case XBOX_360:
					return XBox360Controller;
				case PS_3:
					return PS3Controller;
				case PS_4:
					return PS4Controller;
			 }
			 return null;
		}
		
		static protected function HasSubString( aName: String, aSubStrings: Array): Boolean
		{
			for(var i: int = 0; i < aSubStrings.length; i++)
				if(aSubStrings[i] && (aSubStrings[i] is String) && (aName.toLowerCase().indexOf( aSubStrings[i]) > -1))
					return true;
			return false;
		}
		
		static public function GetIDByDeviceName( aName: String ): int
		{
			if (HasSubString(aName, ["xbox one"]))
				return XBOX_ONE;
			else if (HasSubString(aName, ["xbox 360"]))
				return XBOX_360;
			else if (HasSubString(aName, ["playstation(r)3"]))
				return PS_3;
			else if (HasSubString(aName, ["playstation(r)4", "Product: 05c4", "54c-5c4"]))
				return PS_4;
			else
				return UNKNOWN;
		}
		
		static public function GetPrefixByType( aType: int ): String
		{
			switch( aType )
			{
				case CONTROL_BUTTON:
					return CONTROL_BUTTON_PREFIX;
				case CONTROL_AXIS:
					return CONTROL_AXIS_PREFIX;
			}
			return '';
		}
		 
		static public function CreateCommonVectorByID( aID: int ): Vector.<int>
		{
			// a b x y up down left right ls-X ls-Y ls-B rs-X rs-Y rs-B lb rb lt rt 
			var result: Vector.<int> = null;
			
			if(GetClassByID( aID ) != null)
			{
				result = new Vector.<int>();
				switch( aID )
				{
					case XBOX_ONE:
						result.push(17, 18, 19, 20,  6,  7,  8,  9,  0, -1, 12,  3, -4, 13, 14, 15,  2,  5 );
					break;
					case XBOX_360:
						result.push( 4,  5,  6,  7, 16, 17, 18, 19,  0,  1, 14,  2,  3, 15,  8,  9, 10, 11 );
					break;
					case PS_3:
						result.push(18, 17, 19, 16,  8, 10, 11,  9,  0, -1,  5,  2, -3,  6, 14, 15, 12, 13);
					break;
					case PS_4:
						result.push(11, 12, 10, 13,  6,  7,  8,  9,  0,  1, 20,  2,  5, 21, 14, 15,  3,  4);
					break;
				}
			} 
				
			return result;
		}
		
	}
}