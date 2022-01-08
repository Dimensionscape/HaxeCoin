package protocol;

import net.NodeType;
import openfl.utils.ByteArray;
import openfl.utils.Object;
import net.RUDP;
/**
 * ...
 * @author Christopher Speciale
 */
class Peer 
{
	public var nodeType(default, null):NodeType;
	
	private var payloadLength:Int;
	
	private var _readBuffer:ByteArray;	
	
	@:noCompletion private function new(ip:String, port:Int, nodeType:NodeType) 
	{
		_readBuffer = new ByteArray();
		
		this.nodeType = nodeType;
		
		switch(nodeType){
			case LITE_NODE:
				setupLiteNode();
			case HALF_NODE:
				setupHalfNode();
			case FULL_NODE:
				setupFullNode();
		}	
	}
	
	public function setupLiteNode():Void{
		trace("light");
	}
	
	public function setupHalfNode():Void{
		trace("half");
	}
	
	public function setupFullNode():Void{
		trace("full");
	}
	
	public function updateDelta():Void{
		
	}
	
	
	//private function receive(
	public static function connect(ip:String, port:Int, nodeType:NodeType = LITE_NODE):Peer{
		return new Peer(ip, port, nodeType);
	}
	
	
}