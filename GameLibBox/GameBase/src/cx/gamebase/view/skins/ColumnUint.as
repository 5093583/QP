package cx.gamebase.view.skins
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class ColumnUint extends Shape
	{
		private var _w : Number;
		private var _h : Number;
		public function ColumnUint(w : Number,h : Number)
		{
			super();
			
			_w = w;
			_h = h;
			if(stage)
			{
				onInit();
			}else {
				this.addEventListener(Event.ADDED_TO_STAGE,onInit);
			}
		}
		private function onInit(e : Event = null) : void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onInit);
			select = false;
		}
		private var _select : Boolean;
		public function set select(value : Boolean) : void
		{
			if(_selected) return;
			_select = value;
			this.graphics.clear();
			this.graphics.beginFill(_select?0x33FF33:0xA1A5A7,1.0);
			this.graphics.drawRect(0,0,_w,_h);
			this.graphics.endFill();
		}
		private var _selected : Boolean;
		public function set selected(val : Boolean) : void
		{
			_selected = val;
			this.graphics.clear();
			this.graphics.beginFill(_selected?0x00DBFF:0xA1A5A7,1.0);
			this.graphics.drawRect(0,0,_w,_h);
			this.graphics.endFill();
		}
		public function get selected() : Boolean
		{
			return _selected;
		}
		
	}
}