package t.cx.air.load
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import t.cx.air.enum.enLoaderResult;
	import t.cx.air.utils.HashMap;
	
	/**
	 * Urlloader加载器
	 * @author t&p
	 * */
	public class TURLLoader
	{
		private static var _urlMap : HashMap;
		private static var _urlloader : URLLoader;
		private static var _current : UrlloaderVO;
		public static function load(value : UrlloaderVO) : void
		{
			if(value == null) return;
			if(_urlMap == null)_urlMap = new HashMap();
			_urlMap.put(value.label,value);
			DoNextLoader();
		}
		public static function remove(label : String) : void
		{
			if(_urlMap && _urlMap.size()>0)
			{
				_urlMap.remove(label);
			}
			if(_current && _current.label == label)
			{
				_current = null;
				DoNextLoader();
			}
		}
		public static function removeAll() : void
		{
			if(_urlMap&&_urlMap.size()>0) {
				_urlMap.clear()
			}
			_current = null;
			DoNextLoader();
		}
		private static function DoNextLoader() : void
		{
			if(_urlMap&&_urlMap.size()==0)
			{
				_urlMap.clear();
				_urlMap = null;
				if(_current)
				{
					_current.Destroy();
					_current = null;
				}
				UnInscribingLoader();  
			}
			if(_urlMap==null)return;
			if(_urlloader == null)
			{
				InscribingLoader();
			}
			_current = _urlMap.values()[0];
			_urlloader.load(new URLRequest(_current.url));
			_urlMap.remove(_current.label);
		}
		private static function InscribingLoader() : void
		{
			if(_urlloader == null)
			{
				_urlloader = new URLLoader();
				_urlloader.addEventListener(ErrorEvent.ERROR,_error);
				_urlloader.addEventListener(Event.COMPLETE,_complete);
				_urlloader.addEventListener(IOErrorEvent.IO_ERROR,_error);
				_urlloader.addEventListener(ProgressEvent.PROGRESS,_progressEvent);
				_urlloader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,_error);
			}
		}
		private static function UnInscribingLoader() : void
		{
			if(_urlloader != null)
			{
				_urlloader.removeEventListener(ErrorEvent.ERROR,_error);
				_urlloader.removeEventListener(Event.COMPLETE,_complete);
				_urlloader.removeEventListener(IOErrorEvent.IO_ERROR,_error);
				_urlloader.removeEventListener(ProgressEvent.PROGRESS,_progressEvent);
				_urlloader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,_error);
				_urlloader = null;
			}
		}
		private static function _complete(e : Event) : void
		{
			if(_current)
			{
				if(_current.comFunction!=null)
				{
					switch(_current.resultType)
					{
						case enLoaderResult.enXML:
						{
							_current.comFunction(XML(e.target.data));
							break;
						}
						default:
						{
							_current.comFunction(e.target.data);
							break;
						}
					}
				}
			}
			DoNextLoader();
		}
		private static function _error(e : ErrorEvent) : void
		{
			if(_current)
			{
				if(_current.errFunction!=null)_current.errFunction(e.toString());
			}
			DoNextLoader();
		}
		private static function _progressEvent(e : ProgressEvent) : void
		{
			if(_current)
			{
				if(_current.progFunction!=null)_current.progFunction(e.bytesLoaded,e.bytesTotal);
			}
		}
	}
}