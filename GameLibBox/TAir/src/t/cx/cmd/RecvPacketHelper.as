package t.cx.cmd
{
	import flash.utils.ByteArray;
	
	import t.cx.cmd.enum.enDTP;
	import t.cx.cmd.struct.tagDataDescribe;

	public class RecvPacketHelper
	{
		public function RecvPacketHelper()
		{
		}
		public static function _recvPacket(pBuffer : ByteArray) : tagDataDescribe
		{
			if(pBuffer.bytesAvailable <= tagDataDescribe.SIZE) return null;
			var describe : tagDataDescribe = tagDataDescribe._readBuffer(pBuffer);
			if(describe.wDataDescribe == enDTP.DTP_NULL) return null;
			if(describe.wDataSize > pBuffer.bytesAvailable) return null;
			return describe;
		}
		
	}
}