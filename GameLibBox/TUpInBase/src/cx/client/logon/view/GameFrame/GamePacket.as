package cx.client.logon.view.GameFrame
{
	import cx.client.logon.model.ServerList;
	import cx.client.logon.model.vo.KindOption;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	public class GamePacket extends MovieClip
	{
		private var _dos : Bitmap;
		public function GamePacket()
		{
			super();
			theTip.text = '';
			theLoading.gotoAndStop(1);
			visible = false;
		}
		
		public function StartLoad(wKind : uint) : void
		{
			var option : KindOption = ServerList._getInstance().GetKindOption(wKind);
			if(option == null)return;
			StopLoad();
			visible = true;
			theLoading.gotoAndPlay(1);
			theTip.text = option.tip;
			var bitmapData : BitmapData;
			if(option.iconBigBitmapData!=null) {
				bitmapData = option.iconBigBitmapData;
			}else {
				bitmapData = option.iconBitmapData;
			}
			if(bitmapData != null)
			{
				_dos = new Bitmap(bitmapData);
				if(_dos.height > 300)
				{
					_dos.scaleX = _dos.scaleY = 300 / _dos.height;
				}
				_dos.x = (this.width - _dos.width) * .5;
				_dos.y = (365 - _dos.height);
				this.addChild(_dos);
			}
		}
		public function StopLoad() : void
		{
			visible = false;
			theLoading.gotoAndStop(1);
			theTip.text = '';
			if(_dos)
			{
				if(this.contains(_dos)) { this.removeChild(_dos); }
				_dos.bitmapData.dispose();
				_dos = null;
			}
		}
		
		public function SetText(str : String) : void
		{
			trace("showtext：  " + str)
			theTip.text = str;
		}
		private function get theLoading() : MovieClip
		{
			return this['LoadingMC']
		}
		
		private function get theTip() : TextField
		{
			return this['TipTxt'];
		}
	}
}