package cx.client.logon.model.vo
{
	public class AdVo
	{
		private var _index : uint;
		public function get index() : uint
		{
			return  _index;
		}
		
		private var _img : String;
		public function get img() : String
		{
			return  _img;
		}
		
		private var _tip : String;
		public function get tip() : String
		{
			return  _tip;
		}
		
		private var _link : String;
		public function get link() : String
		{
			return  _link;
		}
		
		public function AdVo(xml : XML)
		{
			_index = xml.index;
			_tip = xml.tip;
			_img = xml.img;
			_link = xml.link;
		}
	}
}