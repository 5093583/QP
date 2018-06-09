package games.sparrow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.WORD;

	/**
	 * ...
	 * @author xf
	 * 操作命令
	 */
	public class CMD_S_OperateResult 
	{
		public static const SIZE		: uint = 6;
		public var wOperateUser			: int;						//操作用户
		public var wProvideUser			: int;						//供应用户
		public var cbOperateCode		: uint;						//操作代码
		public var cbOperateCard		: uint;						//操作扑克
		public function CMD_S_OperateResult() 
		{
		}
		public static function _readBuffer(bytes : ByteArray ) : CMD_S_OperateResult
		{
			var result : CMD_S_OperateResult = new CMD_S_OperateResult();
			result.wOperateUser = WORD.read(bytes);
			result.wProvideUser = WORD.read(bytes);
			result.cbOperateCode = BYTE.read(bytes);
			result.cbOperateCard = BYTE.read(bytes);
			return result;
		}
	}
}