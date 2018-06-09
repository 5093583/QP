package t.cx.cmd.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.TConst;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.CType.WORD;

	[Bindable]
	public class tagGameKind
	{
		public static const SIZE : int = 110;
		public var wSortID : int;							//排序号码
		private var _wTypeID : int;							//类型号码
		public function set wTypeID(val : int) : void
		{
		}
		public function get wTypeID() : int
		{
			return (wKindID / 1000);
		}
		public var wKindID : int;							//名称号码
		public var dwMaxVersion : Number;					//最新版本
		public var dwOnLineCount : Number;					//在线数目
		
		public var szKindName : String;						//游戏名字
		public var szProcessName : String;					//进程名字
		public var szKindIcon : String;						//游戏图标
		
		public function tagGameKind()
		{
		}
		public static function _readByteArray(bytes : ByteArray) : tagGameKind
		{
			var result : tagGameKind 	= new tagGameKind();
			result.wSortID 				= WORD.read(bytes);
			result._wTypeID 				= WORD.read(bytes);
			result.wKindID 				= WORD.read(bytes);
			result.dwMaxVersion 		= LONG.read(bytes);
			result.dwOnLineCount 		= LONG.read(bytes);
			
			result.szKindName = TCHAR.read(bytes,32);
			result.szProcessName = TCHAR.read(bytes,TConst.MODULE_LEN);
			result.szKindIcon = TCHAR.read(bytes,TConst.ICON_LEN);
			return result;
		}
	}
}