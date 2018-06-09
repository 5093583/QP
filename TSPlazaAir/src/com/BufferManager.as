package com
{
	import com.plaza.MsgManager;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.system.Capabilities;
	import flash.utils.Timer;
	
	import mx.core.UIComponent;
	
	import spark.components.Group;

	public class BufferManager
	{
		
		private static var instance:BufferManager;
		
		public static function getInstance():BufferManager
		{
			if(instance == null)
				instance = new BufferManager;
			return instance;
		}
		
		
		
		[Embed(source="assets/buffer.swf", symbol="buffer")]
		private var buffer:Class;
		
		private var _gp:Group;
		private var _ui:UIComponent;
		private var _mc:MovieClip;
		private var _sp:Sprite;
		
		private var timer:Timer;

		private const TIMER_DELAY:uint = 8000;
		
		
		public function BufferManager()
		{
			timer = new Timer(5000);
		}
		
		
		public function init(gp:Group):void
		{
			_gp = gp;
		}
		
		
		public function showBufferView(show:Boolean):void
		{
			initChildren();
			_gp.visible = show;
			
			if(show)
			{
				_mc.gotoAndPlay(1);
				_mc.addEventListener(Event.ENTER_FRAME, mc_enterFrameHandler);
				
				timer.delay = TIMER_DELAY;
				timer.repeatCount = 1;
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, timer_completeHandler);
				timer.start();
			}
			else
			{
				_mc.stop();
				timer.reset();
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timer_completeHandler);
			}
		}
		
		private function timer_completeHandler(e:TimerEvent):void
		{
			showBufferView(false);
			MsgManager.getInstance().showMessage1( '网络响应时间过长，请稍后尝试！');
		}
		
		
		
		private function mc_enterFrameHandler(e:Event):void
		{
			if(_mc.currentFrame == _mc.totalFrames)
			{
				_mc.stop();
				_mc.removeEventListener(Event.ENTER_FRAME, mc_enterFrameHandler);
			}
		}
		
		
		private function initChildren():void
		{
			if(_gp == null)
				MsgManager.getInstance().showMessage1( '请先初始化缓冲窗口。。。。')
				
				
			if( _ui == null )
				_ui = new UIComponent;
			
			if(!_ui.numChildren)
			{
				if(!_sp)
				{
					var Stageheight:Number = Capabilities.screenResolutionY;  
					var Stagewidth:Number = Capabilities.screenResolutionX;
					
					_sp = new Sprite;
					_sp.graphics.clear();
					_sp.graphics.beginFill(0x000000, .3);
					_sp.graphics.drawRect(0, 0, Stagewidth, Stageheight);
					_sp.graphics.endFill();
				}
				
				_ui.addChild(_sp);
				_gp.addElement(_ui);
				
				var bufUI:UIComponent = new UIComponent;
				_mc = new buffer() as MovieClip;
				bufUI.addChild(_mc);
				_gp.addElement(bufUI);
				
				bufUI.horizontalCenter = 0;
				bufUI.verticalCenter	 = 0;
			}
		}
		
		
		
		
	}
}