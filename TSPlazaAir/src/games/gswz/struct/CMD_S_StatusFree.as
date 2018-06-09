package games.gswz.struct
{
	
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.Memory;

	/**
	 * ...
	 * @author xf
	 * 游戏状态
	 */
	public class CMD_S_StatusFree 
	{
		public var lCellScore : Number;						//基础赛币
		public var bShowHandNum : uint;						//第几张可以梭哈
//		public var bGameConfig : Array;
		
		
		public var cbIsTryPlay:uint;
		public var lTryPlayScore:Number;		
		
		public function CMD_S_StatusFree() 
		{
			
		}
		public static function _readBuffer(bytes : ByteArray): CMD_S_StatusFree
		{
			var result : CMD_S_StatusFree = new CMD_S_StatusFree
			result.lCellScore = LONG.read(bytes);
			result.bShowHandNum = BYTE.read(bytes);
			
//			result.bGameConfig = Memory._newArrayAndSetValue(5,0);
//			for(var i : uint = 0;i<5;i++)
//			{
//				result.bGameConfig[i] = BYTE.read(bytes);
//			}
			
			result.cbIsTryPlay = BYTE.read(bytes);
			result.lTryPlayScore = LONG.read(bytes);
			
			return result;
		}
		
	}

}