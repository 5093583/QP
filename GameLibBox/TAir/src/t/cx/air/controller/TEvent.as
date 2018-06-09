package t.cx.air.controller
{
	import flash.events.Event;
	
	public class TEvent extends Event
	{
		//---------------------------------
		//---------------------------------
		public var m_nMsg:int;
		private var m_nWParam:*;
		private var m_nLParam:*;
		
		public function get nWParam() : *
		{
			return m_nWParam;
		}
		
		public function get nLParam() : *
		{
			return m_nLParam;
		}
		
		public function TEvent(strName:String,
								nMsg:int=0,
								nWParam:*=null,
								nLParam:*=null):void
		{
			super(strName);
			m_nMsg = nMsg;
			m_nWParam = nWParam;
			m_nLParam = nLParam;
		}
		
		public static function CreateEvent(strName : String, nMsg:int=0,
										   nWParam:*=null,
										   nLParam:*=null) : TEvent
		{
			var e : TEvent = new TEvent(strName,nMsg,nWParam,nLParam);
			return e;
		}
	}
}