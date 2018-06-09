package cx.client.logon.view.Plaza
{
	import cx.client.logon.model.LogonModel;
	import cx.client.logon.model.UserModel;
	import cx.client.logon.view.Action.ActionCodeSprite;
	import cx.client.logon.view.Action.PhoneCheck;
	import cx.client.logon.view.message.Message;
	import cx.net.NetConst;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.ApplicationDomain;
	
	import t.cx.Interface.IHtmlContiner;
	import t.cx.air.TConst;
	import t.cx.air.skin.ButtonEx;
	
	public class WebContiner extends Sprite
	{
		protected var _htmlLoader : IHtmlContiner;
		public function WebContiner()
		{
			super();
			this.visible = false;
			OnInit();
		}
		protected function OnInit() : void
		{
			if(NetConst.pCxWin) {
				_htmlLoader = NetConst.pCxWin.CxGetHtmlContiner();
				_htmlLoader.SetWH(WebWH.x,WebWH.y);
				var sprite : Sprite= _htmlLoader.GetDisplay();
				this.addChild(sprite);
			}
		}
		protected function get WebWH() : Point
		{
			return new Point(740,545);
		}
		
		public function Show(url : String,bAddCheck : Boolean = true,bPaint : Boolean = false) : void
		{
			if(bAddCheck) { url += '?tcode=' + _htmlLoader.timeCode; }
			if(_htmlLoader) {
				_htmlLoader.CallBack = callBack;
				_htmlLoader.JsGetValue = jsGetValue;
				_htmlLoader.SetHost(url,bPaint);
			}
			if(!this.visible) { this.visible = true;  }
		}
		public function Hide() : void
		{
			if(_htmlLoader) {
				_htmlLoader.CancelLoad();
			}
			this.visible = false;
		}
		
		private function jsGetValue(tcode : String,type : String) : *
		{
			if(_htmlLoader.checkCode(tcode) == false) { return 'error'; }
			switch(type)
			{
				case 'uid':
				{
					return UserModel._getInstance().selfID.toString();
				}
				case 'accounts':
				{
					return UserModel._getInstance().selfInfo.szAccount;
				}
				case 'score':
				{
					return UserModel._getInstance().selfInfo.lScore.toString();
				}
				case 'insurescore':
				{
					return UserModel._getInstance().selfInfo.lBankScore.toString();
				}
			}
			return 'error';
		}
		private function callBack(type : String,val : String) : void
		{
			switch(type)
			{
				case 'pay':								//充值页
				{
//					var request:URLRequest = new URLRequest(val);
//					navigateToURL(request,"_blank");	
					NetConst.pCxWin.CxCreateBrowser( val,'在线充值' );
					break;
				}
				
				case 'sale':							//金币出售
				{	
					//刷新金币
					LogonModel._GetInstance().MainNet.Refresh();
					Message.show(val,Message.MSG_NORMAL);
					break;
				}
				case 'reward':							//领奖
				{
					//刷新金币
					LogonModel._GetInstance().MainNet.Refresh();
					Message.show(val,Message.MSG_NORMAL);
					break;
				}
				case 'popup':
				{
					Message.show(val,Message.MSG_NORMAL);
					break;
				}
				case 'mobilecheck':						//手机验证				
				{
					var cl : Class = ApplicationDomain.currentDomain.getDefinition('PhoneCheck') as Class;
					if(cl != null) {
						var phone : PhoneCheck = new cl();
						if(phone != null)
						{
							this.addChild(phone);
							phone.Show(val,_htmlLoader.SendToWeb);
						}
					}
					break;
				}
				case 'GetActionCode':
				{
					var actClass : Class = ApplicationDomain.currentDomain.getDefinition('ActionCodeLink') as Class;
					if(actClass != null) {
						var ActionCodeView : ActionCodeSprite = new actClass();
						if(ActionCodeView != null)
						{
							this.addChild(ActionCodeView);
							ActionCodeView.Show(val,_htmlLoader.SendToWeb);
						}
					}
					break;
				}
			}
		}
	}
}