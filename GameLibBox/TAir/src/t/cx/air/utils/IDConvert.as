package t.cx.air.utils
{
	import t.cx.air.TConst;

	public class IDConvert
	{
		public function IDConvert()
		{
		}
		private static var _startVer  : int = 0;
		private static const _id2v : Array = 		
			[ 	
				[	[4,0,9,6,1,3,5,7,2,8], [1,8,0,9,5,3,4,2,7,6], [6,5,1,2,7,3,0,8,9,4], [6,3,7,0,4,2,1,9,8,5], [1,6,8,3,5,0,7,2,4,9],
					[8,5,2,4,6,9,3,1,7,0], [2,9,0,4,6,8,3,5,1,7], [7,5,9,2,8,4,6,0,3,1], [9,2,0,8,1,4,7,5,3,6], [1,3,2,7,8,9,6,5,0,4] 
				],
				[
					[3,5,6,0,8,4,9,2,7,1], [8,5,0,6,2,7,3,9,4,1], [9,4,5,0,6,1,3,2,7,8], [8,7,1,3,9,4,0,5,2,6], [9,6,2,1,4,8,3,5,7,0],
					[9,6,1,5,8,3,7,2,0,4], [8,6,1,3,9,5,2,0,7,4], [4,1,7,2,5,3,0,8,9,6], [2,5,0,6,9,7,1,4,3,8], [9,7,0,5,1,3,8,2,4,6]
				],
				
				[
					[7,0,8,5,1,3,9,4,6,2], [5,1,7,2,3,6,8,9,0,4], [3,6,9,4,8,0,5,2,7,1], [0,7,5,9,2,4,6,3,1,8], [9,4,0,8,7,6,2,3,5,1],
					[5,1,8,2,6,0,4,3,9,7], [5,7,8,9,0,6,3,2,4,1], [0,2,4,5,1,9,6,7,8,3], [6,4,2,5,3,0,9,7,1,8], [5,3,6,0,9,2,4,7,8,1],
				],
				[
					[6,1,8,7,4,9,0,3,5,2], [8,4,3,5,6,2,9,7,1,0], [6,2,7,0,8,3,4,5,1,9], [4,3,2,5,9,7,1,8,6,0], [8,2,4,9,7,5,1,3,0,6],
					[8,4,3,1,7,2,9,0,6,5], [1,5,4,2,9,0,6,3,7,8], [5,6,1,0,7,2,9,4,8,3], [8,3,7,2,0,6,4,1,5,9], [5,3,6,9,7,0,4,8,2,1],
				],
				[
					[4,3,2,8,0,1,5,6,7,9], [7,5,8,2,6,0,3,4,1,9], [0,9,5,6,2,8,1,3,4,7], [9,8,0,4,6,7,2,3,1,5], [8,9,3,0,4,1,2,6,5,7],
					[9,3,4,5,2,7,0,1,8,6], [7,3,4,8,6,9,1,2,0,5], [0,5,1,8,7,6,9,4,3,2], [4,8,0,6,1,7,2,5,9,3], [0,1,4,2,7,3,6,5,9,8],
				],
			];
		
		private static const _v2id : Array = 
			[ 	
				[	
					[1,4,8,5,0,6,3,7,9,2], [2,0,7,5,6,4,9,8,1,3], [6,2,3,5,9,1,0,4,7,8], [3,6,5,1,4,9,0,2,8,7], [5,0,7,3,8,4,1,6,2,9],
					[9,7,2,6,3,1,4,8,0,5], [2,8,0,6,3,7,4,9,5,1], [7,9,3,8,5,1,6,0,4,2], [2,4,1,8,5,7,9,6,3,0], [8,0,2,1,9,7,6,3,4,5]
				],
				[
					[3,9,7,0,5,1,2,8,4,6], [2,9,4,6,8,1,3,5,0,7], [3,5,7,6,1,2,4,8,9,0], [6,2,8,3,5,7,9,1,0,4], [9,3,2,6,4,7,1,8,5,0],
					[8,2,7,5,9,3,1,6,4,0], [7,2,6,3,9,5,1,8,0,4], [6,1,3,5,0,4,9,2,7,8], [2,6,0,8,7,1,3,5,9,4], [2,4,7,5,8,3,9,1,6,0]
				],
				
				[
					[1,4,9,5,7,3,8,0,2,6], [8,1,3,4,9,0,5,2,6,7], [5,9,7,0,3,6,1,8,4,2], [0,8,4,7,5,2,6,1,9,3], [2,9,6,7,1,8,5,4,3,0],
					[5,1,3,7,6,0,4,9,2,8], [4,9,7,6,8,0,5,1,2,3], [0,4,1,9,2,3,6,7,8,5], [5,8,2,4,1,3,0,7,9,6], [3,9,5,1,6,0,2,7,8,4]
				],
				[ 
					[6,1,9,7,4,8,0,3,2,5], [9,8,5,2,1,3,4,7,0,6], [3,8,1,5,6,7,0,2,4,9], [9,6,2,1,0,3,8,5,7,4], [8,6,1,7,2,5,9,4,0,3],
					[7,3,5,2,1,9,8,4,0,6], [5,0,3,7,2,1,6,8,9,4], [3,2,5,9,7,0,1,4,8,6], [4,7,3,1,6,8,5,2,0,9], [5,9,8,1,6,0,2,4,7,3]
				],
				[
					[4,5,2,1,0,6,7,8,3,9], [5,8,3,6,7,1,4,0,2,9], [0,6,4,7,8,2,3,9,5,1], [2,8,6,7,3,9,4,5,1,0], [3,5,6,2,4,8,7,9,0,1],
					[6,7,4,1,2,3,9,5,8,0], [8,6,7,1,2,9,4,0,3,5], [0,2,9,8,7,1,5,4,3,6], [2,4,6,9,0,7,3,5,1,8], [0,1,3,5,2,7,6,4,9,8]
				]
			];
		public static function Id2View(id : int) : int
		{
			
			return parseInt(_viewId(id));
		}
		public static function View2Id(viewId : int) : int
		{
			return parseInt(_viewId(viewId,true));
		}
		private static function _viewId(id : int,bViewToId : Boolean = false) : String
		{
			
			if(id <= 0) return '0';
			if(TConst.TC_IDCONVER >=0)
			{
				return bViewToId?(id - TConst.TC_IDCONVER).toString():(TConst.TC_IDCONVER + id).toString();
			}
			var idStr : String = id.toString();
			var resultId : String = '',i : uint = 0,fval : uint=_startVer,tempVal : int = 0;
			var len : int = idStr.length;
			var tempArrs : Array = bViewToId?_v2id:_id2v;
			while(len < tempArrs.length)
			{
				idStr = '0' + idStr;
				len++;
			}
			for( i=0;i<len;i++)
			{
				if( i >= tempArrs.length)
				{
					resultId = idStr.toString().substr(len-i-1,1) + resultId;
				}else {
					tempVal = tempArrs[i][fval][ parseInt( idStr.toString().substr(len-i-1,1) )];
					if(bViewToId) {
						fval = parseInt( idStr.toString().substr(len-i-1,1) );
					}else {
						fval = tempVal;
					}
					id = tempVal + id;
					resultId = tempVal + resultId;
				}
			}
			return resultId;
		}
		
	}
}