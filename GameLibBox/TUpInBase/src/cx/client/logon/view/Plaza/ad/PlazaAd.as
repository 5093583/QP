package cx.client.logon.view.Plaza.ad
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.ApplicationDomain;
	import flash.system.System;
	import flash.utils.Timer;
	
	import t.cx.air.TConst;
	import t.cx.air.TDas;
	import t.cx.air.skin.ButtonEx;
	
	public class PlazaAd extends Sprite
	{
		protected var _adInfo : Vector.<Object>;
		protected var _nowIndex : int;
		protected var _time : Timer;
		public function PlazaAd()
		{
			super();
			if(stage)
			{
				onInit(null)
			}else {
				this.addEventListener(Event.ADDED_TO_STAGE,onInit);
			}
		}
		protected function onInit(e : Event) : void
		{
			var xml : XML = new XML(TDas._getStringItem(TConst.PLAZA_AD,1024));
			var _adXml : XMLList = xml.elements('item');
			if(_adXml == null)return;
			
			if(_adXml.length() <= 0) return;
			_adInfo = new Vector.<Object>();
			for(var i : uint = 0;i<_adXml.length();i++) 
			{
				if(_adXml[i].img != '')
				{
					var loader : Loader = new Loader();
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loaderComplete);
					loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onError);
					loader.load(new URLRequest(_adXml[i].img));
					var obj : Object = new Object();
					obj.index = i;
					obj.link = _adXml[i].link;
					obj.enable = _adXml[i].enable;
					obj.img = _adXml[i].img;
					
					obj.btn = CreateBtn();
					if( obj.btn != null ) {
						OnSetImgBtn(obj.btn,_adInfo.length);
					}
					_adInfo.push(obj);
				}
			}
			this.buttonMode = true;
			this.addEventListener(MouseEvent.CLICK,onMouseClickEvent);
		}
		protected function OnSetImgBtn(btn : ButtonEx,index : uint) : void
		{
			if(btn!=null){
				btn.y = 118;
				btn.x = 170 - 15 * index;
			}
		}
		private function loaderComplete(e : Event) : void
		{
			var loadInfo : LoaderInfo = e.target as LoaderInfo;
			if(loadInfo == null) return;
			loadInfo.removeEventListener(Event.COMPLETE,loaderComplete);
			loadInfo.removeEventListener(IOErrorEvent.IO_ERROR,onError);
			var dos : DisplayObject = loadInfo.content;
			if(dos == null) return;
			var tw : Number =  dos.width;
			var th : Number =  dos.height;
			
			var wh : Object = txywh;
			dos.x = wh.x;
			dos.y = wh.y;
			dos.scaleX = wh.w / tw;
			dos.scaleY = wh.h / th;
			theContiner.addChild(dos);
			trace('loaderComplete',_adInfo,loadInfo);
			for each(var obj : Object in _adInfo)
			{
				trace('loaderComplete2:',obj);
				if(obj.img == loadInfo.url) {
					_nowIndex = obj.index;
					if(_adInfo.length > 1) {
						startTimer(); 
					}
					obj.dos = dos;
					if( obj.btn!=null ) {
						obj.btn.addEventListener(MouseEvent.CLICK,onSelectImg);
						this.addChild(obj.btn);
					}
				}
			}
		}
		protected function get txywh() : Object
		{
			return {x:0,y:0,w:188,h:138};
		}
		private function onError(e : IOErrorEvent) : void
		{
			trace('onError:',e);
		}
		private function startTimer() : void
		{
			if(_time == null)
			{
				_time = new Timer(3000,1);
				_time.addEventListener(TimerEvent.TIMER,onTimperEvent);
				_time.start();
			}
		}
		private function onTimperEvent(e : TimerEvent) : void
		{
			var adf : Object = _adInfo[_nowIndex];
			adf.dos.visible = false;
			_nowIndex++;
			_nowIndex = _nowIndex >_adInfo.length-1?0 : _nowIndex;
			var adn : Object = _adInfo[_nowIndex];
			adf.dos.visible = true;
			_time.reset();
			_time.start();
		}
		protected function onMouseClickEvent(e : MouseEvent) : void
		{
			
		}
		protected function onSelectImg(e : MouseEvent) : void
		{
			if(_time != null) {
				_time.reset();
				_time.start();
			}
			for each(var obj : Object in _adInfo)
			{
				if(obj != null )
				{
					if(obj.btn == e.target) {
						obj.dos.visible = true;
						_nowIndex = obj.index;
					}else {
						obj.dos.visible = false;
					}
				}
			}
			e.stopImmediatePropagation();
		}
		private function CreateBtn() : ButtonEx
		{
			if( ApplicationDomain.currentDomain.hasDefinition( 'AdThum' ) ) {
				var btnClass : Class = ApplicationDomain.currentDomain.getDefinition('AdThum') as Class;
				if( btnClass!=null ) {
					var btn : ButtonEx = new btnClass();
					return btn;
				}
			}
			return null;
		}
		private function get theContiner() : Sprite
		{
			return this['AdContiner'];
		}
	}
}