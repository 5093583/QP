package t.cx.air
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.HTMLUncaughtScriptExceptionEvent;
	import flash.html.HTMLLoader;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import t.cx.Interface.IHtmlContiner;
	import t.cx.air.skin.LoadCircle;
	import t.cx.air.utils.MD5;
	import t.cx.air.utils.SystemEx;

	public class HtmlSprite extends HTMLLoader implements IHtmlContiner
	{
		private var _loadCircle : LoadCircle;
		private var _timerCode : String;
		public function get timeCode() : String
		{
			if(_timerCode== null) {
				createCode();
			}
			return _timerCode;
		}
		public function HtmlSprite()
		{
			super();
			useCache = true;
		}
		public function GetDisplay() : Sprite
		{
			return this;
		}
		public function SetHost(val:String,bPaint : Boolean = false):void
		{
			paintsDefaultBackground = bPaint;
			if(!this.hasEventListener(Event.HTML_DOM_INITIALIZE)) {
				this.addEventListener(Event.HTML_DOM_INITIALIZE,onIntiDomEvent);
				this.addEventListener(Event.COMPLETE,onLoadComplete);
				this.addEventListener(HTMLUncaughtScriptExceptionEvent.UNCAUGHT_SCRIPT_EXCEPTION,onUnExceptionEvent);
			}
			startloader();
			this.load( new URLRequest(val));
		}
		public function onUnExceptionEvent(e : HTMLUncaughtScriptExceptionEvent) : void
		{
			e.stopImmediatePropagation();
			e.stopPropagation();
			trace('HTML onUnExceptionEvent:' + e);
		}
		public function LoadString(val : String) : void
		{
			paintsDefaultBackground = false;
			loadString(val);
		}
		public function SetWH(w : Number,h : Number) : void
		{
			this.width = w;
			this.height = h;
		}
		private function onIntiDomEvent(e : Event) : void
		{
			if(_callBack != null) {
				this.window.callBack = _callBack;
				this.window.jsGetValue = _jsGetValue;
				this.window.alert = alert;
			}
		}
		private function onLoadComplete(e : Event) : void
		{
			hideloader();
		}
		private function alert(val : *) : void
		{
			trace('alert:',val);
		}
		public function CancelLoad() : void
		{
			this.removeEventListener(Event.HTML_DOM_INITIALIZE,onIntiDomEvent);
			this.removeEventListener(HTMLUncaughtScriptExceptionEvent.UNCAUGHT_SCRIPT_EXCEPTION,onUnExceptionEvent);
			this.cancelLoad();
			hideloader();
			_callBack = null;
			_jsGetValue = null;
			_timerCode = null;
			loadString('加载中...');
		}
		public function RelLoad() : void
		{
			this.reload();
		}
		
		public function SendToWeb(type : int,val : String) : void
		{
			if(this.window.hasOwnProperty('FromClientInfo'))
			{
				this.window.FromClientInfo(type,val);
			}else {
				if(this.window.frames['Main'])
				{
					if(this.window.frames['Main'].hasOwnProperty('FromClientInfo'))
					{
						this.window.frames['Main'].FromClientInfo(type,val);
					}
				}
			}
		}
		private var _callBack : Function;
		public function set CallBack(val : Function) : void
		{
			_callBack = val;
		}
		private var _jsGetValue : Function;
		public function set JsGetValue(val : Function) : void
		{
			_jsGetValue = val;
		}
		
		private function hideloader() : void
		{
			if(_loadCircle)
			{
				if(this.parent && this.parent.contains(_loadCircle))
				{
					this.parent.removeChild(_loadCircle);
				}
				_loadCircle.destroy();
				_loadCircle = null;
			}
		}
		private function startloader() : void
		{
			hideloader();
			if(this.parent)
			{
				_loadCircle = new LoadCircle(this.width,this.height);
				_loadCircle.x = this.x;
				_loadCircle.y = this.y;
				this.parent.addChild(_loadCircle);
			}
		}
		protected function createCode() : void
		{
			_timerCode = new Date().time.toString();
			_timerCode += SystemEx._clientSequence();
			_timerCode = MD5.hash(_timerCode);
		}
		public function checkCode(val : String) : Boolean
		{
			return _timerCode == val;
		}
	}
}