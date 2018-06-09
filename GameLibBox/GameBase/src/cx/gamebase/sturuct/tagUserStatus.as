package cx.gamebase.sturuct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.WORD;
	
	public class tagUserStatus
	{
		public var wTableID : int;							//桌子号码
		public var wChairID : int;							//椅子位置
		public var cbUserStatus : uint;						//用户状态
		public function tagUserStatus()
		{
		}
		
		public static function _readBuffer(bytes : ByteArray) : tagUserStatus
		{
			var result : tagUserStatus = new tagUserStatus();
			result.wTableID 	= WORD.read(bytes);
			result.wChairID 	= WORD.read(bytes);
			result.cbUserStatus = BYTE.read(bytes);
			
			return result;
		}
		public function Colne() : tagUserStatus
		{
			var result : tagUserStatus = new tagUserStatus();
			
			result.wTableID = this.wTableID;
			result.wChairID = this.wChairID;
			result.cbUserStatus = this.cbUserStatus;
			
			return result;
		}
	}
}