package t.cx.air.controller
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	public class Controller
	{
		/////////////////////EventDispatcher/////////////////////////////////////////
		protected static var eventDispatcher : IEventDispatcher = new EventDispatcher();
		
		public static function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			eventDispatcher.addEventListener(type,listener,useCapture,priority,useWeakReference);
		}
		
		public static function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			eventDispatcher.removeEventListener(type,listener,useCapture);
		}
		
		public static function dispatchEvent(strName:String,nMsg :int = -1,nWParam:*= null,nLParam:* = null):Boolean
		{
			return eventDispatcher.dispatchEvent(TEvent.CreateEvent(strName,nMsg,nWParam,nLParam));
		}
		
		public static function hasEventListener(type:String):Boolean
		{
			return eventDispatcher.hasEventListener(type);
		}
		public static function willTrigger(type:String):Boolean
		{
			return	eventDispatcher.willTrigger(type);
		}
		
		///////////////////////////////////////////////////////
	}
}