package cx.assembly.head
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filesystem.File;
	
	import t.cx.air.file.TPather;
	
	public class HeadEmbed
	{
//		[Embed(source = "./1.png")]
//		public static var h1 : Class;
//		[Embed(source = "./2.png")]
//		public static var h2 : Class;
//		[Embed(source = "./3.png")]
//		public static var h3 : Class;
//		[Embed(source = "./4.png")]
//		public static var h4 : Class;
//		[Embed(source = "./5.png")]
//		public static var h5 : Class;
//		[Embed(source = "./6.png")]
//		public static var h6 : Class;
//		[Embed(source = "./7.png")]
//		public static var h7 : Class;
//		[Embed(source = "./8.png")]
//		public static var h8 : Class;
//		[Embed(source = "./9.png")]
//		public static var h9 : Class;
//		[Embed(source = "./10.png")]
//		public static var h10 : Class;
		
		public function HeadEmbed()
		{
		}
		private static var _headEmbed : Vector.<Bitmap>;
		private static var _localHead :Boolean=false;
		public static function EmbedHead(index : uint = 0) : Bitmap
		{
			
//			trace('EmbedHead',index,_localHead);
//			if(_localHead) {
//				index = index<1?1:index;
//				index = index>10?10:index;
//				var c : Class = HeadEmbed['h' + index];
//				var bitmap : Bitmap = new c();
//				bitmap.smoothing = true;
//				return bitmap;
//			}else { 
				if(_headEmbed == null)
				{
					_headEmbed= new Vector.<Bitmap>();
					
					for(var i : uint = 1;i<11;i++)
					{
						var bitdata :BitmapData = TPather._readFile( "data\\icon\\h_" + i + ".cxp" ,"png") as BitmapData;
						
						var tempFile : File = new File(TPather._fullPath( "data\\icon\\h_" + i + ".cxp" ));
						if( bitdata != null ) {
							var nBitmap :Bitmap = new Bitmap(bitdata);
							_headEmbed.push(nBitmap);
						}
					}
				}
				if(_headEmbed.length==0) {
					var defaultBit : BitmapData = new BitmapData(32,32,true,0x898989);
					_headEmbed.push(new Bitmap(defaultBit));
				}
				index = index >= _headEmbed.length?0:index;
				var resultBitmap : Bitmap = new Bitmap(_headEmbed[index].bitmapData.clone(),"auto",true);
				return resultBitmap;
//			}
//			
		}
	}
}