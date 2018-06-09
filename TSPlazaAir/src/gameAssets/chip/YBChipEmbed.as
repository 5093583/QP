package gameAssets.chip
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	public class YBChipEmbed
	{
		public function YBChipEmbed()
		{
		}
		[Embed(source = "gameAssets/chip/ybchipNew.swf",symbol = "chip001")]
		private static var chip001 : Class;
		[Embed(source = "gameAssets/chip/ybchipNew.swf",symbol = "chip002")]
		private static var chip002 : Class;
		[Embed(source = "gameAssets/chip/ybchipNew.swf",symbol = "chip005")]
		private static var chip005 : Class;
		[Embed(source = "gameAssets/chip/ybchipNew.swf",symbol = "chip01")]
		private static var chip01 : Class;
		[Embed(source = "gameAssets/chip/ybchipNew.swf",symbol = "chip02")]
		private static var chip02 : Class;
		[Embed(source = "gameAssets/chip/ybchipNew.swf",symbol = "chip05")]
		private static var chip05 : Class;
		[Embed(source = "gameAssets/chip/ybchipNew.swf",symbol = "chip1")]
		private static var chip1 : Class;
		[Embed(source = "gameAssets/chip/ybchipNew.swf",symbol = "chip2")]
		private static var chip2 : Class;
		[Embed(source = "gameAssets/chip/ybchipNew.swf",symbol = "chip5")]
		private static var chip5 : Class;
		[Embed(source = "gameAssets/chip/ybchipNew.swf",symbol = "chip10")]
		private static var chip10 : Class;
		[Embed(source = "gameAssets/chip/ybchipNew.swf",symbol = "chip20")]
		private static var chip20 : Class;
		[Embed(source = "gameAssets/chip/ybchipNew.swf",symbol = "chip50")]
		private static var chip50 : Class;
		[Embed(source = "gameAssets/chip/ybchipNew.swf",symbol = "chip100")]
		private static var chip100 : Class;
		[Embed(source = "gameAssets/chip/ybchipNew.swf",symbol = "chip200")]
		private static var chip200 : Class;
		[Embed(source = "gameAssets/chip/ybchipNew.swf",symbol = "chip500")]
		private static var chip500 : Class;
		[Embed(source = "gameAssets/chip/ybchipNew.swf",symbol = "chip1000")]
		private static var chip1000 : Class;
		[Embed(source = "gameAssets/chip/ybchipNew.swf",symbol = "chip2000")]
		private static var chip2000 : Class;
		[Embed(source = "gameAssets/chip/ybchipNew.swf",symbol = "chip5000")]
		private static var chip5000 : Class;
		[Embed(source = "gameAssets/chip/ybchipNew.swf",symbol = "chip65535")]
		private static var chip65535 : Class;
		
		private static var _arrs : Array;
		private static var _keys : Array;
		
		private static var _bitmapArrs:Array;
		
		private static function onInit() : void
		{
			_arrs = [chip001,chip002,chip005,chip01,chip02,chip05,chip1, chip2, chip5, chip10, chip20, chip50, chip100,chip200,chip500,
				chip1000, chip2000,chip5000];
			_keys = [0.01,0.02,0.05,0.1,0.2,0.5,1,2,5,10,20,50,100,200,500,1000,2000,5000];
			
			createBitmapDataArrs();
		}
		
		private static function createBitmapDataArrs():void
		{
			_bitmapArrs = new Array(_arrs.length);
			
			var ds:DisplayObject;
			var bit:BitmapData;
			for(var i:int=0, len:int=_arrs.length; i<len; i++)
			{
				ds = new _arrs[i] as DisplayObject;
				bit = new BitmapData(ds.width, ds.height, true, 0);
				bit.draw(ds, new Matrix(), new ColorTransform(), null, new Rectangle(0, 0, ds.width, ds.height) );
				
				_bitmapArrs[i] = bit;
			}
		}
		
		public static function GetClip(value : Number) : DisplayObject
		{
			if(_arrs == null)	onInit();
			var index:int = _keys.indexOf(value);
			return new Bitmap( _bitmapArrs[index] );
//			return new _arrs[index];
		}
		
		public static function GetChips(value : Number) : Array
		{
			if(_arrs == null)	onInit();
			var arrs : Array = new Array();
			if(value <= 0) 		return arrs;
			var pn : Number = 0;
			var len : int = _keys.length;
			for(var i : int = len-1; i>=0; i--)
			{
				pn = int(value/_keys[i]);
				
				if(value<1 && _keys[i]<1)
					pn = int( (value*10) / (_keys[i]*10) );
				
				if(pn<1) continue;
				value -= _keys[i]*pn;
				if(value < 1)
					value = parseFloat( value.toFixed(1) );
				
				for(var j : int = 0;j<pn;j++)
				{
					arrs.push( GetClip(_keys[i]) );
				}
				if(value<0.1&&value>0.09){ value = 0.1; }
				if(value <= 0.09) break;
			}
			
			return arrs;
		}
		
		
	}
}