package cx.client.logon.view.version
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Quad;
	
	import cx.net.NetConst;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	
	import t.cx.Interface.ICxKernelClient;
	import t.cx.air.TConst;
	import t.cx.air.TDas;
	import t.cx.air.skin.ButtonEx;
	
	public class VersionSprite extends Sprite
	{
		public function VersionSprite()
		{
			super();
			this.visible = false;
		}
		public function SetShowStatus(bNewLogon : Boolean) : void
		{
			this.visible = !this.visible;
			if(	this.visible ) {
				TweenMax.killAll(true);
				TweenMax.from(this,0.5,{y:420,ease:Quad.easeOut});
				var str : String = TDas._getStringItem('client_donwload',256);
				if(str==null) { str = TDas._getStringItem('service_url',256); }
				theWarnTxt.htmlText = "1.当客户端不是最新版本,强烈建议您使用 <font color='#ff0000'><a href='"+str+"'><u>手动更新</u></a></font>,<font color='#FF6600'>下载并安装最新客户端后再进行游戏</font>,以保证您愉快的游戏.\n" +
					"2.当游戏平台不需强制更新时,您可以使用 <font color='#ff0000'>旧版登陆</font>(<font color='#FF6600'>当客户端不是最新版本时,不建议使用</font>).\n" +
					"3.当客户端<font color='#FF6600'>多次更新失败</font>或者<font color='#FF6600'>无法登陆</font>时,请尝试使用 <font color='#ff0000'><a href='"+str+"'><u>手动更新</u></a></font>或者<font color='#ff0000'>重置客户端</font><font color='#FF6600'>(重置将会清空用户记录并关闭客户端)</font>.";
				var ver : Number = TDas._getDoubleItem(TConst.VER);
				var newVer : Number = TDas._getDoubleItem('new_version_check');
				var bForceAll : uint = TDas._getByteItem('new_forceAll');
				RegisterBtn(bNewLogon,ver,newVer,bForceAll);
				
				var waring : String ='';
				waring = "当前版本:<font color='#FF6600'>v" + GetVer(ver)+"</font>";
				//最新版本:<font color='#FF6600'>v"+GetVer(newVer)+"</font>.\n"
				if(  newVer == 999) {
					waring += "最新版本:<font color='#FF6600'> (未获得)</font>\n"
				}else {
					waring += "最新版本:<font color='#FF6600'>v"+GetVer(newVer)+"</font>.\n";
				}
				if(!bNewLogon)
				{
					waring += "<font color='#99CC00' size='16'>当前登陆客户端不是最新版本,请您关闭客户端重新启动.\n</font>";
				}else {
					if(ver != newVer) {
						if( newVer == 999) {
							waring += "<font color='#99CC00' size='16'>未获得最新版本信息,请检查网络后重新登陆.\n</font>";
						}else {
							if(bForceAll==1) {
								waring += "<font color='#99CC00' size='16'>为了保证您个人财产安全，当前平台需要您进行手动更新后继续游戏,因此给您带来的不便请谅解.\n</font>";
							}else {
								waring += "<font color='#99CC00' size='16'>当前客户端不是最新版本,强烈建议您使用手动更新安装最新客户端.\n</font>";
							}
						}
					}else {
						waring += "当前客户端已经最新版本.\n";
					}
				}
				theMsgTxt.htmlText = waring;
			}else {
				theWarnTxt.htmlText='';
				TweenMax.killAll(true);
				UnRegisterBtn();
			}
		}
		
		private function GetVer(num : Number) : String
		{
			var ver : String = num.toString();
			var result : String = '';
			for(var i : uint = 0;i<ver.length-1;i++)
			{
				result+=ver.charAt(i) + '.';
			}
			result+=ver.charAt(i);
			return result;
		}
		
		private function RegisterBtn(bNewLogon:Boolean,old : int,newVer : int,bForceAll : uint) : void
		{
			if(!bNewLogon || old==newVer || (old!=newVer && bForceAll==1)) {
				theOldLogon.enable = false;
			}else {
				theOldLogon.enable = true;
				theOldLogon.addEventListener(MouseEvent.CLICK,onButtonEvent); 
			}
			theUpdate.addEventListener(MouseEvent.CLICK,onButtonEvent);
			theReset.addEventListener(MouseEvent.CLICK,onButtonEvent);
			theClose.addEventListener(MouseEvent.CLICK,onButtonEvent);
		}
		private function UnRegisterBtn() : void
		{
			theReset.removeEventListener(MouseEvent.CLICK,onButtonEvent);
			theUpdate.removeEventListener(MouseEvent.CLICK,onButtonEvent);
			theOldLogon.removeEventListener(MouseEvent.CLICK,onButtonEvent);
			theClose.removeEventListener(MouseEvent.CLICK,onButtonEvent);
		}
		private function onButtonEvent(e : MouseEvent) : void
		{
			switch(e.target.name)
			{
				case 'OldLogonBtn':
				{
					if(this.parent!=null) { this.parent['OldLogonPlaza'](); }
					break;
				}
				case 'UpdateBtn':
				{
					var szDown : String = TDas._getStringItem('client_donwload',256);
					if(szDown==null) { szDown = TDas._getStringItem('service_url',256); }
					navigateToURL(new URLRequest(szDown));
					break;
				}
				case 'ResetBtn':
				{
					if(NetConst.pCxWin){ NetConst.pCxWin.CxExit(this.parent.parent as ICxKernelClient,999); }
					break;
				}
				case 'CloseBtn':
				{
					SetShowStatus(false);
					break;
				}
			}
		}
		private function get theWarnTxt() : TextField
		{
			return this['WarnTxt'];
		}
		private function get theMsgTxt() : TextField
		{
			return this['MsgTxt'];
		}
		private function get theOldLogon() : ButtonEx
		{
			return this['OldLogonBtn'];
		}
		private function get theUpdate() : ButtonEx
		{
			return this['UpdateBtn'];
		}
		private function get theReset() : ButtonEx
		{
			return this['ResetBtn'];
		}
		private function get theClose() : ButtonEx
		{
			return this['CloseBtn'];
		}
		public function Destroy() : void
		{
			UnRegisterBtn();
			this['WarnTxt'] = null;
			this['MsgTxt'] = null;
			theReset.Destroy();
			this['ResetBtn'] = null;
			theUpdate.Destroy();
			this['UpdateBtn'] = null;
			theOldLogon.Destroy();
			this['OldLogonBtn'] = null;
			theClose.Destroy();
			this['CloseBtn'] = null;
			
		}
	}
}