package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.LONG;

	public class CMD_GP_CreateCustomGameRoom_Result
	{
		public function CMD_GP_CreateCustomGameRoom_Result()
		{
		}
		
		/*
		 创建成功:返回当前房间唯一标识
		0  此玩家已经创建过房间 
		*/
		
		public var CreatResult:uint;
		
		public static function _readBuffer(bytes : ByteArray) : CMD_GP_CreateCustomGameRoom_Result
		{
			var result : CMD_GP_CreateCustomGameRoom_Result = new CMD_GP_CreateCustomGameRoom_Result();
			result.CreatResult 		= LONG.read(bytes);
			return result;
		}
		
		
		
	}
}