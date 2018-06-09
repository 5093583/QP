package cx.client.logon.view.message
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.system.ApplicationDomain;
	
	import t.cx.air.TConst;
	
	public class Message
	{
		public static const MSG_NORMAL 	: uint = 0;
		public static const MSG_WARN 		: uint = 1;
		public static const MSG_ERROR 	: uint = 2;
		private static var _view : MessageItem;
		
		public function Message()
		{
			
		}
		public static function show(msg : String,type : uint= MSG_ERROR,closeHandle : Function = null) : void
		{
			if(TConst.TC_MSGContiner == null) {
				trace('message show [' +type + ':]'+msg);
				return;
			}
			if(_view == null) {
				var c : Class = ApplicationDomain.currentDomain.getDefinition('MessageMovie') as Class;
				_view = new c();
			}
			if(!TConst.TC_MSGContiner.contains(_view)) {
				TConst.TC_MSGContiner.addChildAt(_view,TConst.TC_MSGContiner.numChildren-1);
			}else {
				TConst.TC_MSGContiner.setChildIndex(_view,TConst.TC_MSGContiner.numChildren-1);
			}
			_view.SetContainer(msg,type,closeHandle);
		}
	}
}