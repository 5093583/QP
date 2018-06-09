package games.baccarat.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.LONGLONG;
	import t.cx.air.utils.CType.WORD;

	//用户金币
	public class CMD_S_UserScore
	{
		public static const SIZE :uint	= 20;
		public var UserScore : Number;				    //玩家金币
	  	public var GameUserID : int;						//玩家ID
		public var UserIP : Number;                    //玩家IP   
		public function CMD_S_UserScore
		{
		}
		public static function _readBuffer(bytes : ByteArray) :CMD_S_UserScore
		{
			var  result : CMD_S_UserScore = new CMD_S_UserScore();
			result.UserScore	= LONGLONG.read(bytes);
			result.GameUserID 	= WORD.read(bytes);
			result.UserIP    	= LONGLONG.read(bytes);
			return result;
		}
		
	}
}