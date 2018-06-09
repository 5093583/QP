package cx.assembly.chip
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;
	
	import t.cx.air.TScore;
	
	public class ChipEmbed
	{
		[Embed(source = "chip.swf",symbol = "RedChip")]
		private static var clipRed : Class;
		[Embed(source = "chip.swf",symbol = "YellowChip")]
		private static var clipYellow : Class;
		[Embed(source = "chip.swf",symbol = "GreenChip")]
		private static var clipGreen : Class;
		[Embed(source = "chip.swf",symbol = "BlueChip")]
		private static var clipBlue : Class;
		[Embed(source = "chip.swf",symbol = "BlackChip")]
		private static var clipBlack : Class;
		
		private static var _arrs : Array;
		private static var _keys : Array;
		public function ChipEmbed()
		{
		}
		private static function onInit() : void
		{
			_arrs = new Array();
			_arrs.push(clipRed);
			_arrs.push(clipYellow);
			_arrs.push(clipGreen);
			_arrs.push(clipBlue);
			_arrs.push(clipBlack);
			_keys = new Array(	50000000,20000000,10000000,5000000,2000000,1000000,500000,200000,100000,50000,20000,10000,
								5000,2000,1000,500,200,100,50,20,10,5,2,1,0.5,0.2,0.1,0.05,0.02,0.01,0.005,0.002,0.001
							 );
		}
		public static function GetClip(value : Number,w:Number=36,h:Number=27) : DisplayObject
		{
			if(_arrs == null)onInit();
			var clip : DisplayObject;
			var c : Class = _arrs[int(Math.random() * 5)];
			clip = new c();
			clip['valtxt'].text = value;
			clip.width 	= w;
			clip.height = h;
			clip.name = value.toString();
			return clip;
		}
		
		public static function GetChips(value : Number ,w:Number = 30, h:Number = 23,cell : Number = 0.1,max : Number = 50000) : Array
		{
			if(_arrs == null)onInit();
			var arrs : Array = new Array();
			value = TScore.toFloatEx(value);
			if(value <= 0) return arrs;
			var pn : int = 0;
			var len : int = _keys.lastIndexOf(cell)+1;
			for(var i : int = _keys.indexOf(max); i<len; i++)
			{
				pn = value/_keys[i];
				if(pn<1)
				{
					if( (_keys[i]-value) > 0.009) { continue; }
					value = _keys[i];
					pn = 1;
				}
				value = (value%_keys[i]);
				for(var j : uint = 0;j<pn;j++)
				{
					arrs.push( GetClip(_keys[i],w,h) );
				}
				if(value <= 0.009)break;
			}
			return arrs;
		}
		
	}
}