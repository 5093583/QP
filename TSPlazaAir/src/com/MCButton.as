package com
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	
	public class MCButton extends UIComponent
	{
		private var sp:Sprite;
		
		public function MCButton(c:Class=null)
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
		
		private var _selected:Boolean;
		public function set selected(value:Boolean):void
		{
			_selected = value;
			if(_selected)
			{
				removeMcEvent();
				targetMc.gotoAndStop(4);
			}
			else
			{
				this.buttonMode = true;
				_targetMc.gotoAndStop(1);
				
				_targetMc.addEventListener(MouseEvent.MOUSE_OVER, OnMouseOver);
			}
		}
		
		
		public function setEnable(enable:Boolean):void
		{
			drawBackground();
			if(enable)
				sp.visible = false;
			else
				sp.visible = true;
//				drawBackground();
		}
		
		private function drawBackground():void
		{
			if(sp)
			{
				sp.visible = true;
				return;
			}
			
			sp = new Sprite;
			sp.graphics.clear();
			sp.graphics.beginFill(0xcccccc, .6);
			sp.graphics.drawRect(0, 0, getRect(_targetMc).width, getRect(_targetMc).height);
			sp.graphics.endFill();
			this.addChild(sp);
		}
		
		public function revert():void
		{
			_targetMc.gotoAndStop(1);
		}
		
		private function init():void
		{
			_targetMc.mouseChildren = false;
			_targetMc.tabChildren = false;
			_targetMc.tabEnabled = false;
			this.buttonMode = true;
			_targetMc.gotoAndStop(1);
			
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
			_targetMc.gotoAndStop(1); 
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
		
		
	}
}