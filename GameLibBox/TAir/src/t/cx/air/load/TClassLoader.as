package t.cx.air.load
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import t.cx.air.enum.enAppDomain;

	/**
	 * load加载器
	 * @author t&p
	 * */
	public class TClassLoader extends EventDispatcher
	{
		public static const LOAD_COMPLETE 	: String	= 'load_complete';
		public static const LOAD_PROGRESS	: String	= 'load_progress';
		public static const LOAD_ERROR		: String	= 'load_error';
		
		private var _loader 	: Loader;			//加载器
		private var _tUrl		: String;			//加载内容地址
		private var request 	: URLRequest;		//资源请求
		
		
		public function TClassLoader()
		{
			InitHandler();
		}
		public function Destroy() : void
		{
			UninitHandler();
			request = null;
			_tUrl 	= "";
		}
		//初始化下载器
		private function InitHandler() : void
		{
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,completeFirstHandler);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,progressHandler);
			_loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);
		}
		
		//释放下载器
		private function UninitHandler():void
		{
			_loader.contentLoaderInfo.removeEventListener(Event.INIT,completeFirstHandler);
			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
			_loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);
			_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,progressHandler);
			_loader = null;
		}
		//下载
		public function load(url : String,nAppDomain : uint = enAppDomain.enNull) : void
		{
			_tUrl = url;
			request = new URLRequest(_tUrl);
			var context : LoaderContext = new LoaderContext();
			switch(nAppDomain)
			{
				case enAppDomain.enChild:
				{
					context.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
					break;
				}
				case enAppDomain.enCurrent:
				{
					context.applicationDomain = ApplicationDomain.currentDomain;
					break;
				}
				case enAppDomain.enNew:
				{
					context.applicationDomain = new ApplicationDomain();
					break;
				}
				case enAppDomain.enNull:
				{
					context.applicationDomain = null;
				}
				default:
				{
					context.applicationDomain = null;
					break;
				}
			}
			_loader.load(request,context);
		}
		
		private function completeFirstHandler(e : Event) : void
		{
			
		}
		private function ioErrorHandler(e : IOErrorEvent) : void
		{
			
		}
		private function securityErrorHandler(e : SecurityErrorEvent) : void
		{
			
		}
		private function progressHandler(e : ProgressEvent) : void
		{
			
		}
	}
}