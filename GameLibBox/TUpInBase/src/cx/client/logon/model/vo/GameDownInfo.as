package cx.client.logon.model.vo
{
	public class GameDownInfo
	{
		private var _main : String;
		public function get main() : String
		{
			return _main;
		}
		private var _icon : String;
		public function get icon() : String
		{
			return _icon;
		}
		private var _sound : String;
		public function get sound() : String
		{
			return _sound;
		}
		public function GameDownInfo(xml : XML)
		{
			_main = xml.main;
			_icon = xml.icon;
			_sound = xml.sound;
		}
	}
}