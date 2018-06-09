package t.cx.cmd.struct
{
	
	import flash.utils.ByteArray;
	
	import t.cx.air.TConst;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.CType.WORD;
	
	public class tagGameType
	{
		public static const SIZE : int = 36; 
		public var wSortID : int;							//排序号码
		public var wTypeID : int;							//种类号码
		public var szTypeName : String;						//种类名字
		public function tagGameType()
		{
		}
		public static function _readByteArray(bytes : ByteArray) : tagGameType
		{
			var result : tagGameType = new tagGameType();
			result.wSortID = WORD.read(bytes);
			result.wTypeID = WORD.read(bytes);
			result.szTypeName = TCHAR.read(bytes,TConst.TYPE_LEN);
			return result; 
		}
	}
}