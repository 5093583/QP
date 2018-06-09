package cx.client.logon.view.Plaza.kindroom
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class KindItemSprite extends MovieClip
	{
		private var _data : Object;
		protected function get data() : Object
		{
			return _data;
		}
		public function get KindID() : int
		{
			return _data.kindID;
		}
		
		private var _index : int;
		public function get index() : int
		{
			return _index;
		}
		public function KindItemSprite()
		{
			super();
			this.gotoAndStop(1);
			this.visible = false;
		}
		
		public function ShowRoom(obj : Object,index : int) : void
		{
			_data = obj;
			_index = index;
			if(_data == null) return;
			if(obj.status == 1) {  this.gotoAndStop(2);  }
			this.visible = true;
			kindName = obj.kindName;
		}
		public function HideRoom() : void
		{
			this.visible = false;
			kindName = '';
			_data = null;
		}
		protected function set kindName(val : String) : void
		{
			
		}
		
	}
}