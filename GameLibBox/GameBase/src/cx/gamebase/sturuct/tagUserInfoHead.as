package cx.gamebase.sturuct
{
	import cx.net.NetConst;
	import cx.net.utils.NetWork;
	
	import flash.utils.ByteArray;
	
	import t.cx.air.TConst;
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.IDConvert;
	
	public class tagUserInfoHead
	{
		public var wFaceID : uint;								//头像索引
		public var dwUserID : Number;							//用户 I D
		public var dwUserRight : Number;						//用户等级
		public var dwMasterRight : Number;						//管理权限
		
		//用户属性
		public var cbGender : uint;								//用户性别	1男	2女	3机器人
		public var cbMemberOrder : uint;						//会员等级
		public var cbMasterOrder : uint;						//管理等级
		
		//用户状态
		public var wTableID : int;								//桌子号码
		public var wChairID : int;								//椅子位置
		public var cbUserStatus : uint;							//用户状态
		
		//ip
		public var dwIPInfo : int;								//ip地址
		//用户积分
		public var UserScoreInfo : tagUserScore;				//积分信息
		private var _ip : String;
		
		//视图显示
		public var dwViewID : int;
		public function get ip() : String
		{
			return _ip;
		}
		public function set AideIP(vIP : String) : void
		{
			_ip = vIP;
		}
		public function tagUserInfoHead()
		{ 
		}
		public static function _readBuffer(bytes : ByteArray) : tagUserInfoHead
		{
			var result : tagUserInfoHead = new tagUserInfoHead();
			
			result.wFaceID 		= WORD.read(bytes);
			result.dwUserID 	= DWORD.read(bytes);
			result.dwUserRight 	= DWORD.read(bytes);
			result.dwMasterRight= DWORD.read(bytes);
			result.cbGender 	= BYTE.read(bytes);
			result.cbMemberOrder= BYTE.read(bytes);
			result.cbMasterOrder= BYTE.read(bytes);
			result.wTableID 	= WORD.read(bytes);
			result.wChairID 	= WORD.read(bytes);
			result.cbUserStatus = BYTE.read(bytes);
			result.dwIPInfo = DWORD.read(bytes);//NetWork._inetNtoa(uIp);
			result._ip = NetWork._inetNtoa(result.dwIPInfo);
			if(NetConst.pCxWin != null)
			{
				result._ip = NetConst.pCxWin.CxGetIpInfo( result._ip );
			}
			
			result.UserScoreInfo= tagUserScore._readBuffer(bytes);
			result.dwViewID = result.dwUserID;
			
			return result;
		}
		
		public function clone() : tagUserInfoHead
		{
			var result : tagUserInfoHead = new tagUserInfoHead();
			result.wFaceID 		= this.wFaceID;
			result.dwUserID 	= this.dwUserID;
			result.dwUserRight 	= this.dwUserRight;
			result.dwMasterRight= this.dwMasterRight;
			
			result.cbGender 	= this.cbGender;
			result.cbMemberOrder= this.cbMemberOrder;
			result.cbMasterOrder= this.cbMasterOrder;
			
			
			result.wTableID 	= this.wTableID;
			result.wChairID 	= this.wChairID;
			result.cbUserStatus = this.cbUserStatus;
			result.UserScoreInfo= this.UserScoreInfo.clone();
			result._ip = this._ip;
			
			result.dwViewID = this.dwViewID;
			return result;
		}
		public function Destroy() : void
		{
			_ip = null;
			UserScoreInfo = null;
		}
	}
}