package t.cx.air.skin
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class CheckBoxEx extends MovieClip
	{
		[Event(name="SelectChanged", type="flash.events.Event")]
		private var _iDos 	:  ICheckDisplay;
		private var _bRepeatSelect : Boolean;
		public function set RepeatSelect(val : Boolean) : void
		{
			_bRepeatSelect = val;	
		}
		private var _select : Boolean;
		public function get select() : Boolean
		{
			return _select;
		}
		public function set select(value : Boolean) : void
		{
			_select = value;
			
			if(_select) {
				this.gotoAndStop(2);
			}else {
				this.gotoAndStop(1);
			}
			if(_iDos) { _iDos.IVisible = _select; }
		}
		public function CheckBoxEx(bSelect : Boolean = false)
		{
			super();
			select = bSelect;
			this.buttonMode = true;
			this.tabChildren = false;
			this.tabEnabled = false;
			_bRepeatSelect = true;
			this.addEventListener(MouseEvent.CLICK,OnSelectedChange);
		}
		public function BindDisplay(idos : ICheckDisplay) : void
		{
			_iDos = idos;
		}
		protected function OnSelectedChange(event : MouseEvent) : void
		{
			if(select) {
				if(_bRepeatSelect) {
					select = !_select;
					dispatchEvent(new Event('SelectChanged'));
				}
			}else {
				select = !_select;
				dispatchEvent(new Event('SelectChanged'));
			}
		}
		public function Destroy() : void
		{
			_select = false;
			this.removeEventListener(MouseEvent.CLICK,OnSelectedChange);
			stop();
			while(numChildren > 0){ removeChildAt(0); }
			for(var k:String in this){
				delete this[k];
			}
		}
	}
}