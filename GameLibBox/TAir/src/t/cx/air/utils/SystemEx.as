package t.cx.air.utils
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.LocalConnection;
	import flash.system.System;
	
	import t.cx.air.TDas;

	public class SystemEx
	{
		import flash.net.NetworkInfo;
		import flash.net.NetworkInterface;
		public function SystemEx()
		{
		}
		public static function _clientSequence(bt : Boolean = false) : String
		{
			var clientmac : String='',i : uint = 0, j : uint;
			var path:String = File.userDirectory.nativePath;
			path += '\\Adobe\\clientA\\clientSequenceA.seq';
			var filesys : FileStream = new FileStream();
			var file : File = new File(path);
			if(!file.exists)
			{
				clientmac = TDas._getStringItem('gameMac',32);
				if(clientmac== null || clientmac=='')
				{
					//var inter : Vector.<NetworkInterface> = NetworkInfo.networkInfo.findInterfaces();
					var netinfo:NetworkInfo=NetworkInfo.networkInfo;
					var inter:Vector.<NetworkInterface>=netinfo.findInterfaces();
					if(inter != null)
					{
						var name : String = inter[0].name;
						var mac : String  = inter[0].hardwareAddress;
					}
					if(mac == '' || mac == null)
					{
						var date:Date = new Date;
						mac = date.fullYear.toString() + date.month + date.day + date.hours + date.minutes + date.seconds + date.milliseconds;
						mac += int(Math.random()*10000);
					}
					clientmac = MD5.hash(mac).toLocaleUpperCase();
				}
				filesys.open(file,FileMode.WRITE);
				filesys.writeUTF(clientmac);
				filesys.close();
				return clientmac;
			}else {
				filesys.open(file,FileMode.READ);
				clientmac = filesys.readUTF();
				return clientmac;
			}
			return '';
		}
		
		public static function _froceGC() : void
		{
			try {
				var conn1:LocalConnection = new LocalConnection();
				var conn2:LocalConnection = new LocalConnection();
				conn1.connect('_froceGC');
				conn2.connect('_froceGC1');
				
			}catch(err : Error){ System.gc() }
			
		}
	}
}