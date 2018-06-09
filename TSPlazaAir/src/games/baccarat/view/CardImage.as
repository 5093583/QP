package games.baccarat.view
{
	import flash.display.DisplayObject;
	
	import gameAssets.card.YBCardEmbed;
	
	import mx.core.UIComponent;
	
	
	public class CardImage extends UIComponent
	{
		private var _cardDisplay : DisplayObject;
		private var _cardValue : int;
		public function CardImage()
		{
			super();
		}
		public function set source(value:DisplayObject):void
		{
			if(_cardDisplay!=null && this.contains(_cardDisplay)){
				this.removeChild(_cardDisplay);
				_cardDisplay = null;
			}
			_cardDisplay = value;
			this.addChild(_cardDisplay);
		}
		
		public function get source() : DisplayObject
		{
			return _cardDisplay;
		}
		public function set cardValue(value : int) :void
		{
			var cardList : DisplayObject = YBCardEmbed.GetCard(value,this.width,this.height);
			source = cardList;
		}
		public function get cardValue() : int
		{
			return _cardValue;
		}
	}
}