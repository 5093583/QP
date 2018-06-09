package games.sparrow.struct
{
	
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.WORD;

	/**
	 * ...
	 * @author xf
	 * 操作提示
	 */
	public class CMD_S_OperateNotify 
	{
		public static const SIZE 		:uint	= 4;
		public var wResumeUser			:int;						//当前操作用户
		public var cbActionMask			:uint;						//动作掩码
		public var cbActionCard			:uint;						//动作扑克
		public function CMD_S_OperateNotify() 
		{
			
		}
		public static function _readBuffer(bytes : ByteArray): CMD_S_OperateNotify
		{
			var result : CMD_S_OperateNotify = new CMD_S_OperateNotify();
			result.wResumeUser = WORD.read(bytes);
			result.cbActionMask = BYTE.read(bytes);
			result.cbActionCard = BYTE.read(bytes);
			return result;
		}
	}
}