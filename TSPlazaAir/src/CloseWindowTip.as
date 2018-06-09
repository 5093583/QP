package
{
	import base.SkinClass;
	
	import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.Screen;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class CloseWindowTip extends Sprite
	{
		private var newWindow : NativeWindow;	
		
		private var txt:TextField;
		
		private var btn1:SimpleButton;
		private var btn2:SimpleButton;
		
		
		private static var _instance:CloseWindowTip;
		
		public static function getInstance():CloseWindowTip
		{
			if(_instance == null)	_instance = new CloseWindowTip;
			return _instance;
		}
		
		
		public function CloseWindowTip()
		{
			super();
			
			
			createChildren();
		}
		
		
		protected function createChildren():void
		{
			txt 		= new TextField;
			txt.x		= 10;
			txt.y		= 40;
			txt.width	= 180;
			txt.text	= '窗口即将关闭, 确定要退出游戏 ?';
			this.addChild(txt);
				
			btn1		= new SkinClass.exit_yes() as SimpleButton;
			btn1.x		= 30;
			btn1.y		= 90;
			this.addChild(btn1);
			
			btn2		= new SkinClass.exit_no() as SimpleButton;
			btn2.x		= 130;
			btn2.y		= 90;
			this.addChild(btn2);
			
			
			btn1.addEventListener(MouseEvent.CLICK, btn1_clickHandler);
			btn2.addEventListener(MouseEvent.CLICK, btn2_clickHandler);
		}
		
		private function btn1_clickHandler(e:MouseEvent):void
		{
			NativeApplication.nativeApplication.exit();
		}
		
		private function btn2_clickHandler(e:MouseEvent):void
		{
			newWindow.visible = false;
		}
		
		
		public function showCloseWindow():void
		{
//			if(newWindow == null) 	createNewNativeWindow();
//			
//			newWindow.visible = true;
			
			
			createNewNativeWindow();
		}
		
		private function createNewNativeWindow():void
		{
			var options:NativeWindowInitOptions = new NativeWindowInitOptions;
			options.minimizable = false;
			options.maximizable = false;
			options.resizable 	= false;
			newWindow = new NativeWindow(options);
			newWindow.stage.align = StageAlign.TOP_LEFT;
			newWindow.stage.scaleMode = StageScaleMode.NO_SCALE;
			newWindow.width = 240;
			newWindow.height = 160;
			//newWindow.maxSize = new Point(240, 160);
			newWindow.title = "畅璇棋牌";
			newWindow.visible = true;
			//newWindow.alwaysInFront = true;
			newWindow.orderToFront();
			
			var screenWidth 	: Number = Screen.mainScreen.visibleBounds.width;
			var screenHeight	: Number =Screen.mainScreen.visibleBounds.height;
			newWindow.x = (screenWidth-newWindow.width) * 0.5;
			newWindow.y = (screenHeight - newWindow.height) *0.5;
			
			
			newWindow.activate();
			
			newWindow.stage.addChild(this);
		}
		
		
	}
}