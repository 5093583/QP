package t.cx.air.utils
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	public class MovieHelper
	{
		public function MovieHelper()
		{
		}
		
		public static function _stop(mc : *) : void
		{
			
			if(mc.hasOwnProperty('gotoAndStop')) {
				mc.gotoAndStop(1);
			}
			
			for(var i : uint;i<mc.numChildren;i++)
			{
				var child : MovieClip = mc.getChildAt(i) as MovieClip;
				if(child) {
					child.gotoAndStop(1);
				}
			}
		}
	}
}