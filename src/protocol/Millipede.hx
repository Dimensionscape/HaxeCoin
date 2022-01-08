package protocol;

import core.HaxeCoin;
import net.Connection;
import net.NodeType;
import net.RUDP;
import net.RUDPErrorEvent;
import net.RUDPEvent;
import net.Test;
import openfl.errors.Error;
import openfl.utils.ByteArray;

/**
 * ...
 * @author Christopher Speciale
 */
class Millipede extends NetEventDispatcher
{
	private var _courier:Courier;
	private var _endpointIterator:Iterator<String>;

	public function new(nodeType:NodeType = LITE_NODE)
	{
		super();

		communications = new RUDP();
		_courier = new Courier();

		communications.start(_courier.onData, _onConnectToEndpoint, _courier.onClose, _courier.onError, SERVER);

		switch (nodeType)
		{
			case LITE_NODE:
				_setupLiteNode();
			case HALF_NODE:
				_setupHalfNode();
			case FULL_NODE:
				_setupFullNode();
		}

		//var p:Peer = Peer.connect("adfsasdf", 234234);
		//_udp.start((_courier = new Courier(this)).reciever, onConnect, onClose, onError);
		//_udp.connect("192.168.1.197", 34970);
		//var ba:ByteArray = new ByteArray();
		//ba.writeUTF("Hello World4");
		//_udp.connect("192.168.1.197", 34970);
		//_udp.send(ba, "192.168.1.197", 34970);

	}

	private function _onConnectToEndpoint(e:RUDPEvent):Void
	{
		communications.onConnect = _courier.onConnect;
		communications.onError = _courier.onError;
	}

	private function _onError(e:RUDPErrorEvent):Void
	{
		trace("error", e.error);
		if (e.error == CONNECTION_ERROR)
		{
			_findOpenEndpoint();
		}
	}

	private function _findOpenEndpoint():Void
	{

		if (_endpointIterator == null)
		{
			_endpointIterator = HaxeCoin.current.config.remoteEndpoints.iterator();
		}
		if (_endpointIterator.hasNext())
		{
			try
			{
				var endpoint:Array<String> = (_endpointIterator.next():String).split(":");
				var ip:String = endpoint[0];
				var port:UInt = Std.parseInt(endpoint[1]);
				communications.connect(ip, port);
			}
			catch (e)
			{
				throw new Error("Malformed endpoint address detected");
			}

		}
		else {
			throw new Error("Could not find an open endpoint");
		}

	}

	private function _setupLiteNode():Void
	{
		_setupClient();
	}

	private function _setupHalfNode():Void
	{
		_setupClient();
	}

	private function _setupFullNode():Void
	{
		communications.localAddress = HaxeCoin.current.config.ip;
		communications.localPort = HaxeCoin.current.config.port;
		communications.start(_courier.onData, _onConnectToEndpoint, _courier.onClose, _courier.onError, SERVER);
	}

	private function _setupClient():Void
	{
		communications.start(_courier.onData, _courier.onConnect, _courier.onClose, _onError);
		_findOpenEndpoint();
	}
	public function connectToPeer(ip:String, port:UInt):Void
	{
		communications.connect(ip, port);
	}

}