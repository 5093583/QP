package cx.gamebase.sturuct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.WORD;

	public class CMD_GR_ServerInfo
	{
		//房间属性
		public var wKindID : int;								//类型 I D
		public var wTableCount : int;							//桌子数目
		public var wChairCount : int;							//椅子数目
		//扩展配置
		public var wGameGenre : int;							//游戏类型
		public var cbHideUserInfo : uint;						//隐藏信息
		
		public var cbTryPlay:uint;								//是否为试玩房间
		
		public function CMD_GR_ServerInfo()
		{
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_GR_ServerInfo
		{
			var result : CMD_GR_ServerInfo = new CMD_GR_ServerInfo();
			result.wKindID = WORD.read(bytes);
			result.wTableCount = WORD.read(bytes);
			result.wChairCount = WORD.read(bytes);
			result.wGameGenre = WORD.read(bytes);
			result.cbHideUserInfo = BYTE.read(bytes);
			
//			result.cbTryPlay = BYTE.read(bytes);
			
			return result;
		}
	}
}