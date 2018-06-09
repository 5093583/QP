package cx.net
{
	import t.cx.Interface.ICXKernel;
	import t.cx.Interface.IKernelFile;
	import t.cx.Interface.IKernelSocket;
	import t.cx.Interface.IKernelWin;

	public class NetConst
	{
		private static var _pCxFile : IKernelFile;
		public static function get pCxFile() : IKernelFile
		{
			return _pCxFile;
		}
		
		private static var _pCxSocket : IKernelSocket;
		public static function get pCxSocket() : IKernelSocket
		{
			return _pCxSocket;
		}
		private static var _pCxWin : IKernelWin;
		public static function get pCxWin() : IKernelWin
		{
			return _pCxWin;
		}
		public function NetConst()
		{
		}
		public static function Init(pSocket : IKernelSocket,pFile : IKernelFile,pWin : IKernelWin=null) : void
		{
			_pCxWin  	= pWin;
			_pCxFile 	= pFile;
			_pCxSocket 	= pSocket;
		}
	}
}