package t.cx.air.utils
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class Memory
	{
		public static function _copyMemory(dst:ByteArray , src:ByteArray , length:uint = 0,
										  	 dst_offset:uint = 0, src_offset:uint = 0) : void
		{
			var old_pos:int = src.position;
			src.position = src_offset;
			src.readBytes(dst,dst_offset,length);
			src.position = old_pos;
		}
		
		public static function _newArray(length:uint,c:Class = null):Array
		{
			var result:Array = new Array(length);
			if(c != null)
			{
				for(var i:uint = 0; i < length; i ++)
				{
					result[i] = new c;
				}
			}
			return result;
		}
		public static function _newTwoDimension(row:uint,col : uint,value : * = 0):Array
		{
			var result:Array = new Array(row);
			var src : Array;
			for(var i : uint = 0;i<row;i++)
			{
				result[i] = new Array(col);
				for(var j : uint = 0;j<col;j++)
				{
					result[i][j] = value;
				}
			}
			return result;
		}
		public static function _newArrayAndSetValue(length:uint,v:* = 0):Array
		{
			var result:Array = new Array(length);
			
			for(var i:uint = 0; i < length; i ++)
			{
				result[i] = v;
			}
			return result;
		}
		
		public static function _newArrayByCopy(src:Array,length:uint = 0, src_offset:uint = 0):Array
		{
			if(src == null || length == 0)
				length = src.length;
			var result:Array = new Array(length);
			for(var i:uint = 0; i < length; i ++)
			{
				result[i] = src[src_offset + i];
			}
			
			return result;
		}
		
		public static function _copyArray(dst:Array,src:Array,length:uint = 0,
										 	dst_offset:uint = 0, src_offset:uint = 0):void 
		{
			if(length == 0 && src != null)
				length = src.length;
			for(var i:uint = 0; i < length; i ++)
			{
				dst[dst_offset + i] = src[src_offset + i];
			}
		}
		
		public static function _eachArray(dst:Array,func:Function):void 
		{
			if(dst == null || func == null)
				return;
			for(var i:uint = 0; i < dst.length; i ++)
			{
				if(dst[i])
				{
					func(dst[i]);
				}
			}
		}
		
		public static function _copyTwoDimensionArray(dst:Array,src:Array,length:uint = 0,
									   					dst_offset:uint = 0, src_offset:uint = 0):void
		{
			if(src == null)
				return;
			for(var i:uint = 0; i < length; i ++)
			{
				dst[dst_offset + i] = src[src_offset + i];
			}
		}
		public static function _eachTwoDimensionArray(dst:Array,func:Function):void 
		{
			if(dst == null || func == null)
				return;
			for(var i:uint = 0; i < dst.length; i ++)
			{
				if(dst[i])
				{
					for(var k:uint = 0; k < dst[i].length; k ++)
					{
						if(dst[i][k])
						{
							func(dst[i][k]);
						}
					}
				}
			}
		}
		public static function _freeTwoDimensionArray(dst:Array,
									  					val:* = null,
									  					func:Function = null):void 
		{
			if(dst == null)
				return;
			for(var i:uint = 0; i < dst.length; i ++)
			{
				if(dst[i])
				{
					for(var k:uint = 0; k < dst[i].length; k ++)
					{
						if(dst[i][k] && func != null)
						{
							func(dst[i][k]);
						}
						dst[i][k] = val;
					}
					dst[i] = null;
				}
			}
		}
		public static function _zeroArray(src:Array,val:* = 0,func:Function=null,length:int=0):void 
		{
			if(src == null)
				return;
			if(length <= 0)
				length = src.length;
			for(var i:uint = 0; i < length; i ++)
			{
				if(func != null && src[i])
				{
					func(src[i]);
				}
				src[i] = val;
			}
		}
		
		public static function _zeroTwoDimensionArray(src:Array,val:* = 0,func:Function=null):void 
		{
			if(src == null)
				return;
			for(var i:uint = 0; i < src.length; i ++)
			{
				if(src[i])
				{
					var a:Array = src[i];
					if(a)
					{
						for(var j:uint = 0; j < a.length; j ++)
						{
							if(func != null && a[j]) {
								func(a[j]);
							}
							a[j] = val;
						}
					}
				}
			}
		}
		
		public static function _cloneArray( src:Array, beginIndex:uint ):Array
		{
			if(src == null)
				return null;
			var result:Array = new Array;
			var n:uint = 0;
			for(var i:uint = beginIndex; i < src.length; i ++)
			{
				result[n] = src[i];
				n ++;
			}
			return result;
		}
		public static function _moveArray(dst:Array,src:Array,length:uint = 0,
						  					dst_offset:uint = 0, src_offset:uint = 0):void 
		{
			for(var i:uint = 0; i < length;i++)
			{
				dst[dst_offset + i] = src[src_offset + i];
			}
		}
		public static function _moveMemory(dst:ByteArray,src:ByteArray,length:uint = 0,
										  dst_offset:uint = 0, src_offset:uint = 0):void
		{
			var old_pos:int = src.position;
			src.position = src_offset;
			src.readBytes(dst,dst_offset,length);
			src.position = old_pos;
		}
		
		public static function _memset( dst:ByteArray,val:int,size:int,pos:int=0 ):void 
		{
			var old_pos:int = dst.position;
			dst.position = pos;
			for (var i:int = 0; i < size; i ++) {
				dst.writeByte(val);
			}
			dst.position = old_pos;
		}
		
		public static function _memsetByBytes( dst:ByteArray,val:ByteArray,length:uint = 0,
								   					dst_offset:uint = 0, val_offset:uint = 0 ):void 
		{
			var old_pos:int = dst.position;
			dst.position = dst_offset;
			var old_pos1:int = val.position;
			val.position = val_offset;
			dst.writeBytes(val,val_offset,length);
			val.position = old_pos1;
			dst.position = old_pos;
		}
		
		//计算字符串UTF-8编码长度
		public static function _getStringLength( src:String,charSet : String = 'utf-8' ):Number
		{
			var nLen:int;
			var srcBytsLength:ByteArray = new ByteArray;
			srcBytsLength.writeMultiByte(src,charSet);
			nLen = srcBytsLength.length;
			return nLen;
		}
		
		//写入文本到内存字节流
		public static function _writeStringToBytes( dst:ByteArray,val:String,length:uint,charSet : String = 'utf-8' ):void
		{
			var nValLen:int = _getStringLength(val,charSet);
			switch(charSet)
			{
				case 'utf-8':
				{
					dst.writeMultiByte(val,'utf-8');
					break;
				}
				case 'gb2312':
				{
					dst.writeMultiByte(val,charSet);
					break;
				}
				default:
				{
					dst.writeMultiByte(val,charSet);
					break;
				}
			}
			for (var i:int = 0; i < (length - nValLen); i++) {
				dst.writeByte(0);
			}
		}
		//读取文本从内存字节流
		public static function _readStringByBytes(dst:ByteArray,length:uint):String
		{
			if(length > (dst.length - dst.position))
				length =  dst.length - dst.position;
			return dst.readUTFBytes(length);
		}
		
		public static function _newLiEndianBytes():ByteArray
		{
			var result:ByteArray = new ByteArray;
			result.endian = Endian.LITTLE_ENDIAN;
			return result;
		}
		
		//获取高字节
		public static function _hiByte(w:uint):uint
		{
			return (w & 0x0000ff00) >> 8;
		}
		//获取低字节
		public static function _loByte(w:uint):uint
		{
			return (w & 0x000000ff);
		}
		//判断大小
		public static function _min(a:*,b:*):*
		{
			return (((a) < (b)) ? (a) : (b));
		}
		//判断大小
		public static function _max(a:*,b:*):*
		{
			return (((a) > (b)) ? (a) : (b));
		}
	}
}