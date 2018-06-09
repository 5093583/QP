package base
{
	import cx.kernel.CModule;
	import cx.kernel.Tcp.TcpClose;
	import cx.kernel.Tcp.TcpConnect;
	import cx.kernel.Tcp.TcpCrevasse;
	import cx.kernel.Tcp.TcpEncrypt;
	import cx.net.NetConst;
	
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	
	import t.cx.Interface.IKernelFile;
	import t.cx.Interface.IKernelSocket;
	import t.cx.Interface.IKernelWin;
	import t.cx.air.utils.Memory;

	public class NetConnect implements IKernelSocket
	{
		public function NetConnect()
		{
		}
		
		
		
		private static var _instance:NetConnect;
		public static function getInstance():NetConnect
		{
			if (!_instance ) _instance = new NetConnect();
			return _instance;
		}
		
		public function init():void
		{
			NetConst.Init(this as IKernelSocket,this as IKernelFile,this as IKernelWin);
		}
		
		
		
		
		
		public function CxTcpClose():uint
		{
			return TcpClose();
		}
		
		public function CxTcpConnect(cbVersion:uint):uint
		{
			return theTcpConnect(cbVersion);
		}
		
		public function get theTcpConnect() : Function
		{
			return TcpConnect;
		}
		
		public function CxTcpCrevasse(pData:ByteArray, wDataSize:uint):uint
		{
			pData.position = 0;
			var bytesPtr:int = CModule.malloc(pData.bytesAvailable);
			CModule.writeBytes(bytesPtr,pData.length,pData);
			var result : uint = TcpCrevasse(bytesPtr,wDataSize);
			pData.position = 0;
			CModule.readBytes(bytesPtr,pData.bytesAvailable,pData);
			CModule.free(bytesPtr);
			return result;
		}
		
		public function CxTcpEncrypt(wMainCMD:uint, wSubCMD:uint, pData:ByteArray, wDataSize:uint):uint
		{
			var pNewData : ByteArray = Memory._newLiEndianBytes();
			pNewData.writeDouble(0);
			Memory._copyMemory(pNewData,pData,wDataSize,8);
			
			pNewData.position = 0;
			var bytesPtr:int = CCModule.malloc(pNewData.bytesAvailable);
			
			CCModule.writeBytes(bytesPtr,pNewData.bytesAvailable,pNewData);
			pNewData.position = 0;
			var result : uint = theTcpEncrypt(wMainCMD,wSubCMD,bytesPtr,pNewData.bytesAvailable);
			CCModule.readBytes(bytesPtr,pNewData.bytesAvailable,pNewData);
			CCModule.free(bytesPtr);
			Memory._copyMemory(pData,pNewData,pNewData.length);
			return result;
		}
		
		protected function get CCModule() : Object
		{
			return CModule;
		}
		
		protected function get theTcpEncrypt() : Function
		{
			return TcpEncrypt;
		}
		
		
		
	}
}