package cx.client.logon.view.Plaza.chat
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import t.cx.air.TConst;
	import t.cx.air.TDas;
	
	public class ChatComBox extends Sprite
	{
		private var _autoX : Number = 1;
		private var _autoY : Number = 0;
		
		private var _spArrs : Array;
		private var _txtArrs : Array;
		private var _returnStr : Function;
		public function ChatComBox()
		{
			super();
			this.visible = false;
			if(stage) {
				onInit();	
			}else {
				this.addEventListener(Event.ADDED_TO_STAGE,onInit);
			}
		}
		
		private function onInit(e : Event = null) : void
		{
			this.mouseChildren = false;
			this.mouseEnabled = false;
			_spArrs = new Array();
			_txtArrs = new Array();
			var xml : XML = XML(TDas._getStringItem(TConst.CHAT_LIST,20480));
			if(xml != null)
			{
				var list : XMLList = xml.child('item');
				for(var i : uint = 0;i<list.length();i++) 
				{
					_txtArrs.push(list[i]);
					var sp : Sprite = onCreateTextField(_txtArrs[i]);
					sp.x = _autoX;
					sp.y = _autoY;
					_autoY += sp.height + 4;
					theChatContiner.addChild(sp);
					_spArrs.push(sp);
				}
			}
		}
		public function Show(callBack : Function) : void
		{
			if(!this.visible) {
				for(var i : uint = 0;i<_spArrs.length;i++) 
				{
					var sp : Sprite = _spArrs[i];
					if(sp) {
						sp.addEventListener(MouseEvent.MOUSE_OVER,onMouseEvent);
						sp.addEventListener(MouseEvent.MOUSE_OUT,onMouseEvent);
						sp.addEventListener(MouseEvent.MOUSE_DOWN,onMouseEvent);
					}
				}
				this.addEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheelEvent);
				_returnStr = callBack;
				this.visible = true;
				this.mouseChildren = true;
				this.mouseEnabled = true;
			}
		}
		public function Hide(e : MouseEvent = null) : void
		{
			this.mouseChildren = false;
			this.mouseEnabled = false;
			this.visible = false;
			for(var i : uint = 0;i<_spArrs.length;i++) 
			{
				var sp : Sprite = _spArrs[i];
				if(sp) {
					sp.removeEventListener(MouseEvent.MOUSE_OVER,onMouseEvent);
					sp.removeEventListener(MouseEvent.MOUSE_OUT,onMouseEvent);
					sp.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseEvent);
				}
			}
			this.removeEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheelEvent);
		}
		private function onMouseWheelEvent(e : MouseEvent) : void
		{
			if(e.delta >0 && theChatContiner.y < 0)
			{
				theChatContiner.y += e.delta * 2;
			}else if(e.delta < 0 && Math.abs(theChatContiner.y) < theChatContiner.height-100)
			{
				theChatContiner.y += e.delta * 2;
			}
		}
		private function onCreateTextField(txt : String) : Sprite
		{
			var txtField : TextField = new TextField();
			txtField.width = 214;
			txtField.autoSize = TextFieldAutoSize.LEFT;
			txtField.multiline = true;
			txtField.defaultTextFormat = new TextFormat('宋体',12,0xCCCCCC);
			txtField.text = txt;
			txtField.selectable = false;
			txtField.mouseEnabled = false;
			
			var sp : Sprite = new Sprite();
			sp.addChild(txtField);
			return sp;
		}
		
		private function onMouseEvent(e : MouseEvent) : void
		{
			var sp : Sprite = e.target as Sprite;
			if(sp == null) return;
			switch(e.type) {
				case MouseEvent.MOUSE_OVER:
				{
					sp.graphics.clear();
					sp.graphics.beginFill(0x000000,0.4);
					sp.graphics.drawRect(0,0,218,sp.height);
					sp.graphics.endFill();
					break;
				}
				case MouseEvent.MOUSE_OUT:
				{
					sp.graphics.clear();
					break;
				}
				case MouseEvent.MOUSE_DOWN:
				{
					sp.graphics.clear();
					if(_returnStr != null) {
						var index : int = _spArrs.indexOf(sp);
						if(index != -1) {
							_returnStr(_txtArrs[index]);
						}
					}
					Hide();
					break;
				}
			}
		}
		private function get theChatContiner() : MovieClip
		{
			return this['ChatContiner'];
		}
	}
}