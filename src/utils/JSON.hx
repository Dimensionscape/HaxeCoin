package utils;
import haxe.Json;
import openfl.errors.Error;
import openfl.utils.ByteArray;
import openfl.utils.CompressionAlgorithm;
import openfl.utils.Object;

/**
 * ...
 * @author Christopher Speciale
 */
abstract JSON(String)
{

	public var object(get, never):Object;
	public var compressedBytes(get, never):ByteArray;

	private inline function get_object():Object
	{
		return Json.parse(this);
	}

	private inline function get_compressedBytes():ByteArray
	{
		return compress(this);
	}

	public inline function new(?value:String)
	{
		if (value!=null)
		{
			try
			{
				Json.parse(value);
				this = value;
			}
			catch (err:Dynamic)
			{
				trace("Invalid or malformed JSON structure detected.", err);
				throw new Error("Invalid or malformed JSON structure detected.");
			}
		}
		else
		{
			this = "";

		}
	}

	@:from
	static private function fromObject(o:Object):JSON
	{
		trace("FROM OBJECT");
		if (Std.isOfType(o, String)){
			var s:String = o;
			return s;
		}
		
		return Json.stringify(o);
	}
	
	@:to
	private function toObject():ObjectType
	{
		trace("toOBJECT");
		return Json.parse(this);
	}
	
	@:from
	static private function fromString(s:String):JSON
	{

		return new JSON(s);
	}
	
	@:to
	public function toString():String
	{
		return this;
	}

	public static function compress(json:JSON, algorithm:CompressionAlgorithm = ZLIB):ByteArray
	{
		return _compress(json, algorithm);
	}

	private static function _compress(value:String, algorithm:CompressionAlgorithm):ByteArray
	{
		var whitespaceRegex:EReg = new EReg('[\t\n\r]', 'g');
		var minifiedJson:String = whitespaceRegex.replace(value, "");
		var compressionVersion:UInt = 0;

		switch (algorithm)
		{
			case DEFLATE:
				compressionVersion = 1;
			case LZMA:
				compressionVersion = 2;
			default:
				//compressionVersion is already 0
		}

		var jsonBytes:ByteArray = new ByteArray();
		jsonBytes.writeUTFBytes(minifiedJson);
		jsonBytes.compress(algorithm);
		jsonBytes.position = 0;

		var jocBytes:ByteArray = new ByteArray();
		jocBytes.writeByte(compressionVersion);
		jocBytes.writeBytes(jsonBytes);

		jsonBytes.clear();
		jsonBytes = null;

		return jocBytes;
	}

	public static function decompress(jocBytes:ByteArray):JSON
	{

		var compressionVersion:UInt = jocBytes.readByte();
		var algorithm:CompressionAlgorithm = null;

		switch (compressionVersion)
		{
			case 0:
				algorithm = ZLIB;
			case 1:
				algorithm = DEFLATE;
			case 2:
				algorithm = LZMA;
		}
		var jsonBytes:ByteArray = new ByteArray();
		jocBytes.readBytes(jsonBytes);

		jsonBytes.uncompress(algorithm);
		jsonBytes.position = 0;
		var json:JSON = new JSON(jsonBytes.readUTFBytes(jsonBytes.length));

		jsonBytes.clear();
		jsonBytes = null;
		jocBytes.clear();
		jocBytes = null;
		return json;
	}
	
	//@:arrayAccess
	private inline function _getValue(s:String):Object{
		return object[s];
	}

}