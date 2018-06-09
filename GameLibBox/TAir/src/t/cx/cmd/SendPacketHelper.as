package t.cx.cmd	
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.DOUBLE;
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.CType.WORD;
	import t.cx.cmd.enum.enDTP;
	import t.cx.cmd.struct.tagDataDescribe;
	
	/**
	 * 发送叠加数据
	 * */
	public class SendPacketHelper
	{
		public function SendPacketHelper()
		{
		}
		public static function _attachBYTE(bytes : ByteArray,data : uint,type : uint = enDTP.DTP_NULL) : uint
		{
			var wPacketSize : uint = _newDescribe(bytes,BYTE.size,type);
			BYTE.write(data,bytes);
			wPacketSize += BYTE.size;
			return wPacketSize;
		}
		public static function _attachWORD(bytes : ByteArray,data : int,type : uint = enDTP.DTP_NULL) : uint
		{
			var wPacketSize : uint = _newDescribe(bytes,WORD.size,type);
			WORD.write(data,bytes);
			wPacketSize += WORD.size;
			return wPacketSize;
		}
		public static function _attachDWORD(bytes : ByteArray,data : int,type : uint = enDTP.DTP_NULL) : uint
		{
			var wPacketSize : uint = _newDescribe(bytes,DWORD.size,type);
			DWORD.write(data,bytes);
			wPacketSize += DWORD.size;
			return wPacketSize;
		}
		public static function _attachDOUBLE(bytes : ByteArray,data : Number,type : uint = enDTP.DTP_NULL) : uint
		{	
			var wPacketSize : uint = _newDescribe(bytes,DOUBLE.size,type);
			DOUBLE.write(data,bytes);
			wPacketSize += DOUBLE.size;
			return wPacketSize;
		}
		public static function _attachLONG(bytes : ByteArray,data : Number,type : uint = enDTP.DTP_NULL) : uint
		{
			var wPacketSize : uint = _newDescribe(bytes,LONG.size,type);
			LONG.write(data,bytes);
			wPacketSize += LONG.size;
			return wPacketSize;
		}
		public static function _attachTCHAR(bytes : ByteArray,data : String,len : int,type : uint = enDTP.DTP_NULL) : uint
		{
			var wPacketSize : uint = _newDescribe(bytes,len,type);
			TCHAR.write(data,bytes,len);
			wPacketSize += len;
			return wPacketSize;
		}
		public static function _attachByteArray(bytes : ByteArray,data : ByteArray,wDataSize : uint,type : uint = enDTP.DTP_NULL) : uint
		{
			var wPacketSize : uint = _newDescribe(bytes,wDataSize,type);
			bytes.writeBytes(data);
			wPacketSize += wDataSize;
			return wPacketSize;
		}
		private static function _newDescribe(bytes : ByteArray,wDataSize : uint,type : uint) : uint
		{
			var describe : tagDataDescribe = new tagDataDescribe();
			describe.wDataSize = wDataSize;
			describe.wDataDescribe = type;
			bytes.writeBytes(describe.ToByteArray());
			return describe.size;
		}
	}
}