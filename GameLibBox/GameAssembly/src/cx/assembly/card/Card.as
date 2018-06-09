package cx.assembly.card
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Matrix;
	
	public class Card extends Sprite
	{
		private var _dos 	: DisplayObject;
		private var _value	: uint = 255;
		private var _width 	: Number;
		private var _height : Number;
		public function get value() : uint
		{
			return _value;
		}
		public function set value(val : uint) : void
		{
			if(_value == val) return;
			_value = val;
			if(_dos != null) { this.removeChild(_dos); _dos=null; }
			_dos = CardEmbed.GetCard(_value,_width,_height,_cardType);
			this.addChild(_dos);
			//this.transform.matrix = oldMatrix;
		}
		private var _bSelf : Boolean;
		public function set bSelf(value : Boolean) : void
		{
			_bSelf = value;
		}
		public function get bSelf() : Boolean
		{
			return _bSelf;
		}
		private var _wChairID : uint;
		public function get wChairID() : uint
		{
			return _wChairID;
		}
		public function  set wChairID(value : uint) : void
		{
			_wChairID = value;
		}
		private var _index : uint;
		public function set index(value : uint) : void
		{
			_index = value;
		}
		public function get index() : uint
		{
			return _index;
		}
		private var _dark : Boolean;
		private var _darkMask : Sprite;
		public function set dark(value : Boolean) : void
		{
			_dark = value;
			if(_dos != null)
			{
				if(_dark) {
					var mat : Array = 	[.33,.33,.33,0,0,
						.33,.33,.33,0,0,
						.33,.33,.33,0,0,
						0,0,0,1,0
					]
					var colorMat : ColorMatrixFilter = new ColorMatrixFilter(mat);
					_dos.filters = [colorMat];
				}else {
					_dos.filters = null;
				}
			}
		}
		public function get dark() : Boolean
		{
			return _dark;
		}
		private var _mark : Sprite;
		public function set mark(value : Boolean) : void
		{
			if(value) {
				if(_mark == null) {
					_mark = new Sprite();
					_mark.graphics.clear();
					_mark.graphics.beginFill(0x2233AA,0.4);
					_mark.graphics.drawRoundRect(0,0,this.width,this.height,5,5);
					_mark.graphics.endFill();
					this.addChildAt(_mark,this.numChildren); 
				}
			}else {
				if(_mark != null) {
					if(this.contains(_mark)) {
						this.removeChild(_mark);
					}
					_mark = null;
				}
			}
		}
		public function get mark() : Boolean
		{
			return _mark != null;
		}
		private var _select : Boolean;
		public function set select(value : Boolean) : void
		{
			_select = value;
		}
		public function get select() : Boolean
		{
			return _select;
		}
		private var _cardType : String;
		private var _mouseDownCallBack : Function;
		private var _mouseUpCallBack : Function;
		private var _mouseOverCallBack : Function;
		private var _mouseOutCallBack : Function;
		
		public function Card(val : uint,cardType : String = 'b2',pw : Number = 90, ph : Number=119.85)				//75  100
		{
			super();
			_cardType = cardType;
			
			this.mouseChildren = false;
			this.tabChildren = false;
			this.tabEnabled = false;
			this._width = pw;
			this._height = ph;
			value = val;
		}
		public function Destroy() : void
		{
			UnListren();
			_cardType = null;
			if(_mark) _mark = null; 
			if(_darkMask)_mark = null;
			if(_dos)
			{
				if(this.contains(_dos)) { this.removeChild(_dos); }
				_dos = null
			}
		}
		public function RegisterListren(mouseDownCall : Function = null, mouseUpCall : Function = null, mouseOverCall : Function = null,mouseOutCall : Function = null) : Boolean
		{
			_mouseDownCallBack 	= mouseDownCall;
			if(_mouseDownCallBack != null) {
				this.addEventListener(MouseEvent.MOUSE_DOWN,OnMouseDownEvent);
			}
			_mouseUpCallBack 	= mouseUpCall;
			if(_mouseUpCallBack != null) {
				this.addEventListener(MouseEvent.MOUSE_UP,OnMouseUpEvent);
			}
			_mouseOverCallBack 	= mouseOverCall;
			if(_mouseOverCallBack != null) {
				this.addEventListener(MouseEvent.MOUSE_OVER,OnMouseOverEvent);
			}
			_mouseOutCallBack	= mouseOutCall;
			if(_mouseOutCallBack != null) {
				this.addEventListener(MouseEvent.MOUSE_OUT,OnMouseOutEvent);
			}
			return true;
		}
		public function UnListren() : Boolean
		{
			_mouseDownCallBack 	= null;
			_mouseUpCallBack 	= null;
			_mouseOverCallBack 	= null;
			_mouseOutCallBack	= null;
			if( this.hasEventListener(MouseEvent.MOUSE_DOWN) ) {
				this.removeEventListener(MouseEvent.MOUSE_DOWN,OnMouseDownEvent);
			}
			if( this.hasEventListener(MouseEvent.MOUSE_UP) ) {
				this.removeEventListener(MouseEvent.MOUSE_UP,OnMouseUpEvent);
			}
			if( this.hasEventListener(MouseEvent.MOUSE_OVER) ) {
				this.removeEventListener(MouseEvent.MOUSE_OVER,OnMouseOverEvent);
			}
			if( this.hasEventListener(MouseEvent.MOUSE_OUT) ) {
				this.addEventListener(MouseEvent.MOUSE_OUT,OnMouseOutEvent);
			}
			return true;
		}
		
		public function clone() : Card
		{
			var card : Card = new Card(value);
			return card;
		}
		protected function OnMouseDownEvent(event : MouseEvent) : void
		{
			if(_mouseDownCallBack != null) {
				_mouseDownCallBack(event);
			}
		}
		protected function OnMouseUpEvent(event : MouseEvent) : void
		{
			if(_mouseUpCallBack != null) {
				_mouseUpCallBack(event);
			}
		}
		protected function OnMouseOverEvent(event : MouseEvent) : void
		{
			if(_mouseOverCallBack != null) {
				_mouseOverCallBack(event);
			}
		}
		protected function OnMouseOutEvent(event : MouseEvent) : void
		{
			if(_mouseOutCallBack != null) {
				_mouseOutCallBack(event);
			}
		}
	}
}