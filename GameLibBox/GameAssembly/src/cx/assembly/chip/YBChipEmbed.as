package cx.assembly.chip
{
	import flash.display.DisplayObject;
	
	import t.cx.air.TScore;

	public class YBChipEmbed
	{
		public function YBChipEmbed()
		{
		}
		
//		[Embed(source = "ybchip.swf",symbol = "chip0.1")]
//		private static var chip0_1 : Class;
//		[Embed(source = "ybchip.swf",symbol = "chip0.2")]
//		private static var chip0_2 : Class;
		
		[Embed(source = "ybchip.swf",symbol = "chip1")]
		private static var chip1 : Class;
		[Embed(source = "ybchip.swf",symbol = "chip2")]
		private static var chip2 : Class;
		[Embed(source = "ybchip.swf",symbol = "chip5")]
		private static var chip5 : Class;
		[Embed(source = "ybchip.swf",symbol = "chip10")]
		private static var chip10 : Class;
		[Embed(source = "ybchip.swf",symbol = "chip50")]
		private static var chip50 : Class;
		[Embed(source = "ybchip.swf",symbol = "chip100")]
		private static var chip100 : Class;
		[Embed(source = "ybchip.swf",symbol = "chip1000")]
		private static var chip1000 : Class;
		
		
		private static var _arrs : Array;
		private static var _keys : Array;
		
		private static function onInit() : void
		{
//			_arrs = new Array();
//			_arrs.push(clipRed);
//			_arrs.push(clipYellow);
//			_arrs.push(clipGreen);
//			_arrs.push(clipBlue);
//			_arrs.push(clipBlack);
//			_keys = new Array(	50000000,20000000,10000000,5000000,2000000,1000000,500000,200000,100000,50000,20000,10000,
//				5000,2000,1000,500,200,100,50,20,10,5,2,1,0.5,0.2,0.1,0.05,0.02,0.01,0.005,0.002,0.001
//			);
			
			_arrs = [chip1, chip2, chip5, chip10, chip50, chip100, chip1000];
			_keys = [1, 2, 5, 10, 50, 100, 1000];
		}
		public static function GetClip(value : int) : DisplayObject
		{
			if(_arrs == null)	onInit();
			var index:int = _keys.indexOf(value);
			return new _arrs[index];
		}
		
		public static function GetChips(value : int) : Array
		{
			if(_arrs == null)	onInit();
			var arrs : Array = new Array();
			if(value <= 0) 		return arrs;
			var pn : int = 0;
			var len : int = _keys.length;
			for(var i : int = len-1; i>=0; i--)
			{
				pn = int(value/_keys[i]);
				if(pn<1)	continue;
				value = int(value%_keys[i]);
				for(var j : uint = 0;j<pn;j++)
				{
					arrs.push( GetClip(_keys[i]) );
				}
				if(value <= 0.009)break;
			}
			return arrs;
		}
		
		
	}
}