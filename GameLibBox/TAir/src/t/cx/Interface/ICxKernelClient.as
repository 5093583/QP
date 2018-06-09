package t.cx.Interface
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.geom.Point;

	public interface ICxKernelClient
	{
		function CxGetWH() : Point;								//获取子影片宽高
		/**
		 * 获取显示对象
		 * */
		function CxGetDisplayObject(type : String = '',bShow : Boolean = false) : DisplayObject;
	
		/**
		 * 获取显示方法
		 * @return _game2d _game3d _main2d _pop2dwindow
		 * */
		function CxShowType(parent : *=null) : String;
		/**
		 * 获取窗口Icon
		 * */
		function CxIcon(size : uint = 128) : Array;
		/**
		 * 获取窗口标题
		 * */
		function CxWindowTitle() : String;
		/**
		 * 销毁
		 * */
		function CxClientDestroy(cbDestroyCode : uint) : Boolean;
		/**
		 * 显示
		 * */
		function CXShowed(bExitCode : uint) : void;
	}
}