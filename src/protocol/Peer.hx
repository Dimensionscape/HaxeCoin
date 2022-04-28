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
	public var key:String = "";
	public var ready(default, null):Bool = false;
	
	public var connection:Connection;
	
	private var _payloadLength:Int = 0;
	
	private var _readBuffer:ByteArray;
	private var _writeBuffer:ByteArray;
	private var _millipede:Millipede;
	private var _netEventDispatcher:NetEventDispatcher;
	
	@:noCompletion private function new(connection:Connection, _netEventDispatcher) 
	{
		_readBuffer = new ByteArray();		
		_writeBuffer = new ByteArray();
		this._netEventDispatcher = _netEventDispatcher;
		this.connection = connection;
		
	}	
	
	//public function updateDelta():Void{
	//	
	//}
	
	
	
	public function send(payload:IPayload):Void{
		_writeBuffer.position = 4;
		_writeBuffer.writeObject(payload);
		_writeBuffer.position = 0;
		_writeBuffer.writeUnsignedInt(_writeBuffer.length - 4);
		
		connection.send(_writeBuffer);
	}
	
	public function close():Void{
		connection.close();
	}
	
	private function _receiveData(data:ByteArray, peer:Peer):Void{
		if (_payloadLength == 0){
			_payloadLength = data.readUnsignedInt();
			if (data.length < _payloadLength){
			_readBuffer.writeBytes(data);
			
			} else {
				_processData(data);
			}
		} else {
			
			_readBuffer.writeBytes(data);
			
			if (_payloadLength == _readBuffer.length){
					_processData(_readBuffer);
					_readBuffer.clear();
				}
		}		
	
		
	}
	
	private function _processData(data:ByteArray):Void{
		var payload:Object = data.readObject();
		trace(payload);
		_netEventDispatcher.dispatchNetEvent(new NetEvent(payload, this));
		_payloadLength = 0;
	}
	
	private static function _getPeer(connection:Connection, netEventDispatcher:NetEventDispatcher):Peer{
		return new Peer(connection, netEventDispatcher);
	}
	
	
}