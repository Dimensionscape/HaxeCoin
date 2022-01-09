package protocol;
import haxe.crypto.Sha1;
import haxe.ds.StringMap;
import lime.tools.GUID;
import protocol.NodeType;

/**
 * ...
 * @author Christopher Speciale
 */
class Node implements INode
{
	public var nodeType(default, null):NodeType;
	public var neighborCount(get, null):UInt;
	public var peerID(get, null):String;
	
	public var fullNodeCount(default, null):UInt = 0;
	public var halfNodeCount(default, null):UInt = 0;
	public var liteNodeCount(default, null):UInt = 0;
	
	private var _neighborCount:UInt = 0;
	private var _millipede:Millipede;
	private var _liteNodes:StringMap<Peer>;
	private var _halfNodes:StringMap<Peer>;
	private var _fullNodes:StringMap<Peer>;
	private var _peerID:String;
	
	private function get_neighborCount():UInt{
		return fullNodeCount + halfNodeCount + liteNodeCount;
	}
	
	private function get_peerID():String{
		return _peerID;
	}
	
	private function new(millipede:Millipede)
	{
		_millipede = millipede;
		_liteNodes = new StringMap();
		_halfNodes = new StringMap();
		_fullNodes = new StringMap();

		if (Std.isOfType(this, LiteNode))
		{
			nodeType = LITE_NODE;
		}
		else if (Std.isOfType(this, HalfNode))
		{
			nodeType = HALF_NODE;
		}
		else if (Std.isOfType(this, FullNode))
		{
			nodeType = FULL_NODE;
		}
		
		_generatePeerID();
	}
	
	private function _generatePeerID():Void{
		var uuid:String = GUID.uuid();
		uuid = Sha1.encode(uuid);
		_peerID = uuid;
		
	}
	
	private function _addPeer(peer:Peer):Void
	{
		switch (peer.nodeType)
		{
			case LITE_NODE:
				_liteNodes.set(peer.id, peer);
				liteNodeCount++;
			case HALF_NODE:
				_halfNodes.set(peer.id, peer);
				halfNodeCount++;
			case FULL_NODE:
				_fullNodes.set(peer.id, peer);
				fullNodeCount++;
		}
	}

	private function _removePeer(peer:Peer):Void
	{
		switch (peer.nodeType)
		{
			case LITE_NODE:
				if (_liteNodes.exists(peer.id)) {
					_liteNodes.remove(peer.id);
					liteNodeCount--;
				}
			case HALF_NODE:
				if (_halfNodes.exists(peer.id)){
					_halfNodes.remove(peer.id);
					halfNodeCount--;
				}
				
			case FULL_NODE:
				if (_fullNodes.exists(peer.id)){
					_fullNodes.remove(peer.id);
					fullNodeCount--;
				}
		}
	}

}