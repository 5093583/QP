package cx.gamebase.sturuct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;

	public class CMD_GR_UserScore
	{
		public var dwUserID : Number;							//用户 I D
		public var UserScore : tagUserScore;							//积分信息
		public function CMD_GR_UserScore()
		{
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_GR_UserScore
		{
			var result : CMD_GR_UserScore = new CMD_GR_UserScore();
			result.dwUserID = DWORD.read(bytes);
			result.UserScore = tagUserScore._readBuffer(bytes);
			return result;
		}
	}
}