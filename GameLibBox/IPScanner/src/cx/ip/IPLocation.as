package cx.ip
{
	public class IPLocation
	{
		private var _ip : String;
		public function set ip(val : String) : void
		{
			_ip = val;
		}
		public function get ip() : String
		{
			return _ip;
		}
		private var _country : String;
		public function set country(val : String) : void
		{
			_country = val;
		}
		public function get country() : String
		{
			return _country;
		}
		private var _local : String;
		public function set local(val : String) : void
		{
			_local = val;
		}
		public function get local() : String
		{
			return _local;
		}
		public function IPLocation()
		{
			_ip = '';
			_local = '';
			_country = '';
		}
	}
}