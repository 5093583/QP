package cx.client.logon.view.Logon
{
	import cx.client.logon.model.LogonNet;
	import cx.client.logon.model.UserModel;
	import cx.client.logon.model.struct.CMD_GP_LogonByAccounts;
	import cx.client.logon.model.struct.CMD_GP_LogonError;
	import cx.client.logon.model.struct.LGCmd;
	import cx.client.logon.model.vo.UserInfo;
	import cx.client.logon.view.Combox;
	import cx.client.logon.view.Plaza.Plaza;
	import cx.client.logon.view.version.VersionButton;
	import cx.client.logon.view.version.VersionSprite;
	import cx.net.Interface.IClientSocket;
	import cx.net.NetConst;
	import cx.net.enum.enSocketState;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.ApplicationDomain;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	
	import t.cx.Interface.ICxKernelClient;
	import t.cx.air.TConst;
	import t.cx.air.TDas;
	import t.cx.air.controller.Controller;
	import t.cx.air.controller.TEvent;
	import t.cx.air.skin.ButtonEx;
	import t.cx.air.skin.CheckBoxEx;
	import t.cx.air.skin.CheckGroup;
	import t.cx.air.utils.MD5;
	import t.cx.air.utils.SystemEx;
	import t.cx.air.utils.serialization.json.JSON;
	import t.cx.cmd.SendPacketHelper;
	import t.cx.cmd.enum.enDTP;
	import t.cx.cmd.events.CxEvent;
	
	public class LogonView extends Sprite
	{
		protected var _CheckGroop 		: CheckGroup;
		protected var m_Accounts		: Array;
		protected var VER_CHECK_LOGON	: Number = 100;
		
		private var m_PlazaView 	: Plaza;
		
		public function set PlazaInstance(val : Plaza) : void
		{
			m_PlazaView = val;
		}
		public function LogonView()
		{
			super();
			if(stage) {
				onInit();
			}else {
				this.addEventListener(Event.ADDED_TO_STAGE,onInit);
			}
		}
		protected function onInit(e : Event = null) : void
		{
			var saveStr : String = TDas._getStringItem(TConst.ACCOUNTS,512);
			if(m_Accounts != null) { m_Accounts = null; }
			if(saveStr != null) {
				m_Accounts =  saveStr.split('|');
			}
			var lastName : Array;
			if(m_Accounts != null && m_Accounts.length>0)
			{
				lastName = String(m_Accounts[m_Accounts.length-1]).split(',');
			}
			
			if(thePasswordTxt != null) 
			{
				thePasswordTxt.displayAsPassword 	= true;
				thePasswordTxt.restrict 			= "^ ";
				thePasswordTxt.text 				= (lastName!=null && lastName.length==2&& lastName[1]!='null')?lastName[1]:'';
			}
			if(theAccountTxt != null)
			{
				theAccountTxt.restrict 				= "A-Za-z0-9_@^ ";
				theAccountTxt.passwordCall			= selectAccount;
				if(m_Accounts != null) {
					theAccountTxt.text 					= lastName==null?'':lastName[0];
					for(var i : uint = 0;i<m_Accounts.length;i++)
					{
						theAccountTxt.insetHistory( m_Accounts[i] );
					}
				}
			}
			try {
				_CheckGroop = new CheckGroup();
				if(theDxCheck != null && theWtCheck != null)
				{
					theDxCheck.select = TDas._getByteItem(TConst.PROXY) == 1;
					theWtCheck.select = !theDxCheck.select;
					_CheckGroop.addBox(theDxCheck,theWtCheck);
				}
			}catch(e : Error) {
				theErrTxt.appendText(e.toString());
			}
		
			if( thePasswordTxt.text!=null && thePasswordTxt.text.length>=6 ) { thePassCheck.select = true; }
			var verLogon : int = TDas._getDoubleItem('check_update');
			verLogon = isNaN(verLogon)?0:verLogon;
			if(theCloseBtn != null) {
				theCloseBtn.enable = true;
				theCloseBtn.addEventListener(MouseEvent.CLICK,onExitEvent);
			}
			if(theMinBtn != null) {
				theMinBtn.enable = true;
				theMinBtn.addEventListener(MouseEvent.MOUSE_UP,onMinWin);
			}
			if(theZhaoHui != null) {
				theZhaoHui.enable = true;
				theZhaoHui.addEventListener(MouseEvent.CLICK,onComBtnEvent);
			}
			if(theKefu != null) {
				theKefu.enable = true;
				theKefu.addEventListener(MouseEvent.CLICK,onComBtnEvent);
			}
			if(theSanChu != null) {
				theSanChu.enable = true;
				theSanChu.addEventListener(MouseEvent.CLICK,onComBtnEvent);
			}
			if(theLogonBg != null){
				theLogonBg.addEventListener(MouseEvent.MOUSE_DOWN,onDragStage);
			}
			if(VER_CHECK_LOGON != verLogon || NetConst.pCxWin == null)
			{
				theErrTxt.text = "最新版本更新完成，请重新启动客户端.";
				thelogonBtn.enable = false;
			}else {
				var ver : Number = TDas._getDoubleItem(TConst.VER);
				var newVer : Number = TDas._getDoubleItem('new_version_check');
				var bForceAll : uint = TDas._getByteItem('new_forceAll');
				if(ver!=newVer ) {
					if(newVer == 999) {
						theErrTxt.text = "未获得最新版本信息,请检查网络后重新登陆.";
					}else {
						if(bForceAll==1)  {
							theErrTxt.text = "客户端不是最新版本,无法进行登录,请查看最新版本并及时更新.";
							thelogonBtn.enable = false;
						}else {
							theErrTxt.text = "客户端不是最新版本,请查看最新版本并及时更新.";
							thelogonBtn.enable = true;
						}
					}
				}else { thelogonBtn.enable = true; }
			}
			if(thelogonBtn.enable)
			{
				thelogonBtn.addEventListener(MouseEvent.CLICK,onLogonEvent);
				if(stage) { stage.addEventListener(KeyboardEvent.KEY_UP,onKeyBoardEvent); }
			}
			if(theVersionBtn != null) {
				theVersionBtn.addEventListener(MouseEvent.CLICK,onComBtnEvent);
			}
		}
		private function onKeyBoardEvent(e : KeyboardEvent) : void
		{
			if(e.keyCode == 13) { onLogonEvent(null); }
		}
		private function selectAccount(str : String) : void
		{
			var arr : Array = str.split(',');
			if(arr!= null && arr.length>=2 && arr[1] != 'null')
			{
				thePasswordTxt.text =arr[1];
				thePassCheck.select = true;
			}else {
				thePasswordTxt.text = '';
				thePassCheck.select = false;
			}
		}
		public function OldLogonPlaza() : void
		{
			onLogonEvent(null);
			if(theVersionView!=null) {
				theVersionView.SetShowStatus(false);
			}
		}
		private function onLogonEvent(e : MouseEvent) : void
		{
			//检查账号规则
			if(theAccountTxt.text.length < 6) {
				theErrTxt.text = '!账号填写错误，请核对后重新输入';
				theAccountTxt.text = '';
				stage.focus = theAccountTxt;
				return;	
			}
			if(thePasswordTxt.text.length < 6){
				theErrTxt.text = '!密码填写错误，请核对后重新输入';
				thePasswordTxt.text = '';
				stage.focus = thePasswordTxt;
				return;
			}
			//
			TDas._setByteItem(TConst.PROXY,theDxCheck.select?1:2);
			if(LogonNet._getInstance().Logon(logonCallBack)) {
				theErrTxt.text = '正在连接登录服务器...';
				thelogonBtn.enable = false;
				stage.removeEventListener(KeyboardEvent.KEY_UP,onKeyBoardEvent);
			}
		}
		private function logonCallBack(pIClientSocket : IClientSocket,szErr : String = '') : void
		{
			if(pIClientSocket.GetConnectState() != enSocketState.en_Connected) {
				thelogonBtn.enable = true;
				stage.addEventListener(KeyboardEvent.KEY_UP,onKeyBoardEvent);
				theErrTxt.text = szErr;
				return;
			}
			var SendLogon : CMD_GP_LogonByAccounts = new CMD_GP_LogonByAccounts();
			SendLogon.dwPlazaVersion = TConst.VER_PLAZA_FRAME;
			SendLogon.szAccounts = theAccountTxt.text;
			SendLogon.szPassWord = MD5.hash(thePasswordTxt.text);
			var bytes : ByteArray = SendLogon.toByteArray();
			var mac : String = SystemEx._clientSequence();
			var wPacketSize : uint = SendPacketHelper._attachTCHAR(bytes,mac,33,enDTP.DTP_COMPUTER_ID);
			
			pIClientSocket.SendData(LGCmd.MDM_GP_LOGON,LGCmd.SUB_GP_LOGON_ACCOUNTS,bytes,SendLogon.size + wPacketSize);
			Controller.addEventListener(CxEvent.CX_LOGON_FINISH,onLogonFinish);
			Controller.addEventListener(CxEvent.CX_LOGON_ERR,onLogonError);
			theErrTxt.text = '登录服务器连接成功,等待获取登录信息...';
		}
		private function onLogonFinish(e : TEvent) : void
		{
			theErrTxt.text = '登录成功.';
			//记录用户账号 密码
			var user : UserInfo = UserModel._getInstance().selfInfo;
			
			user.szAccount = theAccountTxt.text;
			user.szPassword = thePasswordTxt.text;
			
			var i : int;
			if(m_Accounts != null) {
				for( i = m_Accounts.length-1;i>=0 ;i--)
				{
					if( m_Accounts[i].indexOf(theAccountTxt.text) != -1) {
						m_Accounts.splice(i,1);
						break;
					}
				}
			}else {
				m_Accounts = new Array();
			}
			m_Accounts.push( theAccountTxt.text+','+(thePassCheck.select?thePasswordTxt.text:'null') );
			var saveStr : String='';
			i = m_Accounts.length>5?(m_Accounts.length-5):0;
			for( i;i< m_Accounts.length;i++)
			{
				saveStr += ( m_Accounts[i] + ( (i==(m_Accounts.length-1))?'':'|') );
			}
			TDas._setStringItem(TConst.ACCOUNTS,saveStr,512);
			if(m_PlazaView == null ) {
				//显示大厅
				if(NetConst.pCxWin){
					var c : Class = ApplicationDomain.currentDomain.getDefinition('PlazaView') as Class;
					var _Plaza : Plaza = new c();
					if(_Plaza != null) { 
						NetConst.pCxWin.CxShowWindow(_Plaza); 
					}
				}
			}else {
				m_PlazaView.CXShowed(100);
			}
			Destroy();
		}
		private function onLogonError(e : TEvent) : void
		{
			var err : CMD_GP_LogonError = e.nWParam as CMD_GP_LogonError;
			if(err != null)
			{
				theErrTxt.text = '!' + err.szErrorDescribe;
			}else {
				theErrTxt.text = '!' + '登录服务器连接失败.';
			}
			thelogonBtn.enable = true;
			theAccountTxt.text = '';
			thePasswordTxt.text = '';
			stage.focus = theAccountTxt;
			Controller.removeEventListener(CxEvent.CX_LOGON_FINISH,onLogonFinish);
			Controller.removeEventListener(CxEvent.CX_LOGON_ERR,onLogonError);
		}
		
		private function onComBtnEvent(e : MouseEvent) : void
		{
			switch(e.target.name) 
			{
				case 'KeFuBtn':
				case 'ZhaoHuiBtn':
				{
					var url : String = TDas._getStringItem(TConst.SER_URL,512);
					if(url && url.length > 0){
						navigateToURL(new URLRequest(url));
					}
					break;
				}
				case 'SanChuBtn':
				{
					if(theAccountTxt != null) { 
						theAccountTxt.text = ''; 
						theAccountTxt.ClearHistory();
					}
					if(thePasswordTxt != null) { thePasswordTxt.text =''; }
					TDas._setStringItem(TConst.ACCOUNTS,'',512);
					break;
				}
				case 'VersionBtn':
				{
					if(theVersionView!=null) {
						var checkVer : int = TDas._getDoubleItem('check_update');
						checkVer = isNaN(checkVer)?0:checkVer;
						theVersionView.SetShowStatus( checkVer==VER_CHECK_LOGON );
					}
					break;
				}
			}
		}
		private function onDragStage(e : MouseEvent) : void
		{
			if(NetConst.pCxWin) { NetConst.pCxWin.CxStartMove(); }
		}
		private function onExitEvent(e : MouseEvent) : void
		{
			if(NetConst.pCxWin) { NetConst.pCxWin.CxExit(this.parent as ICxKernelClient,1); }
		}
		private function onMinWin(e : MouseEvent) : void
		{
			if(NetConst.pCxWin) { NetConst.pCxWin.CxMinWnd(this.parent as ICxKernelClient); }
		}
		/**-------------------------------------------
		 * 通用组件
		 * -------------------------------------------*/
		protected function get theAccountTxt() : Combox
		{
			return null;
		}
		protected function get thePasswordTxt() : Combox
		{
			return null;
		}
		protected function get theErrTxt() : TextField
		{
			return null;
		}
		protected function get thelogonBtn() : ButtonEx
		{
			return null;
		}
		protected function get theKefu() : ButtonEx
		{
			return null;
		}
		protected function get theZhaoHui() : ButtonEx
		{
			return null;
		}
		protected function get theSanChu() : ButtonEx
		{
			return null;
		}
		protected function get theCloseBtn() : ButtonEx
		{
			return null;
		}
		protected function get theMinBtn() : ButtonEx
		{
			return null;
		}
		protected function get theLogonBg() : Sprite
		{
			return null;
		}
		
		protected function get theDxCheck() : CheckBoxEx
		{
			return null;
		}
		protected function get theWtCheck() : CheckBoxEx
		{
			return null;
		}
		protected function get thePassCheck() : CheckBoxEx
		{
			return null;
		}
		protected function get theVersionBtn() : VersionButton
		{
			return null;
		}
		protected function get theVersionView() : VersionSprite
		{
			return null;
		}
		public function Destroy() : void
		{
			
			if(theAccountTxt != null) {
				theAccountTxt.ClearHistory();
				theAccountTxt.text ='';
			}
			if(thePasswordTxt != null) {
				thePasswordTxt.ClearHistory();
				thePasswordTxt.text ='';
			}
			if(theCloseBtn != null) {
				theCloseBtn.removeEventListener(MouseEvent.CLICK,onExitEvent);
			}
			if(theMinBtn != null) {
				theMinBtn.removeEventListener(MouseEvent.MOUSE_UP,onMinWin);
			}
			if(theZhaoHui != null) {
				theZhaoHui.removeEventListener(MouseEvent.CLICK,onComBtnEvent);
			}
			if(theKefu != null) {
				theKefu.removeEventListener(MouseEvent.CLICK,onComBtnEvent);
			}
			if(theSanChu != null) {
				theSanChu.removeEventListener(MouseEvent.CLICK,onComBtnEvent);
			}
			if(theLogonBg != null){
				theLogonBg.removeEventListener(MouseEvent.MOUSE_DOWN,onDragStage);
			}
			if(theVersionBtn !=null) {
				theVersionBtn.removeEventListener(MouseEvent.CLICK,onComBtnEvent);
			}
			if(stage) {
				stage.removeEventListener(KeyboardEvent.KEY_UP,onKeyBoardEvent);
			}
			thelogonBtn.removeEventListener(MouseEvent.CLICK,onLogonEvent);
			Controller.removeEventListener(CxEvent.CX_LOGON_FINISH,onLogonFinish);
			Controller.removeEventListener(CxEvent.CX_LOGON_ERR,onLogonError);
		}
	}
}