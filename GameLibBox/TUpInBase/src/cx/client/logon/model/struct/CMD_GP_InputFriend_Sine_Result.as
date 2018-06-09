package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.LONG;

	public class CMD_GP_InputFriend_Sine_Result
	{
		public function CMD_GP_InputFriend_Sine_Result()
		{
		}
		
		
		
		
		
		public var cbResult:int;			//-1拒绝，0接收添加成功，3用户不存在
		public var dwFriendID:int;
		
		
		public static function _readBuffer(bytes : ByteArray) : CMD_GP_InputFriend_Sine_Result
		{
			var result : CMD_GP_InputFriend_Sine_Result = new CMD_GP_InputFriend_Sine_Result();
			result.cbResult 	= LONG.read(bytes);
			result.dwFriendID	= DWORD.read(bytes);
			return result;
		}
		
		
	}
}