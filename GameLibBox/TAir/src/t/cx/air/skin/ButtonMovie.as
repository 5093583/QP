package t.cx.air.skin
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class ButtonMovie extends MovieClip
	{
		
		private var _enable : Boolean = true;
		public function get enable() : Boolean
		{
			return _enable;
		}
		public function set enable(value : Boolean) : void
		{
			_enable = value;
			if(!_enable){
				this.removeEventListener(MouseEvent.MOUSE_OVER,OnMouseOver);
				this.mouseEnabled = false;
			}else{
				this.addEventListener(MouseEvent.MOUSE_OVER,OnMouseOver);
				this.mouseEnabled = true;
			}
		}
		
		private var _select : Boolean;
		public function set select(bm : Boolean) : void
		{
			_select = bm;
			if(bm)
			{
				this.gotoAndPlay(1);
			}else {
				this.gotoAndStop(1);
			}
		}
		public function get select() : Boolean
		{
			return _select;
		}
		public function ButtonMovie()
		{
			super();
			this.mouseChildren = false;
			this.gotoAndStop(1);
			init();
		}
		private function init() : void
		{
			enable = true;
			this.tabChildren = false;
			this.tabEnabled = false;
			this.buttonMode = true;
		}
		protected function OnMouseOver(event : MouseEvent) : void
		{
			if(_enable){
				this.gotoAndPlay(1);
				this.addEventListener(MouseEvent.MOUSE_OUT,OnMouseOut);
			}
		}
		protected function OnMouseOut(event : MouseEvent) : void
		{
			if( !_select ) { this.gotoAndStop(1); }
			this.removeEventListener(MouseEvent.MOUSE_OUT,OnMouseOut);
		}
		public function Destroy() : void
		{
			_enable = false;
			_select = false;
			this.removeEventListener(MouseEvent.MOUSE_OVER,OnMouseOver);
			this.removeEventListener(MouseEvent.MOUSE_OUT,OnMouseOut);
		}
		
	}
}