package cx.client.logon.view.welcome
{
	import cx.net.NetConst;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import t.cx.Interface.IHtmlContiner;
	import t.cx.air.TConst;
	import t.cx.air.TDas;
	
	public class WelcomeWebContiner extends Sprite
	{
		private var _html : IHtmlContiner;
		
		protected function get html_Width() : Number
		{
			return 276;
		}
		protected function get html_Height() : Number
		{
			return 188;
		}
		
		public function WelcomeWebContiner()
		{
			super();
			if( stage ) {
				onInit();
			}else {
				this.addEventListener(Event.ADDED_TO_STAGE,onInit);
			}
		}
		
		public function Destory() : void
		{
			this.removeChildren();
			if(_html != null) {
				_html.CancelLoad();
				_html = null;
				_url = null;				 
			}
			this.removeEventListener(MouseEvent.CLICK,onClick);
		}
		private var _url : String;
		protected function onInit( e : Event = null ) : void
		{
			_url= TDas._getStringItem(TConst.WELCOME_AD,512);
			if(_url != null) {
				if(NetConst.pCxWin != null) {
					_html = NetConst.pCxWin.CxCreateHtmlContiner();
					if(_html != null) {
						_html.GetDisplay().mouseChildren = false;
						_html.GetDisplay().mouseEnabled = false;
						_html.GetDisplay().buttonMode = true;
						_html.SetWH(html_Width,html_Height);
						_html.SetHost(_url,true);
						this.addChild(_html.GetDisplay());
						this.addEventListener(MouseEvent.CLICK,onClick);
					}
				}
			}
		}
		private function onClick(e : MouseEvent) : void
		{
			if(_url != null) {
				if(_url.indexOf('?link=')!=-1) {
					var n_url : String = _url.substring(_url.indexOf('?link=')+6);
					navigateToURL(new URLRequest(n_url));
				}
			}
		}
	}
}