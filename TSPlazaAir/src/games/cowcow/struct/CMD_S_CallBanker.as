package games.cowcow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.WORD;

	/**
	 * ...
	 * @author xf
	 * 用户叫庄
	 */
	public class CMD_S_CallBanker 
	{
		public static const SIZE	:uint = 3;
		public var bBanker		:uint;						//等于1叫庄 0 不叫
		public var wCallBanker		:int;						//叫庄用户椅子号
		public function CMD_S_CallBanker() 
		{
			
		}
		public static function _readBuffer(bytes :ByteArray) : CMD_S_CallBanker
		{
			var result :CMD_S_CallBanker = new CMD_S_CallBanker();
			result.bBanker = BYTE.read(bytes);
			result.wCallBanker = WORD.read(bytes);
			return result;
		}
		
	}

}