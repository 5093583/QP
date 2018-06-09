package com
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;

	public class GameMCButton extends UIComponent
	{
		public function GameMCButton(c:Class=null)
		{
			if(c)
				targetClass = c;
		}
		
		
		private var _targetClass:Class;
		public function get targetClass():Class
		{
			return _targetClass;
		}
		
		public function set targetClass(value:Class):void
		{
			targetMc = new value() as MovieClip;
		}
		
		
		private var _targetMc:MovieClip;
		public function get targetMc():MovieClip
		{
			return _targetMc;
		}
		public function set targetMc(mc:MovieClip):void
		{
			if(_targetMc && _targetMc.parent)
			{
				this.removeChild(_targetMc);
				_targetMc = null;
			}
			_targetMc = mc;
			this.addChild(_targetMc);
			init();
		}
		
		public function set showValue(str:String):void
		{
			if(_targetMc['num'])
				_targetMc['num'].text = str;
		}
		
		
		
		
		private function init():void
		{
			_targetMc.mouseChildren = false;
			_targetMc.tabChildren = false;
			_targetMc.tabEnabled = false;
			this.buttonMode = true;
			this.width = _targetMc.width;
			this.height= _targetMc.height;
			_targetMc.gotoAndStop(1);
			
			if(_targetMc.totalFrames > 1)
				_targetMc.addEventListener(MouseEvent.MOUSE_OVER, OnMouseOver);
		}
		
		protected function OnMouseOver(event : MouseEvent) : void
		{
			_targetMc.gotoAndStop(2);
			_targetMc.addEventListener(MouseEvent.MOUSE_OUT,OnMouseOut);
			_targetMc.addEventListener(MouseEvent.MOUSE_DOWN,OnMouseDown);
			_targetMc.addEventListener(MouseEvent.MOUSE_UP,OnMouseUp);
		}
		
		protected function OnMouseOut(event : MouseEvent) : void
		{
			_targetMc.gotoAndStop(1); 
			_targetMc.removeEventListener(MouseEvent.MOUSE_OUT,OnMouseOut);
			_targetMc.removeEventListener(MouseEvent.MOUSE_DOWN,OnMouseDown);
			_targetMc.removeEventListener(MouseEvent.MOUSE_UP,OnMouseUp);
		}
		protected function OnMouseUp(event : MouseEvent) : void
		{
			_targetMc.gotoAndStop(2); 
		}
		
		protected function OnMouseDown(event : MouseEvent) : void
		{
			_targetMc.gotoAndStop(3);
		}
		
		public function removeMcEvent():void
		{
			this.buttonMode = false;
			_targetMc.removeEventListener(MouseEvent.MOUSE_OVER, OnMouseOver);
			_targetMc.removeEventListener(MouseEvent.MOUSE_OUT,OnMouseOut);
			_targetMc.removeEventListener(MouseEvent.MOUSE_DOWN,OnMouseDown);
			_targetMc.removeEventListener(MouseEvent.MOUSE_UP,OnMouseUp);
		}
		
		
		
		override public function set enabled(value:Boolean):void
		{
			super.enabled = value;
			if(_targetMc == null)	return;
			if(value)
			{
				this.mouseEnabled = true;
				this.mouseChildren = true;
				init();
			}
			else
			{
				this.mouseEnabled = false;
				this.mouseChildren = false;
				removeMcEvent();
				_targetMc.gotoAndStop(4);
			}
		}
		
		
	}
}