package cx.client.logon.view.version
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	import t.cx.air.TConst;
	import t.cx.air.TDas;
	
	public class VersionButton extends MovieClip
	{
		public function VersionButton()
		{
			super();
			this.buttonMode = true;
			this.mouseChildren = false;
			this['TiShiMC'].visible = false;
			this['TiShiMC'].gotoAndStop(1);
			
			if(stage) {
				onInit();
			}else {
				this.addEventListener(Event.ADDED_TO_STAGE,onInit);
			}
		}
		private function onInit(e : Event = null) : void
		{
			if(e != null) this.removeEventListener(Event.ADDED_TO_STAGE,onInit);
			var ver : Number = TDas._getDoubleItem(TConst.VER);
			var newVer : Number = TDas._getDoubleItem('new_version_check');
			theVerInfo.text = '版本:v' +GetVer(ver);
			
			if( newVer != ver )
			{
				theVerInfo.appendText( '(版本不正确,请点击查看)' );
				this['TiShiMC'].visible = true;
				this['TiShiMC'].gotoAndPlay(1);
			}else {
				theVerInfo.appendText( '(当前已是最新版本)' );
			}
			
		}
		private function get theVerInfo() : TextField
		{
			return this['verInfo'];
		}
		private function GetVer(num : Number) : String
		{
			var ver : String = num.toString();
			var result : String = '';
			for(var i : uint = 0;i<ver.length-1;i++)
			{
				result+=ver.charAt(i) + '.';
			}
			result+=ver.charAt(i);
			return result;
		}
		
		public function Destroy() : void
		{
			this.gotoAndStop(1);
			theVerInfo.text = '';
			this['verInfo'] = null;
			this['TiShiMC'].gotoAndStop(1);
			this['TiShiMC'] = null;
		}
	}
}