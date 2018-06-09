package games.sparrow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;

	public class CMD_S_Aide_Change
	{
		public var IsSuccess : Boolean;
		public var cbID : Array;
		public var cbCardData : Array;
		public var cbChangeSelf : uint;
		public var cbTaskNum : uint;
		public function CMD_S_Aide_Change()
		{
			cbID = Memory._newArrayAndSetValue(2,0);
			cbCardData = Memory._newArrayAndSetValue(2,0);
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_S_Aide_Change
		{
			bytes.position = 0;
			var result : CMD_S_Aide_Change = new CMD_S_Aide_Change();
			result.IsSuccess = BYTE.read(bytes)==1;
			var i : uint = 0;
			for(i = 0;i<2;i++) { result.cbID[i] = BYTE.read(bytes); }
			for(i = 0;i<2;i++) { result.cbCardData[i] = BYTE.read(bytes); }
			result.cbChangeSelf = BYTE.read(bytes);
			result.cbTaskNum = BYTE.read(bytes);
			return result;
		}
	}
}