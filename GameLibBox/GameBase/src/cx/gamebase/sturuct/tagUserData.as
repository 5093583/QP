package cx.gamebase.sturuct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.CType.WORD;
	
	public class tagUserData
	{
		//用户属性
		public var wFaceID : int;								//头像索引
		public var dwUserID : Number;							//用户 I D
		public var dwUserRight : Number;						//用户等级
		public var dwMasterRight : Number;						//管理权限
		public var szName : String;								//用户名字
		
		//用户属性
		public var cbGender : uint;								//用户性别
		public var cbMemberOrder : uint;						//会员等级
		public var cbMasterOrder : uint;						//管理等级
		
		//用户积分
		public var lInsureScore : int;							//消费金币
		public var lGameGold : int;								//游戏金币
		public var lScore : int;								//用户分数
		public var lWinCount : int;								//胜利盘数
		public var lLostCount : int;							//失败盘数
		public var lDrawCount : int;							//和局盘数
		public var lFleeCount : int;							//断线数目
		public var lExperience : int;							//用户经验
		
		//用户状态
		public var wTableID : int;								//桌子号码
		public var wChairID : int;								//椅子位置
		public var cbUserStatus : int;							//用户状态
		public function tagUserData()
		{
		}
		
		public static function _readBuffer(bytes : ByteArray) : tagUserData
		{
			var result : tagUserData = new tagUserData();
			
			result.wFaceID 			= WORD.read(bytes);
			result.dwUserID 		= DWORD.read(bytes);
			result.dwUserRight 		= DWORD.read(bytes);
			result.dwMasterRight 	= DWORD.read(bytes);
			result.szName 			= TCHAR.read(bytes,32);;
			
			result.cbGender 		= BYTE.read(bytes);
			result.cbMemberOrder 	= BYTE.read(bytes);
			result.cbMasterOrder 	= BYTE.read(bytes);
			
			result.lInsureScore 	= LONG.read(bytes);
			result.lGameGold 		= LONG.read(bytes);
			result.lScore 			= LONG.read(bytes);
			result.lWinCount 		= LONG.read(bytes);
			result.lLostCount 		= LONG.read(bytes);
			result.lDrawCount 		= LONG.read(bytes);
			result.lFleeCount 		= LONG.read(bytes);
			result.lExperience 		= LONG.read(bytes);
			
			result.wTableID 		= WORD.read(bytes);
			result.wChairID 		= WORD.read(bytes);
			
			result.cbUserStatus 	= BYTE.read(bytes);
			return  result;
		}
	}
}