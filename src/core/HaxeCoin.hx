package core;
import haxe.Json;
import net.INode;
import openfl.Assets;

/**
 * ...
 * @author Christopher Speciale
 */
class HaxeCoin 
{
	public static var current(get, null):HaxeCoin;
	
	private static var _this:HaxeCoin;
	
	public static function get_current():HaxeCoin{
		return _this;
	}
	
	public var config(get, null):IConfig;

	private var _config:IConfig;
	private var _agent:Agent;
	
	private function get_config():IConfig{
		return _config;
	}
	
	private function new() 
	{		
		
	}
	
	private function _start(?config:Config){
		if (config == null){
			_loadFromConfigFile();
		} else {
			_config = config;
			_loadFromConfigObject();
		}
	}
	
	private function _loadFromConfigFile():Void{
		_config = Json.parse(Assets.getText("cfg/config.json"));
		_loadFromConfigObject();
	}
	
	private function _loadFromConfigObject():Void{
		_agent = new Agent();
	}
	
	public static function start(?config:Config):HaxeCoin{
		_this = new HaxeCoin();
		_this._start(config);
		return _this;
	}
	
}