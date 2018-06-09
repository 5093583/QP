package cx.ip
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import t.cx.air.file.TPather;
	import t.cx.air.utils.Memory;

	public class IPScanner
	{
		[Embed(source="QQWry.dat",mimeType="application/octet-stream")]
//		[Embed(source="qqwryall.dat",mimeType="application/octet-stream")]
		private var qqwry : Class;
		
		private static var _instance : IPScanner;
		public static function _getInstance() : IPScanner
		{
			return _instance == null?(_instance = new IPScanner()):_instance;
		}
		public function IPScanner()
		{
			init();
		}
		private var _bytes : ByteArray;
		private var _reg : RegExp = /^((\d{1,2}|1\d{2}|2[0-4]\d{1}|25[0-5])\.){3}(\d{1,2}|1\d{2}|2[0-4]\d{1}|25[0-5])$/;
		private var _firstStartIpOffset : int;
		private var _lastStartIpOffset 	: int;
		private var _ipCount 			: int;
		public function get Count() : int
		{
			return _ipCount;
		}
		
		private function init() : void
		{
			_bytes= new qqwry();
			//_bytes.endian = Endian.LITTLE_ENDIAN;
			var tbyte : ByteArray = new ByteArray();//Memory._newLiEndianBytes();
			Memory._copyMemory(tbyte,_bytes,8,0,0);
			
			_firstStartIpOffset = ((tbyte[0] + (tbyte[1] * 0x100)) + ((tbyte[2] * 0x100) * 0x100)) + (((tbyte[3] * 0x100) * 0x100) * 0x100);
			_lastStartIpOffset = ((tbyte[4] + (tbyte[5] * 0x100)) + ((tbyte[6] * 0x100) * 0x100)) + (((tbyte[7] * 0x100) * 0x100) * 0x100);
			_ipCount = (_lastStartIpOffset - _firstStartIpOffset) / 7.0;
			if (_ipCount <= 1)
			{
				throw new Error('ip地址文件获取错误');
			}
		}
		private function IpToInt( ip : String ) : int
		{
			if (ip.split('.').length == 3)
			{
				ip = ip + ".0";
			}
			var strs : Array = ip.split('.');
			var num2 : int = ( ( parseInt(strs[0]) * 0x100 ) * 0x100) * 0x100;
			var num3 : int = (parseInt(strs[1]) * 0x100) * 0x100;
			var num4 : int = parseInt(strs[2]) * 0x100;
			var num5 : int =parseInt(strs[3]);
			return (((num2 + num3) + num4) + num5);
		}
		private function IntToIP(ip_Int : int) : String
		{
			var num : int = (ip_Int & 0xff000000) >> 0x18;
			if (num < 0)
			{
				num += 0x100;
			}
			var num2 : int = (ip_Int & 0xff0000 ) >> 0x10;
			if (num2 < 0)
			{
				num2 += 0x100;
			}
			var num3 : int= (ip_Int & 0xff00) >> 8;
			if (num3 < 0)
			{
				num3 += 0x100;
			}
			var num4 : int = ip_Int & 0xff;
			if (num4 < 0)
			{
				num4 += 0x100;
			}
			return (num.toString() + "." + num2.toString() + "." + num3.toString() + "." + num4.toString());
		}
		
		public function Query(ip : String) : IPLocation
		{
			if (!_reg.test(ip))
			{
				ip = "300.300.300.300";
			}
			var ipLocation : IPLocation = new IPLocation();
			ipLocation.ip = ip;
			var intIP : int = IpToInt(ip);
		
			if ((intIP >= IpToInt("127.0.0.1") && (intIP <= IpToInt("127.255.255.255"))))
			{
				ipLocation.country = "本机内部环回地址";
				ipLocation.local = "";
			}
			else
			{
				if ((((intIP >= IpToInt("0.0.0.0")) && (intIP <= IpToInt("2.255.255.255"))) || ((intIP >= IpToInt("64.0.0.0")) && (intIP <= IpToInt("126.255.255.255")))) ||
					((intIP >= IpToInt("58.0.0.0")) && (intIP <= IpToInt("60.255.255.255"))))
				{
					ipLocation.country = "网络保留地址";
					ipLocation.local = "";
				}
			}
			
			var right : int = _ipCount;
			var left : int = 0;
			var middle : int = 0;
			var startIp : int = 0;
			var endIpOff : Array = [0];
			var endIp : int = 0;
			var countryFlag : Array = [0];
			
			while (left < (right - 1))
			{
				middle = (right + left) / 2;
				startIp = GetStartIp(middle,endIpOff);
				if (intIP == startIp)
				{
					left = middle;
					break;
				}
				if (intIP > startIp)
				{
					left = middle;
				}
				else
				{
					right = middle;
				}
			}
			startIp = GetStartIp(left, endIpOff);
			endIp = GetEndIp(endIpOff[0], countryFlag);
			if ((startIp <= intIP) && (endIp >= intIP))
			{
				var local : Array = [''];
				ipLocation.country = GetCountry(endIpOff, countryFlag, local);
				ipLocation.local = local[0];
			}
			else
			{
//				ipLocation.country = "未知的IP地址";
				ipLocation.country = "中国";
				ipLocation.local = "";
			}
			return ipLocation;
		}
		private function GetStartIp(left : int, endIpOff : Array) : int
		{
			var leftOffset : int = _firstStartIpOffset + (left * 7);
			var buffer : ByteArray = new ByteArray;
			Memory._copyMemory(buffer,_bytes,7,0,leftOffset);
			endIpOff[0] = ( parseInt(buffer[4].toString()) + (parseInt(buffer[5].toString()) * 0x100)) + ((parseInt(buffer[6].toString()) * 0x100) * 0x100);
			return ((parseInt(buffer[0].toString()) + (parseInt(buffer[1].toString()) * 0x100)) + ((parseInt(buffer[2].toString()) * 0x100) * 0x100)) + (((parseInt(buffer[3].toString()) * 0x100) * 0x100) * 0x100);
		}
		private function GetEndIp(endIpOff : int, countryFlag : Array) : int
		{
			var buffer : ByteArray = new ByteArray;
			Memory._copyMemory(buffer,_bytes,5,0,endIpOff);
			countryFlag[0] = buffer[4];
			return ((parseInt(buffer[0].toString()) + (parseInt(buffer[1].toString()) * 0x100)) + ((parseInt(buffer[2].toString()) * 0x100) * 0x100)) + (((parseInt(buffer[3].toString()) * 0x100) * 0x100) * 0x100);
		}
		
		
		private function GetCountry( endIpOff : Array, countryFlag : Array,  local : Array) : String
		{
			var country : String = "";
			var offset : Array = [endIpOff[0] + 4];
			switch (countryFlag[0])
			{
				case 1:
				case 2:
					country = GetFlagStr(offset, countryFlag, endIpOff);
					offset[0] = endIpOff[0] + 8;
					local[0] = (1 == countryFlag[0]) ? "" : GetFlagStr(offset, countryFlag, endIpOff);
					break;
				default:
					country = GetFlagStr(offset, countryFlag, endIpOff);
					local[0] = GetFlagStr(offset, countryFlag, endIpOff);
					break;
			}
			return country;
		}
		
		private function GetFlagStr( offset : Array, countryFlag : Array, endIpOff : Array) : String
		{
			var flag : int = 0;
			var buffer : ByteArray = new ByteArray();
			
			while (true)
			{
				//用于向前累加偏移量
				var forwardOffset : int = offset[0];
				flag = _bytes[forwardOffset++];
				//没有重定向
				if (flag != 1 && flag != 2)
				{
					break;
				}
				Memory._copyMemory(buffer,_bytes,3,0,forwardOffset);
				forwardOffset += 3;
				if (flag == 2)
				{
					countryFlag[0] = 2;
					endIpOff[0] = offset[0] - 4;
				}
				offset[0] = (parseInt(buffer[0].toString()) + (parseInt(buffer[1].toString()) * 0x100)) + ((parseInt(buffer[2].toString()) * 0x100) * 0x100);
			}
			if (offset[0] < 12)
			{
				return "";
			}
			return GetStr(offset);
		}
		private function GetStr(offset : Array) : String
		{
			var lowByte : uint = 0;
			var highByte : uint = 0;
			var stringBuilder : String = '';
			var bytes : ByteArray = new ByteArray();
			bytes.writeByte(0);
			bytes.writeByte(0);
			while (true)
			{
				lowByte = _bytes[offset[0]++];
				if (lowByte == 0)
				{
					return stringBuilder;
				}
				if (lowByte > 0x7f)
				{
					highByte = _bytes[offset[0]++];
					bytes[0] = lowByte;
					bytes[1] = highByte;
					if (highByte == 0)
					{
						return stringBuilder;
					}
					bytes.position = 0;
					stringBuilder += bytes.readMultiByte(2,'gb2312');
				}
				else
				{
					stringBuilder += (lowByte.toString());
				}
			}
			return stringBuilder;
		}
		
	}
}