package net;

import openfl.utils.Object;
import net.RUDP;
/**
 * ...
 * @author Christopher Speciale
 */
class Peer<T> 
{
	public var node:T;
	private var _nodeType:String;
	
	private function new(ip:String, port:Int, nodeType:String) 
	{
		node = new Object();
		_nodeType = nodeType;
		
		switch(_nodeType){
			case NodeType.LITE_NODE:
				setupLiteNode();
			case NodeType.HALF_NODE:
				setupHalfNode();
			case NodeType.FULL_NODE:
				setupFullNode();
		}
	}
	
	public function setupLiteNode():Void{
		
	}
	
	public function setupHalfNode():Void{
		
	}
	
	public function setupFullNode():Void{
		new RUDP();
	}
	
	public function updateDelta():Void{
		
	}
	
	public static function connect(ip:String, port:Int, nodeType:String):Peer<INode>{
		return new Peer(ip, port, nodeType);
	}
	
}