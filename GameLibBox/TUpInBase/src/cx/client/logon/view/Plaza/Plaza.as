package cx.client.logon.view.Plaza
{
	import com.greensock.TweenMax;
	import com.minimalcomps.components.Calendar;
	
	import cx.assembly.head.HeadEmbed;
	import cx.client.logon.model.GameFrameModel;
	import cx.client.logon.model.LogonModel;
	import cx.client.logon.model.ServerList;
	import cx.client.logon.model.events.RoomEvents;
	import cx.client.logon.view.GameFrame.GameFrame;
	import cx.client.logon.view.Logon.LogonView;
	import cx.client.logon.view.Plaza.ad.PlazaAd;
	import cx.client.logon.view.Plaza.chat.ChatView;
	import cx.client.logon.view.Plaza.kindroom.KindListView;
	import cx.client.logon.view.Plaza.kindroom.Roomlist;
	import cx.client.logon.view.Plaza.yinhang.YinHangSprite;
	import cx.client.logon.view.message.Message;
	import cx.gamebase.events.GameEvent;
	import cx.gamebase.sturuct.tagServerParmater;
	import cx.net.NetConst;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.system.ApplicationDomain;
	import flash.system.System;
	import flash.text.TextField;
	
	import mx.core.Application;
	
	import t.cx.Interface.ICxKernelClient;
	import t.cx.air.TConst;
	import t.cx.air.TDas;
	import t.cx.air.TScore;
	import t.cx.air.controller.Controller;
	import t.cx.air.controller.TEvent;
	import t.cx.air.skin.ButtonEx;
	import t.cx.air.utils.IDConvert;
	
	public class Plaza extends Sprite implements ICxKernelClient
	{
		private var _gameFrame : GameFrame;
		protected var m_theModel : LogonModel;
		protected var m_bShow : Boolean;
		protected var m_headBitmap : Bitmap;
		protected var m_LogonWindow : LogonView;
		public function get bShow() : Boolean
		{
			return m_bShow;
		}
		private var _bRefreshEnable : Boolean;
		public function set refreshEnable(val : Boolean) : void
		{
			_bRefreshEnable = val;
			if(theRefresh != null) {  theRefresh.enable = val; }
			if(!_bRefreshEnable) {
				TweenMax.delayedCall(3,TimeRefresh);
			}
		}
		private function TimeRefresh() : void
		{
			refreshEnable = true;
		}
		public function Plaza()
		{
			super();
			if(stage != null){
				onInit();
			}else {
				this.addEventListener(Event.ADDED_TO_STAGE,onInit);
			}
		}
		
		public function CxGetWH():Point
		{
			return new Point(1024,720);
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
			return '博郡棋牌';
		}
		
		public function CxClientDestroy(cbDestroyCode:uint):Boolean
		{
			m_bShow = false;
			m_theModel.msgNet.Close();
			return true;
		}
		public function CXShowed(bExitCode:uint):void
		{
			if(bExitCode == 5 && TConst.TC_AUTO_ENTER_GAME != -1)		//用户点击继续游戏
			{
				Controller.dispatchEvent(RoomEvents.ROOMLIST_ENTER,TConst.TC_AUTO_ENTER_GAME);
			}
			if(bExitCode == 100) {
				if(m_LogonWindow != null) {
					if(this.contains(m_LogonWindow)) {
						this.removeChild(m_LogonWindow);
					}
				}
				for(var i : uint = 0;i<this.numChildren - 1;i++)
				{
					if( !(this.getChildAt(i) == theBd || this.getChildAt(i) == theClosePlaza || this.getChildAt(i) == theWeb || this.getChildAt(i)== theYinHang))
					{
						this.getChildAt(i).visible = true;
					}
				}
				theZhangHao.text = m_theModel.user.selfInfo.szAccount;
				theID.text = IDConvert.Id2View(m_theModel.user.selfInfo.dwUserID).toString();
				theJinBi.text = TScore.toStringEx(m_theModel.user.selfInfo.lScore);
				showUserHead( m_theModel.user.selfInfo.wFaceID );
			}
		}
		protected function onInit(e : Event = null) : void
		{
			if(e != null) { this.removeEventListener(Event.ADDED_TO_STAGE,onInit); }
			m_bShow 			= true;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align 	= StageAlign.TOP_LEFT;
			
			m_theModel		= LogonModel._GetInstance();
			TConst.TC_MSGContiner = this;
			
			if(theZuiXiao != null) {
				theZuiXiao.addEventListener(MouseEvent.CLICK,onMinEvent);
			}
			if(theGuanBi != null) {
				theGuanBi.addEventListener(MouseEvent.CLICK,onCloseEvent);
			}
			//显示用户信息
			if(m_theModel.user && m_theModel.user.selfInfo && m_theModel.user.selfInfo.szAccount)
			{
				if(theZhangHao != null) {
					theZhangHao.text = m_theModel.user.selfInfo.szAccount;
					theZhangHao.mouseEnabled = false;
				}
				if(theID != null) {
					theID.text 		 = IDConvert.Id2View(m_theModel.user.selfInfo.dwUserID).toString();
					theID.mouseEnabled = false;
				}
				if(theJinBi != null) {
					theJinBi.text	 = TScore.toStringEx(m_theModel.user.selfInfo.lScore);
					theJinBi.mouseEnabled = false;
				}
				showUserHead( m_theModel.user.selfInfo.wFaceID );
			}
			for(var i : uint = 0;i<6;i++) {
				if(this.hasOwnProperty('DH_' + i)) {
					this['DH_' + i].addEventListener(MouseEvent.CLICK,selectDaohang);
				}
			}
			if(this.hasOwnProperty('DH_0')) {
				this['DH_0'].select = true;
			}
			Controller.addEventListener(RoomEvents.ROOMLIST_ENTER,onEnterRoom);
			Controller.addEventListener(GameEvent.USER_SCORE,onUserInfoChange);
			
			thePlazaBg.addEventListener(MouseEvent.MOUSE_DOWN,onDragPlaza);
			if(theBdBtn != null) {
				theBdBtn.addEventListener(MouseEvent.CLICK,onButtonEvent);
			}
			if(theYhBtn != null) {
				theYhBtn.addEventListener(MouseEvent.CLICK,onButtonEvent);
			}
			if(theRefresh != null) {
				theRefresh.addEventListener(MouseEvent.CLICK,onButtonEvent);
				refreshEnable = false;
			}
			
			if(theKindList != null){
				theKindList.OnInitKindListView();
			}
			//链接消息服务器
			if( m_theModel.msgNet ) 
			{
				if(theChat!= null){
					m_theModel.msgNet.Connect(theChat.AddChatInfo);
				}else {
					m_theModel.msgNet.Connect(null);
				}
			}
		}
		protected function showUserHead(wFaceID : uint) : void
		{
			if(m_headBitmap != null)
			{
				if(this.contains(m_headBitmap))
				{
					this.removeChild(m_headBitmap);
				}
				m_headBitmap = null;
			}
			m_headBitmap = HeadEmbed.EmbedHead(wFaceID);
			m_headBitmap.width = m_headBitmap.height = 54;
			m_headBitmap.x = 19;
			m_headBitmap.y = 148;
			this.addChild(m_headBitmap);
		}
		private function  onButtonEvent(e : MouseEvent) : void
		{
			switch(e.target.name)
			{
				case 'BdBtn':
				{
					if(theBd != null) { theBd.Show(); }
					break;
				}
				case 'YinHangBtn':
				{
					if(theYinHang != null) { theYinHang.Show(); }
					
					break;
				}
				case 'RefreshBtn':
				{
					refreshEnable = false;
					m_theModel.MainNet.Refresh();
					break;
				}
			}
		}
		private function onEnterRoom(e : TEvent) : void
		{
			if(!GameFrameModel._GetInstance().CanEnter())
			{
				Message.show("您从上一房间强制退出,请等待 [" +GameFrameModel._GetInstance().GetLeaveTime()+']秒后再进入.'); 
				return;
			}
			if(NetConst.pCxWin) {
				if(_gameFrame == null) {
					var c : Class = ApplicationDomain.currentDomain.getDefinition('GameFrameMC') as Class;
					_gameFrame = new c();
				}
				_gameFrame.serverParam = new tagServerParmater(e.m_nMsg);
				NetConst.pCxWin.CxShowWindow(_gameFrame as ICxKernelClient);
			}
			System.gc();
		}
		private function onUserInfoChange(e : TEvent) : void
		{
			theJinBi.text = TScore.toStringEx(m_theModel.user.selfInfo.lScore);
			showUserHead( m_theModel.user.selfInfo.wFaceID );
		}
		private function onDragPlaza( e : MouseEvent) : void
		{
			if(NetConst.pCxWin) { NetConst.pCxWin.CxStartMove(); }
		}
		private function selectDaohang(e : MouseEvent) : void
		{
			var dh : ButtonEx = e.target as ButtonEx;
			if(dh.select) return;
			ResetDaoHang(dh);
		}
		public function ResetDaoHang(dh : Object) : void
		{ 
			for(var i : uint = 0;i<6;i++) {
				if(this.hasOwnProperty('DH_' + i)) {
					if(dh == this['DH_' + i]) {
						dh.select = true;
						switch(i) 
						{
							case 0:
							{
								hideRoomList(false);
								break;
							}
							case 1:
							{
								hideRoomList(true);
								theWeb.Show(TDas._getStringItem(TConst.PER_URL,512));
								break;
							}
							case 2:
							{
								hideRoomList(true);
								theWeb.Show(TDas._getStringItem(TConst.ACT_URL,512));
								break;
							}
							case 3:
							{
								hideRoomList(true);
								theWeb.Show(TDas._getStringItem(TConst.PAY_URL,512));
								break;
							}
							case 4:
							{
								hideRoomList(true);
								theWeb.Show(TDas._getStringItem(TConst.SHOP_URL,512));
								break;
							}
							case 5:
							{
								hideRoomList(true);
								theWeb.Show( TDas._getStringItem(TConst.SER_URL,512),false,true);
								break;
							}
						}
					}else {
						this['DH_' + i].select = false;
					}
				}
			}
		}
		private function hideRoomList(bShow : Boolean) : void
		{
			theBulletin.visible = !bShow;
			theRoomList.visible = !bShow;
			if(!bShow)
			{
				theWeb.Hide();
				theBulletin.Start();
				ServerList._getInstance().m_wCurrentKind =-1;
				Controller.removeEventListener('LIST_EVENT_SELECT',onRoomListEvent);
			}else {
				theBulletin.Stop();
				Controller.addEventListener('LIST_EVENT_SELECT',onRoomListEvent);
			}
			if(theChat != null) { theChat.visible 	= !bShow; }
			if(theAdView !=null){ theAdView.visible = !bShow; }
		}
		private function onRoomListEvent(e : TEvent) : void
		{
			if(this.hasOwnProperty('DH_0')) {
				ResetDaoHang(this['DH_0']);
			}else {
				hideRoomList(false);
				for(var i : uint = 0;i<6;i++) {
					if(this.hasOwnProperty('DH_' + i)) {
						this['DH_' + i].select = false;
					}
				}
			}
		}
		protected function onMinEvent(e : MouseEvent) : void
		{
			if(NetConst.pCxWin) { NetConst.pCxWin.CxMinWnd(this); }
		}
		protected function onCloseEvent(e : MouseEvent) : void
		{
			if(theClosePlaza != null)
			{
				theClosePlaza.Show(OnExitPlaza);
			}else {
				Message.show('博郡棋牌提醒您现在正在退出游戏大厅,是否确定退出!',Message.MSG_WARN,OnExitPlaza);
			}
		}
		
		protected function OnExitPlaza(type : uint = 2) : void
		{
			switch(type) 
			{
				case 0:
				case 1:
				{
					if(NetConst.pCxWin) { NetConst.pCxWin.CxExit(this); }
					break;
				}
				case 2:
				{
					for(var i : uint = 0;i<this.numChildren - 1;i++)
					{
						this.getChildAt(i).visible = false;
					}
					if(m_headBitmap != null) {
						this.removeChild(m_headBitmap);
						m_headBitmap.bitmapData.dispose();
						m_headBitmap = null;
					}
					if( m_LogonWindow == null ){
						var c : Class = ApplicationDomain.currentDomain.getDefinition('Logon') as Class;
						m_LogonWindow =  new c();
						m_LogonWindow.PlazaInstance = this;
					}
					if(NetConst.pCxWin)  { NetConst.pCxWin.CxCenterWindow(this);}
					
					m_LogonWindow.x = (1024 - m_LogonWindow.width) * .5;
					m_LogonWindow.y = (720 - m_LogonWindow.height) * .5;
					this.addChild(m_LogonWindow);
					break;
				}
			}
		}
		/**
		 * 
		 * */
		private function get theGuanBi() : ButtonEx
		{
			return this['GuanBiMC'];
		}
		protected function get theZuiXiao() : ButtonEx
		{
			return this['ZuiXIaoMC'];
		}
		
		protected function get theBdBtn() : ButtonEx
		{
			return this['BdBtn'];
		}
		protected function get theYhBtn() : ButtonEx
		{
			return this['YinHangBtn'];
		}
		protected function get theRefresh() : ButtonEx
		{
			return this['RefreshBtn'];
		}
		
		
		protected function get theZhangHao() : TextField
		{
			return this['ZhangHaoTxt'];
		}
		protected function get theID() : TextField
		{
			return this['IDTxt'];
		}
		protected function get theJinBi() : TextField
		{
			return this['JinBiTxt'];
		}
		protected function get theClosePlaza() : ClosePlazaView
		{
			return this['ClosePlazaMC'];
		}
		
		private function get thePlazaBg() : Sprite
		{
			return this['PlazaBgMC'];
		}
		
		private function get theBd() : BangDingSprite
		{
			return this['BdSprite'];
		}
		private function get theYinHang() : YinHangSprite
		{
			return this['YHSprite'];
		}
		protected function get theWeb() : WebContiner
		{
			return this['PlazaWebMC'];
		}
		protected function get theRoomList() : Roomlist
		{
			return this['RoomListMC'];
		}
		protected function get theBulletin() : PlazaBulletin
		{
			return this['BulletinMC'];
		}
		protected function get theChat() : ChatView
		{
			return this['ChatMC'];
		}
		protected function get theAdView() : PlazaAd
		{
			return this['PlazaAdView'];
		}
		protected function get theKindList() : KindListView
		{
			return this['KindListMC'];
		}
	}
}