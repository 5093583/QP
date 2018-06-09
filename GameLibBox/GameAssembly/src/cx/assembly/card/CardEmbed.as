package cx.assembly.card
{
	import flash.display.DisplayObject;
	public class CardEmbed
	{
		//背面
		[Embed(source = "card.swf",symbol = "card0_b2")]
		public var card0b2 : Class;
		[Embed(source = "card.swf",symbol = "card0_hlddz")]
		public var card0_hlddz : Class;
		
		//方块 A - K
		[Embed(source = "card.swf",symbol = "card1")]
		public var card1 : Class;
		[Embed(source = "card.swf",symbol = "card2")]
		public var card2 : Class;
		[Embed(source = "card.swf",symbol = "card3")]
		public var card3 : Class;
		[Embed(source = "card.swf",symbol = "card4")]
		public var card4 : Class;
		[Embed(source = "card.swf",symbol = "card5")]
		public var card5 : Class;
		[Embed(source = "card.swf",symbol = "card6")]
		public var card6 : Class;
		[Embed(source = "card.swf",symbol = "card7")]
		public var card7 : Class;
		[Embed(source = "card.swf",symbol = "card8")]
		public var card8 : Class;
		[Embed(source = "card.swf",symbol = "card9")]
		public var card9 : Class;
		[Embed(source = "card.swf",symbol = "card10")]
		public var card10 : Class;
		[Embed(source = "card.swf",symbol = "card11")]
		public var card11 : Class;
		[Embed(source = "card.swf",symbol = "card12")]
		public var card12 : Class;
		[Embed(source = "card.swf",symbol = "card13")]
		public var card13 : Class;
		
		//梅花 A - K
		[Embed(source = "card.swf",symbol = "card17")]
		public var card17 : Class;
		[Embed(source = "card.swf",symbol = "card18")]
		public var card18 : Class;
		[Embed(source = "card.swf",symbol = "card19")]
		public var card19 : Class;
		[Embed(source = "card.swf",symbol = "card20")]
		public var card20 : Class;
		[Embed(source = "card.swf",symbol = "card21")]
		public var card21 : Class;
		[Embed(source = "card.swf",symbol = "card22")]
		public var card22 : Class;
		[Embed(source = "card.swf",symbol = "card23")]
		public var card23 : Class;
		[Embed(source = "card.swf",symbol = "card24")]
		public var card24 : Class;
		[Embed(source = "card.swf",symbol = "card25")]
		public var card25 : Class;
		[Embed(source = "card.swf",symbol = "card26")]
		public var card26 : Class;
		[Embed(source = "card.swf",symbol = "card27")]
		public var card27 : Class;
		[Embed(source = "card.swf",symbol = "card28")]
		public var card28 : Class;
		[Embed(source = "card.swf",symbol = "card29")]
		public var card29 : Class;
		
		//红桃 A - K
		[Embed(source = "card.swf",symbol = "card33")]
		public var card33 : Class;
		[Embed(source = "card.swf",symbol = "card34")]
		public var card34 : Class;
		[Embed(source = "card.swf",symbol = "card35")]
		public var card35 : Class;
		[Embed(source = "card.swf",symbol = "card36")]
		public var card36 : Class;
		[Embed(source = "card.swf",symbol = "card37")]
		public var card37 : Class;
		[Embed(source = "card.swf",symbol = "card38")]
		public var card38 : Class;
		[Embed(source = "card.swf",symbol = "card39")]
		public var card39 : Class;
		[Embed(source = "card.swf",symbol = "card40")]
		public var card40 : Class;
		[Embed(source = "card.swf",symbol = "card41")]
		public var card41 : Class;
		[Embed(source = "card.swf",symbol = "card42")]
		public var card42 : Class;
		[Embed(source = "card.swf",symbol = "card43")]
		public var card43 : Class;
		[Embed(source = "card.swf",symbol = "card44")]
		public var card44 : Class;
		[Embed(source = "card.swf",symbol = "card45")]
		public var card45 : Class;
		
		//黑桃 A - K
		[Embed(source = "card.swf",symbol = "card49")]
		public var card49 : Class;
		[Embed(source = "card.swf",symbol = "card50")]
		public var card50 : Class;
		[Embed(source = "card.swf",symbol = "card51")]
		public var card51 : Class;
		[Embed(source = "card.swf",symbol = "card52")]
		public var card52 : Class;
		[Embed(source = "card.swf",symbol = "card53")]
		public var card53 : Class;
		[Embed(source = "card.swf",symbol = "card54")]
		public var card54 : Class;
		[Embed(source = "card.swf",symbol = "card55")]
		public var card55 : Class;
		[Embed(source = "card.swf",symbol = "card56")]
		public var card56 : Class;
		[Embed(source = "card.swf",symbol = "card57")]
		public var card57 : Class;
		[Embed(source = "card.swf",symbol = "card58")]
		public var card58 : Class;
		[Embed(source = "card.swf",symbol = "card59")]
		public var card59 : Class;
		[Embed(source = "card.swf",symbol = "card60")]
		public var card60 : Class;
		[Embed(source = "card.swf",symbol = "card61")]
		public var card61 : Class;
		
		//王
		[Embed(source = "card.swf",symbol = "card78")]
		public var card78 : Class;
		[Embed(source = "card.swf",symbol = "card79")]
		public var card79 : Class;
		
		[Embed(source = "card.swf",symbol = "card0_hui")]
		public var card100 : Class;
		[Embed(source = "card.swf",symbol = "card0_lie")]
		public var card101 : Class;
		
		private static var _cardEmbed : CardEmbed;
		public function CardEmbed()
		{
		}
		private function create(value : uint,type : String='') : DisplayObject
		{
			var tn : String = value == 0?('card0' + type) : ('card' + value);
			if(!this.hasOwnProperty(tn)) { tn = 'card0' + type; }
			return new this[tn]();
		}
		
		public static function GetCard(value : uint,w : uint = 75,h : uint = 100,cardType : String = 'b') : DisplayObject
		{
			if(_cardEmbed == null)_cardEmbed= new CardEmbed();
			var card : DisplayObject =  _cardEmbed.create(value,cardType);
			card.width = w;
			card.height = h;
			card.name = value.toString();
			return card;
		}
	}
}