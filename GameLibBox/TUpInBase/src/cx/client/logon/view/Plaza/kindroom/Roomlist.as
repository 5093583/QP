package cx.client.logon.view.Plaza.kindroom
{
	import com.greensock.TweenMax;
	
	import cx.client.logon.model.ServerList;
	import cx.client.logon.model.events.RoomEvents;
	import cx.client.logon.model.vo.KindOption;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	
	import t.cx.air.controller.Controller;
	import t.cx.air.controller.TEvent;
	import t.cx.air.skin.LoadCircle;
	import t.cx.cmd.struct.tagGameServer;
	
	
	public class Roomlist extends Sprite
	{
		protected var m_serverList 	: ServerList;
		protected var m_roomArr 	: Vector.<RoomItem>;
		protected var m_kindOption 	: KindOption;
		
		private var _loadingSprite : LoadCircle;
		public function Roomlist()
		{
			super();
			if(stage) {
				onInit();
			}else{
				this.addEventListener(Event.ADDED_TO_STAGE,onInit);
			}
		}
		
		protected function onInit(e : Event = null) : void
		{
			if(m_serverList == null)m_serverList = ServerList._getInstance();
			m_roomArr = new Vector.<RoomItem>();
			
			if(onCtrateRoomVector()) {
				
				for each(var roomItem : RoomItem in m_roomArr)
				{
					if(roomItem != null) {
						roomItem.Reset();
					}
				}
			}
			Controller.addEventListener(RoomEvents.ROOMLIST_EVENT,onRoomListEvent);
			if(m_serverList.m_wCurrentKind != -1) { 
				onShowRoom( m_serverList.m_wCurrentKind ); 
			}
		}
		protected function onCtrateRoomVector() : Boolean
		{
			return true;
		}
		protected function onCreateRoomItem() : RoomItem
		{
			return null;
		}
		private function onRoomListEvent(e : TEvent) : void
		{
			switch(e.m_nMsg)
			{
				case RoomEvents.ROOM_SELECT:
				{
					onShowRoom(e.nWParam);
					stopLoad();
					break;
				}
				case RoomEvents.ROOM_UPDATE:
				{
					stopLoad();
					m_kindOption = null;
					onShowRoom(e.nWParam);
					break;
				}
				case RoomEvents.ROOM_LOADING:
				{
					startLoad();
					break;
				}
			}
		}
		private function startLoad() : void
		{
			if( _loadingSprite == null) {
				_loadingSprite = new LoadCircle(this.width,this.height);
			}
			this.addChild(_loadingSprite);
		}
		private function stopLoad() : void
		{
			if( _loadingSprite != null ) {
				this.removeChild(_loadingSprite);
				_loadingSprite.destroy();
				_loadingSprite = null;
			}
		}
		protected function onShowRoom(wKindID : int) : Boolean
		{
			if( m_kindOption != null && m_kindOption.wKindID == wKindID )return false;
			m_kindOption = m_serverList.GetKindOption(wKindID);
			if(m_kindOption == null) return false;
			
			var serverArr : Array= m_serverList.GetServerList( m_kindOption.wKindID );
			var i : uint = 0;
			for(i = 0;i<m_roomArr.length;i++) 
			{ 
				m_roomArr[i].Reset(); 
			}
			if( !(serverArr != null && serverArr.length>0) ) { 
				m_roomArr[0].ConfigRoom(m_kindOption,null);
				return false; 
			}
			onConfigRoom(serverArr);
			return true;
		}
		
		protected function onConfigRoom(pServers : Array) : void
		{
			TweenMax.killAll(true);
			for(var i : uint = 0; i<pServers.length; i++ )
			{
				if( m_roomArr[i] )
				{
					m_roomArr[i].ConfigRoom( m_kindOption,pServers[i]);
					TweenMax.from( m_roomArr[i],0.3,{x:m_roomArr[i].x+(30 * (i%2==0?-1:1))});
				}
			}
		}
	}
}