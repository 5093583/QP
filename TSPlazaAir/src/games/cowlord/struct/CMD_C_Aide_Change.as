package games.cowlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;

	public class CMD_C_Aide_Change
	{
		
		public var m_bAideReson:int;		//2各区域结果
		public var cbAreaWin:Array;
		
		
		public function CMD_C_Aide_Change()
		{
			cbAreaWin = Memory._newArrayAndSetValue( 5, 0 );
		}
		
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			BYTE.write(m_bAideReson, bytes);
			for(var i:int=0; i<5; i++)
			{
				BYTE.write(cbAreaWin[i], bytes);
			}
			return bytes;
		}
		public function get size() : uint
		{
			return 1+5;
		}
		
	}
}