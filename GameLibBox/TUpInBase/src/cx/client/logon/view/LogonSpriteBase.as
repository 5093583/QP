package cx.client.logon.view
{
	import cx.client.logon.model.LogonModel;
	import cx.client.logon.view.Logon.LogonView;
	import cx.client.logon.view.welcome.WelcomeView;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import mx.controls.Button;
	
	import t.cx.Interface.ICxKernelClient;
	import t.cx.air.TConst;
	import t.cx.air.TDas;
	import t.cx.air.skin.ButtonEx;
	import t.cx.air.skin.CheckBoxEx;
	import t.cx.air.skin.CheckGroup;

	public class LogonSpriteBase extends Sprite implements ICxKernelClient
	{
		protected var m_theLogon : LogonView;
		public function LogonSpriteBase()
		{
			super();
			if(stage) {
				onAddToStage();
			}else{
				this.addEventListener(Event.ADDED_TO_STAGE,onAddToStage);
			}
		}
		protected function onAddToStage(e : Event = null) : void
		{
			if(e != null) { this.removeEventListener(Event.ADDED_TO_STAGE,onAddToStage); }
			//初始化数据
			LogonModel._GetInstance().Init();
			if(theWelcome != null) {
				theWelcome.AddCallBack(showLogonView);
			}else {
				showLogonView();
			}
		}
		private function showLogonView() : void
		{
			if(theWelcome != null) {
				theWelcome.visible = false;
				theWelcome.Destory();
			}
			if(theLogon != null) {
				this.addChild(theLogon);
			}
		}
		public function CxGetWH():Point
		{
			return null;
		}
		
		public function CxGetDisplayObject(type:String="", bShow:Boolean=false):DisplayObject
		{
			return this;
		}
		
		public function CxShowType(parent:*=null):String
		{
			return '_main2d';
		}
		
		public function CxIcon(size:uint=128):Array
		{
			return null;
		}
		
		public function CxWindowTitle():String
		{
			return null;
		}
		public function CxClientDestroy(cbDestroyCode:uint):Boolean
		{
			DestroyCompant();
			return true;
		}
		public function CXShowed(bExitCode:uint):void
		{
			trace('Logon CXShowed:',bExitCode);
		}
		protected function get theLogon() : LogonView
		{
			return null;
		}
		protected function get theWelcome() : WelcomeView
		{
			return null;
		}
		protected function DestroyCompant() : void
		{
			if( m_theLogon!= null) {
				m_theLogon.Destroy();
				m_theLogon = null;
			}
		}
	}
}