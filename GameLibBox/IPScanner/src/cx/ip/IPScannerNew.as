package cx.ip
{
	import cx.ip.IpInfo;
	
	import flash.system.System;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import t.cx.air.file.TPather;
	import t.cx.air.utils.Memory;
	
	public class IPScannerNew
	{ 
//		[Embed(source="qqwryWorld.dat",mimeType="application/octet-stream")]
		[Embed(source="qqwryNew.dat",mimeType="application/octet-stream")]
		private var qqwry : Class;
		
		private static var _instance : IPScannerNew;
		public static function _getInstance() : IPScannerNew
		{
			return _instance == null?(_instance = new IPScannerNew()):_instance;
		}
		public function IPScannerNew()
		{
			init();
		}
		
		
		private var ipIndexBeginOffSet:uint;
		private var ipIndexEndOffSet:uint;
		private var ipBlockCount:Number;
		
		private var searchBeginIpInfo:IpInfo=new IpInfo();
		private var searchEndIpInfo:IpInfo=new IpInfo();
		private var searchMidIpInfo:IpInfo=new IpInfo();
		private var searchBeginPos:uint;
		private var searchEndPos:uint;
		
		private var _bytes : ByteArray;
		
		
		public function getIpnew( val:String ):String
		{
			var address:String = searchIpInfo( val );
			var index:int = address.indexOf('CZ88.NET');
			if( index != -1 )
				address = address.substring( 0, (index-1) );
			return address;
		}
		
		
		private function init() : void
		{
			_bytes= new qqwry();
			_bytes.endian = Endian.LITTLE_ENDIAN;
			
			var byteArr:ByteArray=new ByteArray();
			Memory._copyMemory(byteArr,_bytes,8,0,0);
			
			ipIndexBeginOffSet=byteArr[0]+(byteArr[1]<<8)+(byteArr[2]<<16)+(byteArr[3]<<24);
			ipIndexEndOffSet=byteArr[4]+(byteArr[5]<<8)+(byteArr[6]<<16)+(byteArr[7]<<24);
			ipBlockCount=(ipIndexEndOffSet-ipIndexBeginOffSet)/7+1;
			
			
		}
		//二分查找法搜索索引区
		private function searchIpInfo(ip:String):String
		{
			//设置二分查找法的头和尾
			this.searchBeginPos=0;
			this.searchEndPos=ipBlockCount-1;
			//加这句，不然乱码
			System.useCodePage=true;
			
			
			var subIp:Number=ipToNumber(ip);
			while (true)
			{
				//头
				searchBeginIpInfo=getIpInfo(this.searchBeginPos);
				//尾
				searchEndIpInfo=getIpInfo(this.searchEndPos);
				
				if (subIp>searchBeginIpInfo.ipBegin && subIp<searchBeginIpInfo.ipEnd)
					return readAddressInfo(searchBeginIpInfo.ipOffset);
				
				if (subIp>searchEndIpInfo.ipBegin && subIp<searchEndIpInfo.ipEnd)
					return readAddressInfo(searchEndIpInfo.ipOffset);
				
				searchMidIpInfo=getIpInfo((this.searchBeginPos+this.searchEndPos)/2)
				
				if (subIp>searchMidIpInfo.ipBegin && subIp<searchMidIpInfo.ipEnd)
					return readAddressInfo(searchMidIpInfo.ipOffset);
				
				if (subIp>searchMidIpInfo.ipEnd)
				{
					this.searchBeginPos=(this.searchBeginPos+this.searchEndPos)/2;
				}
				else
				{
					this.searchEndPos=(this.searchBeginPos+this.searchEndPos)/2;
				}
				
				if( (searchBeginPos + 1) == searchEndPos )
					return "中国";
			}
			return "中国";
		}
		//读取该
		private function readAddressInfo(pos:uint):String
		{
			var country:String="";
			var area:String="";
			var countryOffset:Number=0;
			var tag:uint;
			
			_bytes.position=pos+4;
			//读取模式
			tag=readTag();
			
			if (tag==1)
			{
				//当模式为1的时候，指向改偏移地址
				_bytes.position=getIpOffset();
				
				tag=readTag();
				//国家模式为2
				if (tag==2)
				{
					countryOffset=getIpOffset();
					
					area=this.readArea();
					
					_bytes.position=countryOffset;
					country=this.readString();
				}
				else
				{
					_bytes.position-=1;
					
					country=this.readString();
					area=this.readArea();
				}
			}
			else if (tag==2)
			{
				//当模式为2的时候，指向改偏移地址
				countryOffset=getIpOffset();
				//先读取地区**
				area=this.readArea();
				//再读取国家
				_bytes.position=countryOffset;
				country=this.readString();
				
			}
			else
			{
				_bytes.position-=1;
				
				country=this.readString();
				area=this.readArea();
			}
			
			var address:String=country+" "+area;
			
			return address;
		}
		
		//读取记录模式
		private function readTag():uint
		{
			return _bytes.readByte();
		}
		
		
		//读取地区
		private function readArea():String
		{
			var tag:uint=readTag();
			
			if (tag==1 || tag==2)
			{
				_bytes.position=getIpOffset();
				return readString(); 
			}
			else
			{
				_bytes.position-=1;
				return readString();
			}
			
		}
		
		//读取fileStream的数据
		private function readString():String
		{
			var subOffset:uint=0;
			var stringArr:ByteArray=new ByteArray();
			stringArr[subOffset]=_bytes.readByte();
			while (stringArr[subOffset]!=0)
			{
				subOffset++;
				stringArr[subOffset]=_bytes.readByte();
			}
			
			return stringArr.toString();
		}
		
		
		//根据参数pos(记录点)读取改记录的起始ip,偏移地址和结束ip;
		private function getIpInfo(pos:uint):IpInfo
		{
			_bytes.position=this.ipIndexBeginOffSet+7*pos;
			var subIpInfo:IpInfo=new IpInfo();
			subIpInfo.ipBegin=getIpNum();
			subIpInfo.ipOffset=getIpOffset();
			_bytes.position=subIpInfo.ipOffset;
			subIpInfo.ipEnd=getIpNum();
			
			return subIpInfo;
		}
		//读取ip地址
		private function getIpNum():Number
		{
			var byteArr:ByteArray=new ByteArray();
			_bytes.readBytes(byteArr,0,4);
			//return byteArr[0]|(byteArr[1]<<8)|(byteArr[2]<<16)|(byteArr[3]<<24);
			//return byteArr[0].toString()+(byteArr[1]<<8).toString()+
			//(byteArr[2]<<16)+(byteArr[3]<<24);
			return byteArr[0]+byteArr[1]*256+byteArr[2]*256*256+byteArr[3]*256*256*256;
		}
		
		//读取偏移地址
		private function getIpOffset():Number
		{
			var byteArr:ByteArray=new ByteArray();
			_bytes.readBytes(byteArr,0,3);
			
			return byteArr[0]+byteArr[1]*256+byteArr[2]*256*256;
		}
		
		
		//ip转换为数值
		private function ipToNumber(ip:String):uint
		{
			var ipArr:Array=ip.split(".");
			if (ipArr.length==4)
			{
				var _n:uint=(uint(ipArr[0]<<24))+(uint(ipArr[1]<<16))+(uint(ipArr[2]<<8))+uint(ipArr[3]);
				return _n;
			}
			else
			{
				return 0;
			}
			
		}
		
	}
}