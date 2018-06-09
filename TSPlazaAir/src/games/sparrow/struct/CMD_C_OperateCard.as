package games.sparrow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;

	/**
	 * @author xf
	 * 操作命令
	 */
	public class CMD_C_OperateCard 
	{
		public var cbOperateCode : uint;			//操作代码
		public var cbOperateCard : uint;			//操作扑克
		public function CMD_C_OperateCard() 
		{
			
		}
		public function toByteArray() : ByteArray
		{
			var bytes :ByteArray = Memory._newLiEndianBytes();
			
			BYTE.write(cbOperateCode, bytes);
			BYTE.write(cbOperateCard, bytes);
			
			return bytes;
		}
		public function get size() :uint
		{
			return 2;
		}
	}
}
