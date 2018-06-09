package t.cx.Interface
{
	import flash.utils.ByteArray;

	public interface IKernelSocket
	{
		/**-------------------------------------------------
		 * 通信加密接口
		 * -------------------------------------------------*/
		function CxTcpConnect(cbVersion : uint) : uint;
		function CxTcpEncrypt(wMainCMD : uint,wSubCMD : uint,pData : ByteArray,wDataSize : uint) : uint;
		function CxTcpCrevasse(pData : ByteArray,wDataSize : uint) : uint;
		function CxTcpClose() : uint;
	}
}