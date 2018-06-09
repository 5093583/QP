package games.sparrow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.WORD;

	/**
	 * ...
	 * @author xf
	 * 用户托管
	 */
	public class CMD_S_Trustee 
	{
		public static const SIZE		:uint	 = 3;
		public var bTrustee				:uint;							//是否托管
		public var wChairID				:int;							//托管用户
		public function CMD_S_Trustee() 
		{
			
		}
		public static function _readBuffer(bytes : ByteArray) :CMD_S_Trustee
		{
			var result :CMD_S_Trustee = new CMD_S_Trustee();
			result.bTrustee = BYTE.read(bytes);
			result.wChairID = WORD.read(bytes);
			return result;
		}
	}
}