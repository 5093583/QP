package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	public class CMD_GP_CreateCustomGameRoom
	{
		public function CMD_GP_CreateCustomGameRoom()
		{
		}
		
		public var	dwUserID:uint;							//玩家ID
		public var	wKindID:uint;							//名称号码
		public var	wServerID:uint;							//房间号码
		public var	wport:int;								//端口
		public var	cbPlayerCount:uint;						//游戏人数
		public var	lLessScore:uint;							//最低分数
		public var	szPassword:String;						//桌子密码		szPassword[33]
		public var 	szRoomName:String;							//房间名字	szRoomName[20]
		public var	STime:String;							//STime[25]
		public var	ETime:String;							//ETime[25]
		public var	cbIsOpen:uint;							//是否开启(默认开启)

		
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			
			DWORD.write(dwUserID,bytes);
			WORD.write(wKindID, bytes);
			WORD.write(wServerID, bytes);
			WORD.write(wport, bytes);
			BYTE.write(cbPlayerCount,bytes);
			LONG.write(lLessScore, bytes);
			TCHAR.write(szPassword, bytes, 33);
			TCHAR.write(szRoomName,bytes, 20);
			TCHAR.write(STime,bytes, 25);
			TCHAR.write(ETime, bytes, 25);
			BYTE.write(cbIsOpen, bytes);
			
			return bytes;
		}
		
		public function get size() : uint
		{
			return 4+2+2+2+1+4+33+20+25+25+1;
		}
		
		
		
	}
}