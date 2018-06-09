/**====================================================================================
 * 窗口居中函数
 * @author t&p
 * @date 2013/5/22
 * ====================================================================================*/
package t.cx.air
{
	import flash.display.DisplayObject;
	import flash.display.NativeWindow;
	import flash.display.Screen;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	public class TCenterPostion
	{
		public function TCenterPostion()
		{
		}
		/**
		 * 依据屏幕像素，将窗口居中显示
		 * */
		public static function _CenterWindow(window : NativeWindow) : void
		{
			var screenWidth 	: Number = Screen.mainScreen.visibleBounds.width;
			var screenHeight	: Number =Screen.mainScreen.visibleBounds.height;
			window.x = (screenWidth-window.width) * 0.5;
			window.y = (screenHeight - window.height) *0.5;
		}
	}
}