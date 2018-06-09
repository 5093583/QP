package cx.gamebase.view.skins
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Column extends Sprite
	{
		private var _RectVec : Vector.<Rectangle>
		private var _valShape : Vector.<ColumnUint>;
		private var _selIndex : int;
		
		private var _value : int;
		public function set value(val : int) : void
		{
			if(val >=0)
			{
				_value = val;
				var shape : ColumnUint;
				var j : int = 0;
				if(val > 0)
				{
					for( j = val;j<10;j++)
					{
						shape = _valShape[j];
						if(shape && shape.selected) {  shape.selected = false;  }
					}
					while(val>=0)
					{
						shape = _valShape[val];
						if(shape && !shape.selected) {  
							shape.selected = true;  
						}
						val--;
					}
				}else {
					for( j = val+1;j<10;j++)
					{
						shape = _valShape[j];
						if(!shape.selected) { break; 	}
						shape.selected = false;
					}
					if(j==( val+1 ))
					{
						shape = _valShape[val];
						shape.selected = !shape.selected;
						_value = shape.selected?0:-1;
					}
				}
			}
		}
		public function get value() : int
		{
			return _value;
		}
		private var _callBack : Function;
		public function Column(pCall : Function)
		{
			super();
			_callBack =pCall;
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
			_selIndex = -1;
			_valShape = new Vector.<ColumnUint>(10);
			_RectVec  = new Vector.<Rectangle>(10);
			for(var i : uint = 0;i<10;i++)
			{
				var columnuint : ColumnUint = new ColumnUint( 7, (9 + i*3) );
				columnuint.x = i * 12;
				columnuint.y = 27 - i * 3;
				this.addChild(columnuint);
				_RectVec[i] =  columnuint.getRect(this);
				_valShape[i] = columnuint;
			}
			stage.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
		}
		private function onMouseMove(e : MouseEvent) : void
		{
			var point : Point = new Point( this.mouseX,this.mouseY );
			var i : int = 0;
			var shape : ColumnUint;
			_selIndex = -1;
			for each(var rect : Rectangle in _RectVec )
			{
				if( rect.containsPoint(point) ) {  
					_selIndex = i;
					break; 
				}
				i++;
			}
			i =i==10?-1:i;
			for(var j : int = (i==-1?0:i);j<10;j++)
			{
				shape = _valShape[j];
				if(shape && !shape.selected) {  shape.select = false;  }
			}
			while(i>=0)
			{
				shape = _valShape[i];
				if(shape && !shape.selected) {  shape.select = true;  }
				i--;
			}
		}
		
		private function onMouseUp(e : MouseEvent) : void
		{
			value = _selIndex;
			if(_callBack != null) { _callBack( (_value+1) / 10 ); }
		}
		public function Destroy() : void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			_RectVec = null;
			_valShape = null;
			_callBack = null;
			var dos : DisplayObject;
			while(this.numChildren>0)
			{
				dos = this.removeChildAt(0);
				dos = null;
			}
		}
	}
}