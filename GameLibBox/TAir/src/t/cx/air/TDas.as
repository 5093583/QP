package t.cx.air
{
	import flash.data.EncryptedLocalStore;
	import flash.net.SharedObject;
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.DOUBLE;
	import t.cx.air.utils.CType.TCHAR;

	public class TDas
	{
		public function TDas()
		{
		}
		private static function get _bRutime() : Boolean
		{
			return TConst.TC_RUTIME == 'desktop';
		}
		public static function _getDoubleItem(key : String) : Number
		{
			key += TConst.TC_PUBLISHNAME;
			
			if(!_bRutime) return NaN;
			var ser : SharedObject;
			var vers : ByteArray;
			try{
				ser = SharedObject.getLocal(key);
				if(ser!=null)
				{
					return ser.data.itemNumbers as Number;
				}
			}catch(e : Error) {
				return NaN;
			}
//			var vers : ByteArray;
//			try {
//				vers = EncryptedLocalStore.getItem(key);
//			}catch(e : Error) {
//				EncryptedLocalStore.reset();
//				return NaN;
//			}
//			if(vers != null) { return DOUBLE.read(vers); }
			return NaN;
		}
		public static function _setDoubleItem(key : String,value : Number) : void
		{
			key += TConst.TC_PUBLISHNAME;
			
			if(!_bRutime) return;
//			var vers : ByteArray = new ByteArray();
//			DOUBLE.write(value,vers);
//			EncryptedLocalStore.setItem(key,vers);
			var ser : SharedObject = SharedObject.getLocal(key);
			ser.data.itemNumbers  = value;
			ser.flush();
		}
		public static function _getByteItem(key : String) : uint
		{
			key += TConst.TC_PUBLISHNAME;
			
			if(!_bRutime) return 0;
//			var vers : ByteArray;
//			try {
//				vers = EncryptedLocalStore.getItem(key);
//			}catch(e : Error) {
//				EncryptedLocalStore.reset();
//				return 0;
//			}
//			if(vers != null) { return BYTE.read(vers); }
			var ser : SharedObject;
			var vers : ByteArray;
			try{
				ser = SharedObject.getLocal(key);
				if(ser!=null)
				{
					return ser.data.itemNumbers as uint;
				}
			}catch(e : Error) {
				return 0;
			}
			return 0;
		}
		public static function _setByteItem(key : String,value : uint) : void
		{
			key += TConst.TC_PUBLISHNAME;
			
			if(!_bRutime) return;
//			var vers : ByteArray = new ByteArray();
//			BYTE.write(value,vers);
			
			var ser : SharedObject = SharedObject.getLocal(key);
			ser.data.itemNumbers = value;
			ser.flush();
		}
		public static function _getStringItem(key : String,len : uint) : String
		{
			key += TConst.TC_PUBLISHNAME;
			
			if(!_bRutime) return null;
//			var vers : ByteArray;
//			try {
//				vers = EncryptedLocalStore.getItem(key);
//			}catch(e : Error) {
//				EncryptedLocalStore.reset();
//				return null;
//			}
//			if(vers != null) { return TCHAR.read(vers,len,'utf-8'); }
			var ser : SharedObject;
			var vers : ByteArray;
			try{
				ser = SharedObject.getLocal(key);
				if(ser!=null)
				{
					return ser.data.itemNumbers as String;
				}
			}catch(e : Error) {
				return "";
			}
			return null;
		}
		public static function _setStringItem(key : String,value : String,len : uint) : void
		{
			key += TConst.TC_PUBLISHNAME;
			
			if(!_bRutime) return;
//			var vers : ByteArray = new ByteArray();
//			TCHAR.write(value,vers,len,'utf-8');
//			EncryptedLocalStore.setItem(key,vers);
//			var vers : ByteArray = new ByteArray();
//			TCHAR.write(value,vers,len,'utf-8');
			var ser : SharedObject = SharedObject.getLocal(key);
			ser.data.itemNumbers = value;
			ser.flush();
		}
		
		private static function _clearcookie(mainKey : String) : void
		{
			_setStringItem(mainKey,'',125);
		}
		public static function _setCookie(mainKey : String,subKey : String,value : String) : void
		{
			var str : String = _getStringItem(mainKey,125);
			if(str == null) { str = ''; }
			var arr : Array = str.split('|');
			var bComplete : Boolean = false;
			var obj : String,i : uint = 0;
			for(i = 0;i<arr.length;i++)
			{
				obj = arr[i];
				if(obj == '' || obj==null) { continue; }
				if(obj.indexOf(subKey) != -1)
				{
					arr[i] = '';
					arr[i] = subKey+':'+value;
					bComplete = true;
					break;
				}
			}
			if(!bComplete) { arr.push( subKey+':'+value ); }
			str = '';
			for(i = 0;i<arr.length;i++)
			{
				obj = arr[i];
				if(obj =='') continue;
				str += obj + (i==(arr.length-1)?'':'|');
			}
			_setStringItem(mainKey,str,125);
		}
		public static function _getCookie(mainKey : String,subKey : String) : String
		{
			var str : String = _getStringItem(mainKey,125);
			if(str == null) { return null; }
			var arr : Array = str.split('|');
			for each(var obj : String in arr)
			{
				if(obj == '' || obj==null) { continue; }
				if(obj.indexOf(subKey) != -1)
				{
					return obj.substring(obj.indexOf(':')+1);
				}
			}
			return null;
		}
	}
}