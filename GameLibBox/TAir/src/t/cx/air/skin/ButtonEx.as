package t.cx.air.skin
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import t.cx.air.utils.Memory;
	
	public class ButtonEx extends MovieClip
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
				this.updateFrame(4);
				this.mouseEnabled = false;
			}else{
				this.addEventListener(MouseEvent.MOUSE_OVER,OnMouseOver);
				this.mouseEnabled = true;
				this.updateFrame(1);
			}
		}
		private var _select : Boolean;
		public function get select() : Boolean
		{
			return _select;
		}
		public function set select(val : Boolean) : void
		{
			_select = val;
			if(_select) {
				this.updateFrame(5);
			}else {
				this.updateFrame(1);
			}
		}
		public function ButtonEx()
		{
			super();
			this.mouseChildren = false;
			this.updateFrame(1);
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
			if(_enable && !_select){
				this.updateFrame(2);
				this.addEventListener(MouseEvent.MOUSE_OUT,OnMouseOut);
				this.addEventListener(MouseEvent.MOUSE_DOWN,OnMouseDown);
				this.addEventListener(MouseEvent.MOUSE_UP,OnMouseUp);
			}
		}
		
		protected function OnMouseOut(event : MouseEvent) : void
		{
			if(_select) {
				this.updateFrame(5);
			}else if(_enable) {
				this.updateFrame(1); 
			}
			this.removeEventListener(MouseEvent.MOUSE_OUT,OnMouseOut);
			this.removeEventListener(MouseEvent.MOUSE_DOWN,OnMouseDown);
			this.removeEventListener(MouseEvent.MOUSE_UP,OnMouseUp);
		}
		protected function OnMouseUp(event : MouseEvent) : void
		{
			if(_select) {
				this.updateFrame(5);
			}else if(_enable) {
				this.updateFrame(2); 
			}
		}
		protected function OnMouseDown(event : MouseEvent) : void
		{
			if(_select) {
				this.updateFrame(5);
			}else if(_enable) {
				this.updateFrame(3);
			}
		}
		public function Destroy() : void
		{
			if(this.hasOwnProperty('label_txt'))
			{
				this['label_txt'].text = '';
				this['label_txt'] = null;
			}
			_label = null;
			_enable = false;
			this.removeEventListener(MouseEvent.MOUSE_OVER,OnMouseOver);
			this.removeEventListener(MouseEvent.MOUSE_OUT,OnMouseOut);
			this.removeEventListener(MouseEvent.MOUSE_DOWN,OnMouseDown);
			this.removeEventListener(MouseEvent.MOUSE_UP,OnMouseUp);
		}
		private function updateFrame(uFrame : int) : void
		{
			this.gotoAndStop(uFrame);
			if(this.hasOwnProperty('label_txt'))
			{
				if(_labelArrs != null && uFrame<=_labelArrs.length) {
					this['label_txt'].text = _labelArrs[uFrame-1].toString(); 
				}
			}
		}
		private var _labelArrs : Array;
		public function SetLabels(...params) : void
		{
			_labelArrs = new Array();
			for(var i : uint = 0;i<params.length;i++)
			{
				_labelArrs.push(params[i]);
			}
		}
		private var _label : String;
		public function set label(value : String) : void
		{
			_label = value;
			if(this.hasOwnProperty('label_txt'))
			{
				this['label_txt'].text = _label;
			}
			SetLabels(_label,_label,_label,_label,_label);
		}
		public function get label() : String
		{
			return _label;
		}
	}
}