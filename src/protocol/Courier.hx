package protocol;
import haxe.CallStack;
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
	private var _netEventDispatcher:NetEventDispatcher;
	private static inline var MAX_UINT:UInt = -1;
	public function new(netEventDispatcher:NetEventDispatcher) 
	{
		_netEventDispatcher = netEventDispatcher;
		
		_peerRegistry = new StringMap();
		_peerKeys = new StringMap();
		
	}
	
	public function onConnect(e:RUDPEvent):Void{
		var peer:Peer = Peer._getPeer(e.connection, _netEventDispatcher);
		_peerRegistry.set(e.connection.hash, peer);
		_requestPeerID(peer);
	}
	
	public function onClose(e:RUDPEvent):Void{
		
	}
	
	public function onError(e:RUDPEvent):Void{
		
	}	
	
	
	public function onData(data:ByteArray, connection:Connection):Void{
		
		var hash:String = connection.hash;
		
		if (_peerRegistry.exists(hash)){
			var peer:Peer = _peerRegistry.get(hash);
			peer._receiveData(data, peer);
		}
		
		
		
	}
	
	private function _makeKey():String{
		var rng:UInt = Std.int(Math.random() * MAX_UINT);
		return Sha1.encode(Std.string(rng));		
	}
	private function _generatePeerKey(peer:Peer):String{
		
		var key:String = _makeKey();
		
		while (_peerKeys.exists(key + peer.connection.hash)){
			key = _makeKey();	
		}
		
		peer.key = key;
		var timeoutID:UInt = Lib.setTimeout(_discardPeerKey, 30000, [peer, key]);
		_peerKeys.set(key + peer.connection.hash, timeoutID);
		
		return key;
	}
	
	private function _discardPeerKey(peer:Peer, key:String, stopTimeout:Bool = false):Bool{
		var isValid:Bool = false;
		key = key + peer.connection.hash;
		if (stopTimeout){
			if (_peerKeys.exists(key)){
				isValid = true;
			}
		} else {			
			peer.close();			
		}
		
		if (_peerKeys.exists(key)){
			Lib.clearTimeout(_peerKeys.get(key));
			_peerKeys.remove(key);	
		}		
		
		return isValid;
		
	}
	
	private function _requestPeerID(peer:Peer):Void{
		var key:String = _generatePeerKey(peer);
		var payload:Payload = new Payload(EventCommandsEnum.sharePeerID, {"key":key});
		peer.send(payload);
		
	}
	
	private function _addEntryNode(connection:Connection){
		
		
	}
	
}