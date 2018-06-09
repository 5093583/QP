package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.Memory;

	public class CMD_GP_BookFriend
	{
		public function CMD_GP_BookFriend()
		{
		}
		
		
		
		public var dwUserID:uint;
		public var dwFriendID:uint;
		
		public var szname:String;						//szname[50];
		public var szBook:String;						//szBook[100];

		
		
		
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			
			DWORD.write(dwUserID,bytes);
			DWORD.write(dwFriendID,bytes);
			
			TCHAR.write(szname, bytes, 50);
			TCHAR.write(szBook, bytes, 100);
			
			return bytes;
		}
		
		public function get size() : uint
		{
			return 4+4+50+100;
		}
		
		
	}
}