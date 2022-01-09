package protocol;

import core.HaxeCoin;
import net.Connection;
import protocol.NodeType;
import openfl.errors.Error;
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
	public var id:String = "";
	
	private var connection:Connection;
	
	private var payloadLength:Int;
	
	private var _readBuffer:ByteArray;
	private var _writeBuffer:ByteArray;
	
	@:noCompletion private function new(connection:Connection) 
	{
		_readBuffer = new ByteArray();		
		_writeBuffer = new ByteArray();
		
		this.connection = connection;
	
	}	
	
	//public function updateDelta():Void{
	//	
	//}
	
	
	
	public function send(payload:IPayload):Void{
		trace('requesting peer id');
		_writeBuffer.position = 4;
		_writeBuffer.writeObject(payload);
		_writeBuffer.position = 0;
		_writeBuffer.writeUnsignedInt(_writeBuffer.length - 4);
		
		connection.send(_writeBuffer);
	}
	
	
	private static function _getPeer(connection:Connection):Peer{
		return new Peer(connection);
	}
	
	
}