package t.cx.air
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import t.cx.air.load.TURLLoader;
	import t.cx.air.load.UrlloaderVO;

	public class TCheckLocalIP
	{
		public function TCheckLocalIP()
		{
			
		}
		public static function _checkIpIsp() : void
		{
			var urlLoader : URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE,OnCompleteEventEx);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,onError);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onError);
			urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			urlLoader.load(new URLRequest('http://www.ip138.com/ips138.asp'));
			
		}
		
		private static function OnCompleteEventEx(e : Event) : void
		{
			var loader : URLLoader = e.target as URLLoader;
			
			if(loader != null)
			{
				loader.removeEventListener(Event.COMPLETE,OnCompleteEventEx);
				loader.removeEventListener(IOErrorEvent.IO_ERROR,onError);
				loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onError);
				if(loader.data != null) {
					var bytes : ByteArray = loader.data as ByteArray;
					var str : String = bytes.readMultiByte(bytes.length,"gb2312");
					var ispName : Array = ["电信",'铁通 ','联通','网通'];
					var ispType : Array = [1,1,2,2];
					for(var i : uint = 0;i<ispName.length;i++)
					{
						if( str.search(ispName[i])!=-1 )
						{
							TDas._setByteItem(TConst.PROXY,ispType[i]);
							return;
						}
					}
				}
			}
			TDas._setByteItem(TConst.PROXY,2);
		}
		private static function onError(e : ErrorEvent) : void
		{
			trace('[TCheckLocalIP]'+e);
			var loader : URLLoader = e.target as URLLoader;
			if(loader != null)
			{
				loader.removeEventListener(Event.COMPLETE,OnCompleteEventEx);
				loader.removeEventListener(IOErrorEvent.IO_ERROR,onError);
				loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onError);
			}
			
			if( TDas._getByteItem(TConst.PROXY) == 0)
				TDas._setByteItem(TConst.PROXY,1);
		}
	}
}