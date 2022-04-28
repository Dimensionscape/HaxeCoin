package protocol;
import openfl.filesystem.File;
import openfl.utils.ByteArray;
import openfl.utils.Object;
import utils.FileHelper;
import utils.JSON;

/**
 * ...
 * @author Christopher Speciale
 */
class Bootstrapper 
{
	public var endpoints(get, null):Array<String>;
	
	private var _bootstrapFile:File;
	private var _bootstrapObject:Object;
	
	private function new() 
	{
		_bootstrapFile = File.applicationStorageDirectory.resolvePath("data\\bootstrap.joc");
		_fileRedundancyCheck();
				
		_bootstrapObject = JSON.decompress(FileHelper.load(_bootstrapFile)).object;	
		
	}
	
	//how do we prevent nodes from trolling with massive endpoint lists?
	public function concatEndpoints(endpoints:Array<String>):Array<String>{
		var existingEndpoints:Array<String> = _bootstrapObject.endpoints;
		for (endpoint in endpoints){
			if (!existingEndpoints.contains(endpoint)){
				existingEndpoints.push(endpoint);
			}
		}
		
		var missingEndpoints:Array<String> = [];
		
		for (endpoint in existingEndpoints){
			if (!endpoints.contains(endpoint)){
				missingEndpoints.push(endpoint);
			}
		}
		return missingEndpoints;
	}
	
	public function concatVerifiedEndpoints(endpoints:Array<String>):Void{
		
	}
	
	private function _fileRedundancyCheck():Void{
		if (!_bootstrapFile.exists){
			FileHelper.overwrite(_bootstrapFile, _bootstrapObject == null ? newBootstrapData() : (_bootstrapObject:JSON).compressedBytes);			
		}
	}
	
	private function newBootstrapData():ByteArray{
		var bootstrapObject:Object = new Object();
		bootstrapObject.endpoints = [];
		var bootstrapJson:JSON = bootstrapObject;
		return bootstrapJson.compressedBytes;
	}
	
	private function get_endpoints():Array<String>{
		return _bootstrapObject.endpoints;
	}
}