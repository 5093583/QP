package cx.gamebase.view.compant
{
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class ScorllCompant extends Sprite
	{
		private var _rect : Rectangle;
		private var _value : Number;
		public function set value(val : Number) : void
		{
			if(val == _value) return;
			_value = val;
			theBg.width = val * this.width;
			theThum.x = _value * this.width;
			if(_callBack != null) { _callBack(val); }
		}
		private var _callBack : Function;
		public function ScorllCompant()
		{
			super();
			onSetEnable(true);
			_rect = new Rectangle(0,0,this.width - (theThum.width * 0.5),14);
		}
		public function onSetEnable(bEnable : Boolean,defvalue:Number=0.5, onChangeCallback : Function=null) : void
		{
			if(bEnable)
			{
				theThum.addEventListener(MouseEvent.MOUSE_DOWN,onMouseEventDown);
				theThum.x = defvalue * this.width;
				_value = defvalue;
				theBg.width = _value * this.width;
				_callBack = onChangeCallback;
			}else {
				theThum.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseEventDown);
			}
		}
		private function onMouseEventDown(e : MouseEvent) : void
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMoveEvent);
			stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUpOut);
		}
		private function onMouseMoveEvent(e : MouseEvent) : void
		{
			theThum.x = this.mouseX - theThum.width * 0.5;
			theThum.x = theThum.x>=_rect.width?_rect.width:(theThum.x<=0?0:theThum.x);
			value = theThum.x/(_rect.width);
		}
		private function onMouseUpOut(e : MouseEvent) : void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMoveEvent);
			stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseUpOut);
		}
		public function get theThum() : Sprite
		{
			return this['ScorllBtnMC'];
		}
		public function get theBg() : Sprite
		{
			return this['ScorllBgMC'];
		}
		
		public function Destroy() : void
		{
			onSetEnable(false);
			this['ScorllBgMC'] = null;
			this['ScorllBtnMC'] = null;
			_callBack = null;
			_rect = null;
		}
	}
}