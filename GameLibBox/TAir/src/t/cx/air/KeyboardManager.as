package t.cx.air
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	
	import t.cx.air.utils.HashMap;

	public class KeyboardManager
	{
		private static var _instance : KeyboardManager;
		public static function _GetInstance() : KeyboardManager
		{
			return _instance == null ? _instance = new KeyboardManager() : _instance;
		}
		private var _bInited : Boolean;
		private var _stage : Stage;
		private var _keyCallFun : Dictionary;
		
		public static const KEY_UP 	: String = 'key_up';
		public static const KEY_DOWN: String = 'key_down';
		public function KeyboardManager()
		{
		}
		public function Init(stage : Stage) : void
		{
			if(_bInited) {
				throw new Error('init be inited');
				return;
			}
			_bInited = true;
			_stage = stage;
			if(_stage) {
				_stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownEvent);
				_stage.addEventListener(KeyboardEvent.KEY_UP,keyUpEvent);
			}
			_keyCallFun = new Dictionary();
		}
		
		private function keyDownEvent(event : KeyboardEvent) : void
		{
			for each(var Fun:* in _keyCallFun){
				if(Fun != null) {
					Fun(event.target,KEY_DOWN,event);
				}
			}
		}
		private function keyUpEvent(event : KeyboardEvent) : void
		{
			for each(var Fun:* in _keyCallFun){
				if(Fun != null) {
					Fun(event.target,KEY_UP,event);
				}
			}
		}
		private function containsKey(key : String):Boolean
		{
			if(_keyCallFun[key] != undefined){
				return true;
			}
			return false;
		}
		public function RemoveKeyListern(key : String) : void
		{
			var exist:Boolean = containsKey(key);
			if(!exist){ return; }
			delete _keyCallFun[key];
		}
		public function AddKeyListern(key : String,CallBack : Function) : void
		{
			if(key == null){
				throw new ArgumentError("cannot put a value with undefined or null key!");
				return;
			}else if(CallBack == null){
				RemoveKeyListern(key);
				return;
			}else{
				_keyCallFun[key] = CallBack;
			}
		}
	}
}