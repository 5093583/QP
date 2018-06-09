package games.cowlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;

	//记录信息
	public class tagServerGameRecord 
	{
		public static const SIZE : uint = 5;
		
		public var m_bAreaAide	: Array;

		public function tagServerGameRecord()
		{
			m_bAreaAide = Memory._newArrayAndSetValue(5,0);
		}
		
		public static function _readBuffer(bytes :ByteArray):tagServerGameRecord
		{
			var result : tagServerGameRecord = new tagServerGameRecord();
			for(var i:int=0;i<5;i++)
			{
				result.m_bAreaAide[i]=BYTE.read(bytes);
			}		
			return result;
		}

	}
}