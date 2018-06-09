package cx.gamebase.sturuct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;
	
	public class CMD_GR_UserSitReq
	{
		public var wTableID : int;							//桌子位置
		public var wChairID : int;							//椅子位置
		public var cbPassLen : uint;						//密码长度
		public var szTablePass : String;					//桌子密码
		public function CMD_GR_UserSitReq()
		{
			cbPassLen = 33;
			szTablePass = '';
		}
		
		public function Write() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			WORD.write(wTableID,bytes);
			WORD.write(wChairID,bytes);
			BYTE.write(cbPassLen,bytes);
			TCHAR.write(szTablePass,bytes,cbPassLen);
			return bytes;
		}
		public function size() : uint
		{
			return 5 + cbPassLen;
		}
	}
}