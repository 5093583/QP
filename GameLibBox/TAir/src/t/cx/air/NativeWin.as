package t.cx.air
{
	import flash.display.NativeWindow;
	import t.cx.Interface.ICxKernelClient;

	public class NativeWin
	{
		public var pICxClient : ICxKernelClient;
		public var pWindow : NativeWindow;
		public function NativeWin(wind : NativeWindow)
		{
			pWindow = wind;
		}
		public function Destroy(cbDestroyCode : uint = 0) : void
		{
			pICxClient.CxClientDestroy(cbDestroyCode);
			pICxClient = null;
			pWindow.close();
			pWindow = null;
		}
	}
}