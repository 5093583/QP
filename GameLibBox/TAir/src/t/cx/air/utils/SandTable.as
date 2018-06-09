package  t.cx.air.utils
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.core.Application;
	import mx.formatters.DateFormatter;

	public class SandTable
	{
		private static var _instance : SandTable; 
		public static function GetInstance() : SandTable
		{
			return _instance == null ? ( _instance = new SandTable() ) : _instance;
		}
		
		private var oldid:String;  
	 	private var reg:RegExp = /<id>.*<\/id>/;
		
		public function SandTable()
		{
			
		}
		
		public function CreateSand(dos : DisplayObject) : void
		{
			var df:DateFormatter = new DateFormatter();  
			df.formatString = "YYYYMMDDHHNNSS";  
			var time:String = df.format(new Date());  
			var newid:String = "<id>CXClient"+time+"</id>";
			var f:File =new File(File.applicationDirectory.resolvePath("CXClient-app.xml").nativePath);
			if(!f.exists)
			{
				throw new Error('application。xml 文件不存在');
				return;
			}
			var fs:FileStream = new FileStream();
			fs.open(f,FileMode.READ);
			var str:String = new String(fs.readUTFBytes(fs.bytesAvailable));
			oldid = str.match(reg).toString();
			str = str.replace(reg,newid);
			fs.open(f,FileMode.WRITE);
			fs.writeUTFBytes(str);
			fs.close();
			
			/**
			 * 有多个在运行的程序时只关闭一个运行程序就无法再打开新程序
			 * 必须监听系统最后一个相同程序关闭时，才能初始化id 
			 * 解决办法：  
			 * 记录运行前id,若为初始ID则在关闭该程序时初始化id,否则不操作 
			 * */
			if(oldid == "<id>CXClient</id>")
			{
				dos.addEventListener(Event.CLOSE,returnId);  
			}
			
		}
		
		private function returnId(e : Event) : void
		{
			var f:File =new File(File.applicationDirectory.resolvePath("CXClient-app.xml").nativePath);
			var fs:FileStream = new FileStream();
			fs.open(f,FileMode.READ);
			var str:String = new String(fs.readUTFBytes(fs.bytesAvailable));
			str = str.replace(reg,oldid);
			fs.open(f,FileMode.WRITE);
			fs.writeUTFBytes(str);
			fs.close();
		}
	}
}