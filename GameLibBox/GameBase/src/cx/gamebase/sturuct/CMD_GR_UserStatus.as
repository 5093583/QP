package cx.gamebase.sturuct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.WORD;

	public class CMD_GR_UserStatus
	{
		public static const SIZE : uint = 9;
		public var dwUserID : Number;						//数据库 ID
		public var wTableID : int;							//桌子位置
		public var wChairID : int;							//椅子位置
		public var cbUserStatus : uint;					//用户状态
		
		public function CMD_GR_UserStatus()
		{
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_GR_UserStatus
		{
			var result : CMD_GR_UserStatus = new CMD_GR_UserStatus();
			
			result.dwUserID = DWORD.read(bytes);
			result.wTableID = WORD.read(bytes);
			result.wChairID = WORD.read(bytes);
			result.cbUserStatus = BYTE.read(bytes);
			
			return result;
		}
		
		public function Clone() : CMD_GR_UserStatus
		{
			var result : CMD_GR_UserStatus = new CMD_GR_UserStatus();
			
			result.dwUserID = this.dwUserID;
			result.wTableID = this.wTableID;
			result.wChairID = this.wChairID;
			result.cbUserStatus = this.cbUserStatus;
			return result;
		}
	}
}