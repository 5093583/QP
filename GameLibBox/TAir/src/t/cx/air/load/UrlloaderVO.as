package t.cx.air.load
{
	public class UrlloaderVO
	{
		public function UrlloaderVO(purl : String,plabel : String = 'load',pcomFun : Function=null,perrFun : Function =null,resType : uint = 0,pProrFun : Function = null)
		{
			_url = purl;
			_label = plabel;
			_com = pcomFun;
			_resType = resType;
			_err = perrFun;
			_prog = pProrFun;
		}
		private var _label : String;
		public function get label() : String
		{
			return _label;
		}
		private var _url : String;
		public function get url() : String
		{
			return _url;
		}
		
		private var _com : Function;
		public function get comFunction() : Function
		{
			return _com;
		}
		private var _err : Function;
		public function get errFunction() : Function
		{
			return _err;
		}
		private var _prog : Function;
		
		public function get progFunction() : Function
		{
			return _prog;
		}
		private var _resType : uint;
		public function get resultType() : uint
		{
			return _resType;
		}
		public function Destroy() : void
		{
			_label = null;
			_url = null;
			_com = null;
			_err = null;
			_prog = null;
		}
	}
}