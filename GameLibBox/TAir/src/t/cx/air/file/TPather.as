package t.cx.air.file
{
	import flash.display.BitmapData;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	import t.cx.air.TConst;
	import t.cx.air.utils.CType.TCHAR;
	
	public class TPather
	{
		private static const FILE_VONVERSION	: uint = 0xFF00FF;
		public function TPather()
		{
		}
		public static function _fullPath(file : String) : String
		{
			return File.applicationDirectory.nativePath + '\\' + file;	
		}
		public static function _readFile(file : String,returnType : String = 'xml') : *
		{
			var tempFile : File = new File(_fullPath(file));
			if(!tempFile.exists) return null;
			var stream:FileStream = new FileStream();
			stream.open(tempFile,FileMode.READ);
			var result : *;
			switch(returnType)
			{
				case 'xml':
				{
					result = new XML(stream.readUTFBytes(stream.bytesAvailable));
					break;
				}
				case 'str':
				{
					result = stream.readUTFBytes(stream.bytesAvailable);
					break;
				}
				case 'bytes':
				{
					result = new ByteArray;
					stream.readBytes( result );
					if(TConst.TC_DEUBG != 1) { result = _decodeSwf(result); }
					break;
				}
				case 'png':
				{
					var bytes : ByteArray = new ByteArray();
					stream.readBytes( bytes );
					result = _decodePng(bytes);
					break;
				}
				case 'file':
				{
					result = new ByteArray;
					stream.readBytes( result );
				}
			}
			stream.close();
			return result;
		}
		public static function _pngToByteArray(bytes : ByteArray,w : int,h : int):ByteArray
		{
			bytes.position = bytes.length; 
			bytes.writeShort(h);
			bytes.writeShort(w); 
			bytes.writeInt(FILE_VONVERSION);
			bytes.position = 0;
			bytes.compress();
			return bytes;
		}
		
		public static function _decodePng(bytes : ByteArray) : BitmapData
		{
			bytes.uncompress();
			var bmd:ByteArray= bytes;
			bmd.position = bmd.length - 4;
			var version : uint = bmd.readInt();
			if(version != FILE_VONVERSION) return null;
			
			bmd.position=bmd.length-6;
			var imageWidth:int = bmd.readShort();
			bmd.position=bmd.length-8;
			var imageHeight:int= bmd.readShort();
			
			var copyBmp:BitmapData = new BitmapData( imageWidth, imageHeight, true ,0x00000000);
			bmd.position = 0;
			copyBmp.setPixels(new Rectangle(0,0,imageWidth,imageHeight),bmd);
			return copyBmp;
		}
		public static function _swfToByteArray(bytes : ByteArray,name : String,w : Number,h : Number) : ByteArray
		{
			bytes.position = bytes.length;
			bytes.writeShort(h);
			bytes.writeShort(w);
			TCHAR.write(name,bytes,32);
			bytes.writeInt(FILE_VONVERSION);
			
			bytes.position = 0;
			bytes.compress();
			return bytes;
		}
		public static function _decodeSwf(bytes : ByteArray) : ByteArray
		{
			bytes.uncompress();
			var swf:ByteArray = new ByteArray();
			bytes.position = bytes.length - 4;
			var version : uint = bytes.readInt();
			if(version != FILE_VONVERSION) return null;
			
			bytes.position = 0;
			bytes.readBytes(swf,0,bytes.length - 40);
			swf.position = 0;
			return swf;
		}
		public static function _exist(filePath : String) : Boolean
		{
			var file : File = new File(filePath);
			return file.exists;
		}
		public static function _deletFile(filePath : String) : Boolean
		{
			if( _exist( _fullPath(filePath) ) )
			{
				var file : File = new File( _fullPath(filePath) );
				file.deleteFile();
				return true
			}
			return false;
		}
	}
}