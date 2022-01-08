package blockchain;

import haxe.Json;
import haxe.crypto.Sha256;
import openfl.utils.Object;
/**
 * ...
 * @author Christopher Speciale
 */
class Block
{

	private var _thisBlock:Object;

	public var data(get, null):Object;
	public var timestamp(get, set):Float;
	public var hash(get, null):String;
	public var prevHash(get, null):String;
	public var nonce(get, set):Int;
	public var difficulty(get, set):Int;
	
	private var _hasSeed:Bool = false;
	private var _seed:Int = 0;
	private var _isWritable:Bool = true;
	
	private var _difficultyMatch:String;

	private function get_difficulty():Int
	{
		return _difficultyMatch.length - 1;
	}

	public function set_difficulty(value:Int):Int
	{

		_difficultyMatch = _getDifficultyMatch(value);
		return value;
	}

	private function get_nonce():Int
	{
		return _thisBlock.nonce;
	}

	private function set_nonce(value:Int):Int
	{
		return _thisBlock.nonce = value;
	}
	private function get_data():Object
	{
		return _thisBlock.data;
	}

	private function get_timestamp():Float
	{
		return _thisBlock.timestamp;
	}

	private function set_timestamp(value:Float):Float
	{
		return _thisBlock.timestamp = value;
	}

	private function get_hash():String
	{
		return Sha256.encode(prevHash + Std.string(timestamp) + Json.stringify(data) + Std.string(nonce));
	}

	private function get_prevHash():String
	{
		return _thisBlock.prevHash;
	}
	public function new(timestamp:Float, data:Object, prevBlock:Block = null)
	{
		_thisBlock = new Object();
		_thisBlock.data = data;
		_thisBlock.timestamp = timestamp;
		_thisBlock.prevHash = prevBlock == null ? "" : prevBlock.hash;
		_thisBlock.nonce = 0;
	}

	public function mine(difficulty:UInt = 0, ?seed:Null<Int>):Bool
	{
		if (!_hasSeed && seed == null){
			_seed = 0;
			_hasSeed = true;
		} else
		if(_hasSeed){
			_seed++;
		}
		_thisBlock.nonce = _hasSeed ? _seed : seed;
		this.difficulty = difficulty;
		return _isBlock();
	}
	
	public function writeData(data:Object):Void{
		_thisBlock.data = data;
	}
	
	public function toString():String{
		return Json.stringify(_thisBlock);
	}
	private function _isBlock():Bool
	{
		return hash.indexOf(_difficultyMatch) == 0 ? true : false;
	}

	private function _getDifficultyMatch(value:Int):String
	{
		var match:String = "";
		for (i in 0...value + 1)
		{
			match += "0";
		}
		return match;
	}

}