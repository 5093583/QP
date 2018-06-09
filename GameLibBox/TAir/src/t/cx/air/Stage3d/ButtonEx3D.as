package t.cx.air.Stage3d
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	[Event(name="clickex", type="flash.events.MouseEvent")]
	public class ButtonEx3D extends MovieClip
	{
		public static const CLICKEX : String= 'clickex';
		
		private var _enable : Boolean;
		public function set enable(val : Boolean) : void
		{
			if(this.parent == null) return;
			_enable = val;
			onRegist(_enable);
		}
		public function get enable() : Boolean
		{
			return _enable;
		}
		public function ButtonEx3D()
		{
			super();
			if(stage)
			{
				onInit();
			}else {
				this.addEventListener(Event.ADDED_TO_STAGE,onInit);
			}
		}
		private function onInit(e : Event = null) : void
		{
			if(e != null) { this.removeEventListener(Event.ADDED_TO_STAGE,onInit); }
			this.gotoAndStop(1);
		}
		private function onRegist(bReg : Boolean) : void
		{
			if(!bReg){
				stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			}else {
				stage.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			}
			if(!bReg){
				stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			} else { 
				stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			}	
			this.gotoAndStop(1);
		}
		private function onMouseMove(e : MouseEvent) : void
		{
			var rect : Rectangle = this.getRect(this.parent);
			if( rect.containsPoint(new Point(this.parent.mouseX,this.parent.mouseY)) )
			{
				this.gotoAndStop(2);
			}else {
				this.gotoAndStop(1);
			}
		}
		private function onMouseUp(e : MouseEvent) : void
		{
			var rect : Rectangle = this.getRect(this.parent);
			if( rect.containsPoint(new Point(this.parent.mouseX,this.parent.mouseY)) )
			{
				this.dispatchEvent(new MouseEvent('clickex'));
			}
		}
		public function Destroy() : void
		{
			onRegist(false);
			var dos : DisplayObject;
			while(this.numChildren>0)
			{
				dos = this.removeChildAt(0);
				dos = null;
			}
		}
	}
}