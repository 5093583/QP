package cx.client.logon.model.vo
{
	import flash.display.BitmapData;
	import flash.utils.flash_proxy;
	
	import t.cx.air.file.TPather;

	public class KindOption
	{
		private var _wKindID : int;
		public function get wKindID() : int
		{
			return _wKindID;
		}
		private var _index : int;
		public function get index() : int
		{
			return _index;
		}
		private var _width : Number;
		public function get width() : Number
		{
			return _width;
		}
		private var _height : Number;
		public function get height() : Number
		{
			return _height;
		}
		private var _type : String;
		public function get type() : String
		{
			return _type;
		}
		private var _icon : String;
		public function get icon() : String
		{
			return _icon;
		}
		
		private var _iconBitmapData : BitmapData;
		public function get iconBitmapData() : BitmapData
		{
			if(_iconBitmapData == null) return null;
			return _iconBitmapData.clone();
		}
		private var _bigIcon : String;
		private var _iconBigBitmapData : BitmapData;
		public function get iconBigBitmapData() : BitmapData
		{
			if(_iconBigBitmapData==null) return null;
			return _iconBigBitmapData.clone();
		}
		private var _exe : String;
		public function get exe() : String
		{
			return _exe;
		}
		private var _name : String;
		public function get name() : String
		{
			return _name;
		}
		private var _describe : String;
		public function get describe() : String
		{
			return _describe;
		}
		public function get tip() : String
		{
			var str : String = '系统正在为您分配座位...';
			return str;
		}
		private var _recommend : Boolean;
		public function get recommend() : Boolean
		{
			return _recommend;
		}
		private var _downInfo : GameDownInfo;
		public function get downInfo() : GameDownInfo
		{
			return _downInfo;
		}
		private var _status : uint;				
		/**
		 * 0:正常
		 * 1：敬请期待
		 * 2:推荐
		 * 3:热门
		 * */
		public function get status() : uint
		{
			return _status;
		}
		public var bRequestRoom : Boolean;
		public function KindOption(option : XML)
		{
			_wKindID	= option.@kindID;
			_index		= option.index;
			_width		= option.@width;
			_width		= isNaN(_width) ? 1010:_width;
			_height		= option.@height;
			_height		= isNaN(_height)? 730 : _height;
			_type		= option.@type;
			_type		= _type==null?'game2d':_type;
			_recommend 	= option.@recommend == 'true';
			_icon 		= option.icon;
			if(option.hasOwnProperty('bigicon')){
				_bigIcon = option.bigicon;
				if(TPather._exist(TPather._fullPath(_bigIcon))) {  _iconBigBitmapData = TPather._readFile(_bigIcon,'png');  }
			}
			if(TPather._exist(TPather._fullPath(_icon)) ) {_iconBitmapData = TPather._readFile(_icon,'png');}
			_name		= option.name;
			_exe		= option.exe;
			_describe	= option.describe;
			_status		= option.@status;
			var donws : XMLList = option.child('down');
			if(donws != null && donws.length() > 0) {
				_downInfo = new GameDownInfo(donws[0]);
			}
			bRequestRoom = false;
		}
		public function UpdateIcon() : void
		{
			if(TPather._exist(TPather._fullPath(_icon))) {
				_iconBitmapData = TPather._readFile(_icon,'png');
			}
		}
	}
}