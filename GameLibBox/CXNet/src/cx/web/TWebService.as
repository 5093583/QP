package cx.web
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.system.System;

	public class TWebService
	{
		private var _loaderVec : Vector.<Object>;
		public function TWebService()
		{
			
		}
		
		public function PostLoad(url : String,vars : URLVariables,completeCallBack : Function=null,errorCallBack : Function=null) : void
		{
			var urlReq : URLRequest = new URLRequest(url);
			urlReq.method = URLRequestMethod.POST;
			urlReq.data = vars;
			var nLoader : URLLoader = createLoader();
			if(_loaderVec == null) { _loaderVec = new Vector.<Object>() ;}
			_loaderVec.push({loader:nLoader,complete:completeCallBack,error : errorCallBack});
			nLoader.load(urlReq);
		}
		
		public function Clear() : void
		{
			if(_loaderVec != null && _loaderVec.length>0) 
			{
				for each(var obj : Object in _loaderVec)
				{
					if(obj != null) {
						destroyLoader(obj.loader);
					}
				}	
			}
			_loaderVec = null;
		}
		
		public function get Count() : int
		{
			if(_loaderVec == null) return 0;
			return _loaderVec.length;
		}
		private function createLoader() : URLLoader
		{
			var urlLoader : URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE,onLoadComplete);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,onError);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onError);
			
			return urlLoader;
		}
		private function destroyLoader(loader : URLLoader) : void
		{
			if(loader != null)
			{
				loader.removeEventListener(Event.COMPLETE,onLoadComplete);
				loader.removeEventListener(IOErrorEvent.IO_ERROR,onError);
				loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onError);
				loader.close();
				loader = null;
			}
		}
		private function onLoadComplete(e : Event) : void
		{
			var xmll : XML = XML(e.target.data);
			for(var i : uint = 0;i<_loaderVec.length;i++)
			{
				if(_loaderVec[i] != null && _loaderVec[i].loader==e.target)
				{
					if(_loaderVec[i].complete != null)
					{
						_loaderVec[i].complete(xmll);
					}
					destroyLoader( _loaderVec[i].loader );
					_loaderVec.splice(i,1);
					break;
				}
			}
			if(_loaderVec.length == 0) {
				_loaderVec = null;
			}
			System.disposeXML(xmll);
		}
		private function onError(e : ErrorEvent) : void
		{
			for(var i : uint = 0;i<_loaderVec.length;i++)
			{
				if(_loaderVec[i] != null && _loaderVec[i].loader==e.target)
				{
					if(_loaderVec[i].onError != null)
					{
						_loaderVec[i].onError(e.toString());
					}
					destroyLoader( _loaderVec[i].loader );
					_loaderVec.splice(i,1);
					break;
				}
			}
			if(_loaderVec.length == 0) {
				_loaderVec = null;
			}
		}
	}
}