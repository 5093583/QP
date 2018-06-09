package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONG;

	public class CMD_GP_RecordSignIn_result
	{
		public function CMD_GP_RecordSignIn_result()
		{
		}
		
		public var bSignInresult:uint;		//100 成功101玩家今日已经签到102插入/更新记录表失败103更新玩家金币失败104插入金币记录失败105活动未开放
		public var lMoney:int;
		
		
		
		public static function _readBuffer(bytes : ByteArray) : CMD_GP_RecordSignIn_result
		{
			var result : CMD_GP_RecordSignIn_result = new CMD_GP_RecordSignIn_result();
			
			result.bSignInresult = BYTE.read(bytes);
			result.lMoney = LONG.read(bytes);
			
			return result;
		}
		
		
	}
}