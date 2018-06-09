package t.cx.air.file
{
	import flash.display.Loader;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import mx.controls.Label;
	
	import t.cx.air.utils.HashMap;

	public class TFileLoader
	{
		private static var _fileLoader : URLLoader;			//加载器
		private static var _current : TFileLoadVO;
		
		private static var _fileMap : HashMap;
		public function TFileLoader()
		{
		}
		
		public static function _addTask(value : TFileLoadVO) : void
		{
			if(value == null) return;
			if(_fileMap == null)_fileMap = new HashMap();
			_fileMap.put(value.target,value);
		}
		public static function _deleteTask(target : String) : void
		{
			if(_fileMap == null) return;
			var value : TFileLoadVO = _fileMap.remove(target) as TFileLoadVO;
			if(value)
			{
				value.Destroy();
				value = null;
			}
		}
		public static function _load() : void
		{
			if(_fileMap && _fileMap.size()>0)
			{
				_doNextLoader();
			}
		}
		public static function _taskCount() : uint
		{
			if(_fileMap == null) return 0;
			return _fileMap.size();
		}
		private static function _doNextLoader() : void
		{
			if(_fileMap.size()==0)
			{
				_fileMap.clear();
				_fileMap = null;
				if(_current)
				{
					_current.Destroy();
					_current = null;
				}
				_unInscribingLoader();
			}
			if(_fileMap==null)return;
			if(_current == null)
			{
				if(_fileLoader == null)_inscribingLoader();
				_current = _fileMap.values()[0];
				_fileLoader.load(new URLRequest(_current.url));
				_fileMap.remove(_current.target);
			}
		}
		
		private static function _inscribingLoader() : void
		{
			if(_fileLoader == null)
			{
				_fileLoader = new URLLoader();
				_fileLoader.dataFormat = URLLoaderDataFormat.BINARY;
				_fileLoader.addEventListener(Event.COMPLETE,_complete);
				_fileLoader.addEventListener(IOErrorEvent.IO_ERROR,_error);
				_fileLoader.addEventListener(ProgressEvent.PROGRESS,_progressEvent);
				_fileLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,_error);
			}
		}
		private static function _unInscribingLoader() : void
		{
			if(_fileLoader)
			{
				_fileLoader.removeEventListener(Event.COMPLETE,_complete);
				_fileLoader.removeEventListener(IOErrorEvent.IO_ERROR,_error);
				_fileLoader.removeEventListener(ProgressEvent.PROGRESS,_progressEvent);
				_fileLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,_error);
				_fileLoader = null;
			}
		}
		private static function _complete(e : Event) : void
		{
			if(_current)
			{
				//保存到本地
				if(_current.comFunction!=null) { _current.comFunction(_current.target); }
				var fileStream : FileStream = new FileStream();
				var path : String = TPather._fullPath(_current.local);
				var file : File = new File(path);
				fileStream.open(file, FileMode.WRITE);
				fileStream.writeBytes (_fileLoader.data);
				fileStream.close();
				_current.Destroy();
				_current = null;
			}
			_doNextLoader();
		}
		private static function _error(e : ErrorEvent) : void
		{
			if(_current)
			{
				if(_current.errFunction!=null)_current.errFunction(e.toString());
				if(_current) { _current.Destroy(); }
				_current = null;
			}
		}
		private static function _progressEvent(e : ProgressEvent) : void
		{
			if(_current)
			{
				if(_current.progFunction!=null)_current.progFunction(_current.index,e.bytesLoaded,e.bytesTotal);
			}
		}
	}
}