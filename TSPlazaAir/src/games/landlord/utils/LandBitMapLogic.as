package games.landlord.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;

	public class LandBitMapLogic
	{
		protected static var _instance : LandBitMapLogic;
		public static function GetInstance() : LandBitMapLogic
		{
			return _instance == null ? _instance = new LandBitMapLogic() : _instance;
		}
		public function LandBitMapLogic()
		{
			
		}
		/**
		 * 获取BitMapData数组
		 * @param imageClassName:String 图片链接类名
		 * @param w:Number 序列帧单图宽度
		 * @param h:Number 序列帧单图高度
		 * @param actionCount:uint 序列帧总帧数
		 * @param cutDirection:uint 切图方向(0横向/1纵向)
		 **/
		public function CutThePhoto(imageClassName:String, w:Number, h:Number, actionCount:uint, cutDirection:uint = 0,row:uint = 5):Vector.<BitmapData>
		{
			var result:Vector.<BitmapData> = new Vector.<BitmapData>();
			var c:Class = ApplicationDomain.currentDomain.getDefinition(imageClassName) as Class;
			var bitData:BitmapData = new c() as BitmapData;
			var rectangle:Rectangle = new Rectangle();
			var pt:Point = new Point();
			var num : int = 0;
			while (actionCount--)
			{
				switch(cutDirection)
				{
					case 0:
					{
						rectangle.x = 0;
						rectangle.y += rectangle.height;
						break;
					}
					case 1:
					{
						rectangle.x += rectangle.width;
						rectangle.y = 0;
						break;
					}
					case 2:
					{
						rectangle.x = Math.floor(num%row) * w;
						rectangle.y = Math.floor(num/row) * h;
						num ++ ;
						break;
					}
				}
				rectangle.width = w;
				rectangle.height = h;
				var bmd:BitmapData = new BitmapData(w,h);
				bmd.copyPixels(bitData, rectangle, pt);
				result.push(bmd);
			}
			return result;
		}
	}
}