package utils;
import openfl.filesystem.File;
import openfl.filesystem.FileMode;
import openfl.filesystem.FileStream;
import openfl.utils.ByteArray;

/**
 * ...
 * @author Christopher Speciale
 */
class FileHelper 
{

	public static function overwrite(file:File, data:ByteArray):Void{
		var filestream:FileStream = new FileStream();
		filestream.open(file, WRITE);
		filestream.writeBytes(data);
		filestream.close();
	}
	
	public static function load(file:File):ByteArray {
		var filestream:FileStream = new FileStream();
		filestream.open(file, READ);
		var fileBytes:ByteArray = new ByteArray();
		filestream.readBytes(fileBytes);
		fileBytes.position = 0;
		filestream.close();
		return fileBytes;
	}
	
}