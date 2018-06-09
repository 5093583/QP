package games.sparrow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	/**
	 * @author xf
	 * 游戏状态
	 */
	public class CMD_S_StatusFree 
	{
		public static const SIZE			: uint	= 4;
		public var wBankerUser				: int;					//庄家用户
		public var bTrustee					: Array;				//是否托管
		public var bIsBaoPai				: uint;
		public var cbIsTryPlay:uint;
		public var lTryPlayScore:Number;	
		public function CMD_S_StatusFree() 
		{
			
		}
		public static function _readBuffer(bytes : ByteArray ): CMD_S_StatusFree
		{
			var result : CMD_S_StatusFree = new CMD_S_StatusFree();
			result.wBankerUser = WORD.read(bytes);
			result.bTrustee = Memory._newArrayAndSetValue(2, 0);
			var i : uint = 0;
			for (i = 0; i < 2; i++ )
			{
				result.bTrustee[i] = BYTE.read(bytes);
			}
			result.bIsBaoPai = BYTE.read(bytes);
			
			result.cbIsTryPlay = BYTE.read(bytes);
			result.lTryPlayScore = LONG.read(bytes);
			
			return result;
		}
	}
}