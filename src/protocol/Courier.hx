package protocol;
import haxe.crypto.Sha1;
import haxe.ds.IntMap;
import haxe.ds.ObjectMap;
import haxe.ds.StringMap;
import net.Connection;
import net.RUDPEvent;
import openfl.Lib;
import openfl.events.DatagramSocketDataEvent;
import openfl.utils.ByteArray;
import openfl.utils.Function;
import openfl.utils.Object;

/**
 * ...
 * @author Christopher Speciale
 */
@:access(protocol.Peer)
class Courier 
{
	private var _peerRegistry:StringMap<Peer>;	
	private var _peerKeys:StringMap<Int>;
	private static inline var MAX_UINT:UInt = -1;
	public function new() 
	{
		_peerRegistry = new StringMap();
		_peerKeys = new StringMap();
		
	}
	
	public function onConnect(e:RUDPEvent):Void{
		var peer:Peer = Peer._getPeer(e.connection);
		_peerRegistry.set(e.connection.hash, peer);
		_requestPeerID(peer);
	}
	
	public function onClose(e:RUDPEvent):Void{
		
	}
	
	public function onError(e:RUDPEvent):Void{
		
	}	
	
	
	public function onData(data:ByteArray, connection:Connection):Void{
		
		trace("courier got data");
		//_target.dispatchNetEvent(data.event, data.data);
		//var length
	}
	
	private function _generatePeerKey():String{
		
		var key:String = "";
		
		while (_peerKeys.exists(key)){
			var rng:UInt = Std.int(Math.random() * MAX_UINT);
			key = Sha1.encode(Std.string(rng));		
		}
		
		var timeoutID:UInt = Lib.setTimeout(_discardPeerKey, 30000, [key]);
		_peerKeys.set(key, timeoutID);
		
		return key;
	}
	
	private function _discardPeerKey(key:String, stopTimeout:Bool = false):Void{
		if (stopTimeout){
			if (_peerKeys.exists(key)){
				Lib.clearTimeout(_peerKeys.get(key));
			}
		}
		
		_peerKeys.remove(key);
		
	}
	
	private function _requestPeerID(peer:Peer):Void{
		var key:String = _generatePeerKey();
		var payload:Payload = new Payload(EventCommandsEnum.sharePeerID);
		peer.send(payload);
		
	}
	
	private function _addEntryNode(connection:Connection){
		
		
	}
	
}