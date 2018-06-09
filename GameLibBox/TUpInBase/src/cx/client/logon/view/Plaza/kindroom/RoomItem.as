package cx.client.logon.view.Plaza.kindroom
{
	import cx.client.logon.model.ServerList;
	import cx.client.logon.model.events.MsgEvent;
	import cx.client.logon.model.events.RoomEvents;
	import cx.client.logon.model.vo.KindOption;
	import cx.gamebase.events.GameEvent;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import t.cx.air.TConst;
	import t.cx.air.TScore;
	import t.cx.air.controller.Controller;
	import t.cx.air.controller.TEvent;
	import t.cx.air.file.TPather;
	import t.cx.air.skin.ButtonEx;
	import t.cx.cmd.struct.tagGameServer;
	
	public class RoomItem extends MovieClip
	{
		protected var m_iconBitmap 	: Bitmap;
		protected var m_wServerID 	: int;
		protected var m_kindID		: int;
		
		public function RoomItem()
		{
			super();
			Reset();
		}
		public function Reset() : void
		{
			this.visible = false;
			if( theQiDai != null) {
				theQiDai.gotoAndStop(1);
				theQiDai.visible = false;
			}
		}
		
		public function ConfigRoom(kindOption : KindOption,pServer : tagGameServer = null) : void
		{
			if(pServer != null) 
			{
				var path : String = TPather._fullPath(kindOption.exe) + (TConst.TC_DEUBG == 1?'.swf':'.cxc');
				if( TPather._exist(path) ) 
				{
					Controller.addEventListener(MsgEvent.MSG_UPDATE_SERVER,OnUpdateServerList);
					m_kindID 	= pServer.wKindID;
					m_wServerID = pServer.wServerID;
					onUpdateRoomInfo(pServer.szServerName ,pServer.lCellScore, pServer.lRoomLessScore, pServer.dwOnLineCount);
					this.visible = true;
					return;
				}
			}
			onHideRoomInfo();
			if( theQiDai != null) {
				theQiDai.gotoAndPlay(1);
				theQiDai.visible = true;
			}else {
				this.visible = false;
			}
		}
		protected function OnUpdateServerList(e : TEvent) : void
		{
			var GameServer : tagGameServer = e.nWParam as tagGameServer;
			if( GameServer == null ) return;
			if(GameServer.wServerID != m_wServerID) return;
			switch(e.m_nMsg)
			{
				case 1:				//更新房间
				{
					onUpdateRoomInfo(GameServer.szServerName ,GameServer.lCellScore, GameServer.lRoomLessScore, GameServer.dwOnLineCount);
					break;
				}
				case 2:				//关闭房间
				{
					Reset();
					break;
				}
			}
		}
		protected function onUpdateRoomInfo( szName : String,cell : Number,max : Number,onLine : int) : void
		{
			if( theRoomName != null ) {
				theRoomName.text = szName;
			}
			if( theCellTxt != null ) {
				theCellTxt.text = TScore.toStringEx(cell);
			}
			if( theMaxTxt != null ) {
				theMaxTxt.text = TScore.toStringEx(max);
			}
			if( theOnLine != null ) {
				theOnLine.text = onLine.toString();
			}
			var hasMatch : Boolean = ServerList._getInstance().ExistMatchByServerID(m_wServerID)!=null;
			if( hasMatch && theMatchButton!=null ) {
				theMatchButton.addEventListener(MouseEvent.CLICK,onEnterGame);
				theMatchButton.visible = true;
				if(theEnterRoom != null) {
					theEnterRoom.removeEventListener(MouseEvent.CLICK,onEnterGame);
					theEnterRoom.visible = false;
				}
			}else {
				if(theEnterRoom != null) {
					theEnterRoom.addEventListener(MouseEvent.CLICK,onEnterGame);
					theEnterRoom.visible = true;
				}
				if(theMatchButton!=null) {
					theMatchButton.removeEventListener(MouseEvent.CLICK,onEnterGame);
					theMatchButton.visible = false;
				}
			}
		}
		protected function onHideRoomInfo() : void
		{
			if( theRoomName != null ) {
				theRoomName.text = '';
			}
			if( theCellTxt != null ) {
				theCellTxt.text = '';
			}
			if( theMaxTxt != null ) {
				theMaxTxt.text = '';
			}
			if( theOnLine != null ) {
				theOnLine.text = '';
			}
			if(theEnterRoom != null) {
				theEnterRoom.removeEventListener(MouseEvent.CLICK,onEnterGame);
				theEnterRoom.visible = false;
			}
			if(theMatchButton != null)
			{
				theMatchButton.removeEventListener(MouseEvent.CLICK,onEnterGame);
				theMatchButton.visible = false;
			}
		}
		protected function onEnterGame(e : MouseEvent) : void
		{
			Controller.dispatchEvent(RoomEvents.ROOMLIST_ENTER,m_wServerID);
		}
		protected function get theEnterRoom() : ButtonEx
		{
			return null;
		}
		protected function get theMatchButton() : ButtonEx
		{
			return null;
		}
		protected function get theRoomName() : TextField
		{
			return null;
		}
		
		protected function get theCellTxt() : TextField
		{
			return null;
		}
		
		protected function get theMaxTxt() : TextField
		{
			return null;
		}
		
		protected function get theOnLine() : TextField
		{
			return null;
		}
		protected function get theQiDai() : MovieClip
		{
			return null;
		}
	}
}