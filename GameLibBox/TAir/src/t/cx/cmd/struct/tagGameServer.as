package t.cx.cmd.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.CType.WORD;

	[Bindable]
	public class tagGameServer
	{
		public static const SIZE : int =577;// 65;//121;//65;
		public var wSortID 			: int;						//排序号码
		public var wKindID 			: int;						//名称号码
		public var wServerID 		: int;						//房间号码
		public var wStationID 		: int;						//站点号码
		public var wServerPort 		: int;						//房间端口
		public var dwOnLineCount	: Number;					//在线人数
		//新增数据信息
		public var lRoomLessScore	: Number;					//入场金币（最低分)
		public var lCellScore		: Number;					//房间底
		public var iRevenuel		: int;						//房间税收
		public var RoomType			: uint;						//房间类型
		
		/*
		 * //游戏类型
		#define GAME_GENRE_SCORE				0x0001								//点值类型
		#define GAME_GENRE_GOLD					0x0002								//金币类型
		#define GAME_GENRE_MATCH				0x0004								//比赛类型
		#define GAME_GENRE_EDUCATE				0x0008								//训练类型
		*/
		
		//public var szServerAddr		: String;
		public var dwServerAddr		: Array;					//房间地址
		public var szServerName 	: String;					//房间名称
		
		
		public var szAreaString		: Array;					//房间地址
		
		public function tagGameServer()
		{
		}
		public static function _readByteArray(bytes : ByteArray) : tagGameServer
		{
			var result : tagGameServer = new tagGameServer();
			result.wSortID 			= WORD.read(bytes);
			result.wKindID 			= WORD.read(bytes);
			result.wServerID 		= WORD.read(bytes);
			result.wStationID		= WORD.read(bytes);
			result.wServerPort 		= WORD.read(bytes);
			result.dwOnLineCount	= DWORD.read(bytes);
			result.lRoomLessScore 	= LONG.read(bytes);
			result.lCellScore 		= LONG.read(bytes);
			result.iRevenuel 		= WORD.read(bytes);
			result.RoomType 		= BYTE.read(bytes);
			result.dwServerAddr 	= new Array(2);
			//result.szServerAddr		= TCHAR.read(bytes,64);
			for(var i : uint = 0;i<2;i++)
			{
				result.dwServerAddr[i] = DWORD.read(bytes);
			}
			result.szServerName 	= TCHAR.read(bytes,32);
			
			
			result.szAreaString 	= new Array(2);
			for(var j : uint = 0;j<2;j++)
			{
				result.szAreaString[j] = TCHAR.read(bytes,256);
			}
			return result;
		}
	}
}