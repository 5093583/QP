package t.cx.air.file
{
	public class TFileLoadVO
	{
		public function TFileLoadVO(url_ : String,index_ : uint ,target_ : String,local_ : String,comFun : Function,
									errFun : Function= null,progFun : Function = null)
		{
			_url = url_;
			_target = target_;
			_local = local_;
			_index = index_;
			_comFun = comFun;
			_errFun = errFun;
			_progFun = progFun;
		}
		private var _url : String;
		public function get url() : String
		{
			return _url;
		}
		private var _target : String;
		public function get target() : String
		{
			return _target;
		}
		private var _local : String;
		public function get local() : String
		{
			return _local;
		}
		
		private var _comFun : Function;
		public function get comFunction() : Function
		{
			return _comFun;
		}
		
		private var _errFun : Function;
		public function get errFunction() : Function
		{
			return _errFun;
		}
		
		private var _progFun : Function;
		public function get progFunction() : Function
		{
			return _progFun;
		}
		private var _index : uint;
		public function  get index() : uint
		{
			return _index;
		}
		
		public function Destroy() : void
		{
			_url = null;
			_target = null;
			_local = null;
			_comFun = null;
			_errFun = null;
			_progFun = null;
		}
	}
}