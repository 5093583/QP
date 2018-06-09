package cx.client.logon.view.Plaza
{
	import cx.net.NetConst;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import t.cx.Interface.IHtmlContiner;
	import t.cx.air.TConst;
	import t.cx.air.TDas;
	
	public class PlazaBulletin extends Sprite
	{
		private var _sprite : Sprite;
		private var _webWidth : Number;
		private var _webHeight : Number;
		
		public function PlazaBulletin()
		{
			super();
			if(stage) {
				onInit();
			}else {
				this.addEventListener(Event.ADDED_TO_STAGE,onInit);
			}
		}
		private function onInit(e : Event = null) : void
		{
			if(NetConst.pCxWin) {
				var html : IHtmlContiner = NetConst.pCxWin.CxCreateHtmlContiner();
				_sprite = html.GetDisplay();
				_sprite.mouseChildren = false;
				_sprite.mouseEnabled = false;
				theContiner.addChild(_sprite);
				_webWidth = TDas._getDoubleItem(TConst.POST_WIDTH);
				_webHeight = TDas._getDoubleItem(TConst.POST_HEIGHT);
				
				_webWidth = _webWidth==0?190:_webWidth;
				_webHeight = _webHeight==0?315:_webHeight;
				
				OnLoadHtml( html );
				html.SetWH(_webWidth,_webHeight);
				this.addEventListener(Event.ENTER_FRAME,onEnterFrame);
				this.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
				this.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
			}
		}
		protected function OnLoadHtml(html :IHtmlContiner) : void
		{
			var str : String = TDas._getStringItem(TConst.POST_URL,8192);
			html.LoadString(str);
		}
		public function Start() : void
		{
			if(!this.hasEventListener(Event.ENTER_FRAME))
			{
				this.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			}
			if(!this.hasEventListener(MouseEvent.MOUSE_OVER))
			{
				this.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			}
			if(!this.hasEventListener(MouseEvent.MOUSE_OUT))
			{
				this.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
			}
			this.visible = true;
		}
		public function Stop() : void
		{
			this.visible = false;
			this.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
			this.removeEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheel);
			this.removeEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			this.removeEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
		}
		private function onEnterFrame(e : Event) : void
		{
			if(_sprite)
			{
				_sprite.y -= 1.0;
				if( (_sprite.y + _sprite.height) <=0)
				{
					_sprite.y = 315;
				}
			}
		}
		private function onMouseOver(e : MouseEvent) : void
		{
			this.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
			this.addEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheel);
		}
		private function onMouseOut(e : MouseEvent) : void
		{
			this.removeEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheel);
			this.addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		private function onMouseWheel(e : MouseEvent) : void
		{
			if(_sprite.y > _sprite.height) { _sprite.y =- 315; }
			if( (_sprite.y + _sprite.height) < 0) { _sprite.y = 315; }
			_sprite.y -= e.delta;
		}
		private function get theContiner() : Sprite
		{
			return this['ConMC'];
		}
	}
}