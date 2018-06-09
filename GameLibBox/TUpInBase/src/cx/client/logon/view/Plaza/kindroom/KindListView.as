package cx.client.logon.view.Plaza.kindroom
{
	import cx.client.logon.model.ServerList;
	import cx.client.logon.model.vo.KindOption;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.ApplicationDomain;
	
	import t.cx.air.controller.Controller;
	
	public class KindListView extends Sprite
	{
		protected var m_data 		: Vector.<Object> = new Vector.<Object>;
		protected var m_listItem 	: Vector.<KindItemSprite>;
		protected var m_listCount 	: uint;
		protected var m_serverList 	: ServerList;
		
		public function KindListView()
		{
		}
		public function OnInitKindListView() : void
		{
			if(initData())
			{
				if(stage) {
					onInit();
				}else{
					this.addEventListener(Event.ADDED_TO_STAGE,onInit);
				}	
			}
		}
		protected function initData() : Boolean
		{
			m_serverList		= ServerList._getInstance();
			var list : Array	= m_serverList.kindOption;
			m_listCount 		= list.length;
			if(m_listCount <= 0 ) return false;
			
			m_data = new Vector.<Object>;
			for(var i : uint = 0; i<m_listCount;i++) 
			{
				var kind : KindOption = list[i];
				if(kind) {
					var obj : Object= new Object;
					obj.index 		= kind.index;
					obj.kindName	= kind.name;
					obj.kindID 		= kind.wKindID;
					obj.status		= kind.status;
					obj.path 		= kind.exe;
					obj.bitmapData  = kind.iconBitmapData;
					m_data.push(obj);
				}
			}
			m_data.sort(onSortData);
			return true;
		}
		private function onSortData(obj1 : Object,obj2 : Object) : int
		{
			if(obj1.index > obj2.index)  {
				return 1;
			}else if(obj1.index < obj2.index) {
				return -1;
			}
			return 0;
		}
		
		private function onInit(e : Event = null) : void
		{
			if(e != null) {
				this.removeEventListener(Event.ADDED_TO_STAGE,onInit);
			}
			
			m_listItem = new Vector.<KindItemSprite>();
			if( onCreateKindItemVector() ) {
				for (var i:int = 0; i < m_listItem.length; i++) {
					if( m_listItem[i] != null )
					{
						m_listItem[i].ShowRoom( m_data[i],i );
						m_listItem[i].addEventListener(MouseEvent.CLICK,onSelectRoom);
						if( -1 == m_serverList.m_wCurrentKind ) {
							m_serverList.m_wCurrentKind = m_data[i].kindID;
						}
					}
				}
			}
		}
		protected function onCreateKindItemVector() : Boolean
		{
			return true;
		}
		protected function onCreateKindItemView() : KindItemSprite
		{
			return null;
		}
		protected function onSelectRoom( e : MouseEvent) : void
		{
			var listBtn : KindItemSprite = e.target as KindItemSprite;
			if(listBtn != null) { 
				m_serverList.m_wCurrentKind = listBtn.KindID;
				Controller.dispatchEvent('LIST_EVENT_SELECT',listBtn.KindID);
			}
		}
	}
}