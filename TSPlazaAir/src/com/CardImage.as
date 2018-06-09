package com
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import gameAssets.card.YBCardEmbed;
	
	import mx.core.UIComponent;
	
	public class CardImage extends UIComponent
	{
		private var _cardDisplay : DisplayObject;
		private var _cardValue : int;
		private var _value : int;
		
//		public function CardImage(w:uint=78, h:uint=107)
		public function CardImage(w:uint=82, h:uint=112)
		{
			super();
			
			sizePoint = new Point(w, h)
		}
		
		private var _sizePoint:Point
		public function get sizePoint():Point
		{
			return _sizePoint;
		}
		
		public function set sizePoint(value:Point):void
		{
			_sizePoint = value;
			
			this.width = value.x;
			this.height= value.y;
		}
		
		
		public function set source(value:DisplayObject):void
		{
			if(_cardDisplay!=null && this.contains(_cardDisplay)){
				this.removeChild(_cardDisplay);
				_cardDisplay = null;
			}
			_cardDisplay = value;
//			this.addChild(_cardDisplay);
			this.addChildAt(_cardDisplay, 0);
			this.invalidateSize();
			this.invalidateDisplayList();
			this.invalidateLayoutDirection();
			
//			this.validateDisplayList();
		}
		
		
		public function get source() : DisplayObject
		{
			return _cardDisplay;
		}
		public function set value(value : int) :void
		{
			_value = value;
			cardValue = _value;
		}
		public function get value() : int
		{
			return _value;
		}
		public function set cardValue(value : int) :void
		{
			var cardList : DisplayObject = YBCardEmbed.GetCard(value,this.width,this.height,"b2");
			source = cardList;
			_cardValue = value;
		}
		public function get cardValue() : int
		{
			return _cardValue;
		}
		
		
		private var sp:Sprite;
		public function addFilter(add:Boolean = true):void
		{
			drawBackground();
			sp.visible = add;
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
			sp.graphics.beginFill(0xffffff, .6);
			sp.graphics.drawRect(0, 0, width, height);
			sp.graphics.endFill();
//			this.addChild(sp);
			this.addChildAt(sp, 1);
		}
		
		
		public function removeFilter():void
		{
			if(!sp)	return;
			
			if( this.contains(sp) )
			{
				this.removeChild(sp);
				sp = null;
			}
		}
		
		
	}
}