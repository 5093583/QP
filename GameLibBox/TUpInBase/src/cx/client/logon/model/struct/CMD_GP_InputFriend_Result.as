package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.LONG;

	public class CMD_GP_InputFriend_Result
	{
		public function CMD_GP_InputFriend_Result()
		{
		}
		
		//0失败		1添加成功	2已是好友	3用户不存在
		
		public var cbResult:int;

		
		public static function _readBuffer(bytes : ByteArray) : CMD_GP_InputFriend_Result
		{
			var result : CMD_GP_InputFriend_Result = new CMD_GP_InputFriend_Result();
			result.cbResult 	= LONG.read(bytes);
			return result;
		}
		
		
	}
}