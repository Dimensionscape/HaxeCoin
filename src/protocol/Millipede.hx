package protocol;

import core.HaxeCoin;
import haxe.ds.StringMap;
import net.Connection;
import openfl.utils.Function;
import protocol.NodeType;
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
@:access(protocol.Node)
@:access(protocol.Peer)
@:access(protocol.EventCommands)
@:access(protocol.Courier)
class Millipede extends NetEventDispatcher
{
	public static var current:Millipede;
	
	public var node(get, null):Node;
	public var nodeType(default, null):NodeType;
	private var _courier:Courier;
	private var _endpointIterator:Iterator<String>;
	
	private var _liteNode:LiteNode;
	private var _halfNode:HalfNode;
	private var _fullNode:FullNode;
	
	private var _eventCommands:EventCommands;
	
	private function get_node():Node{
		switch (nodeType)
		{
			case LITE_NODE:
				return _liteNode;
			case HALF_NODE:
				return _halfNode;
			case FULL_NODE:
				return _fullNode;
		}
	}
	
	
	public function new(eventCommandsC:Class<EventCommands>, eventCommandsEnum = null, nodeType:NodeType = LITE_NODE)
	{
		super();
			
		current = this;
		_loadEventCommands(eventCommandsC, eventCommandsEnum);
		
		this.nodeType = nodeType;
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
	
	private function _loadEventCommands(eventCommandsC:Class<EventCommands>, ?eventCommandsEnum:Enum<Dynamic>):Void{
		_eventCommands = Type.createInstance(eventCommandsC, []);
		_eventCommands._millipede = this;
		
		
		var commandFields:Array<String> = Type.getInstanceFields(eventCommandsC);
		var commandEnums:Array<EventCommandsEnum> =  Type.allEnums(EventCommandsEnum);
		var commandMap:StringMap<EnumValue> = new StringMap();
		
		for (value in commandEnums){			
			commandMap.set(Std.string(value), value);
		}
		
		
		if (eventCommandsEnum != null){
			var extraCommandEnums:Array<EnumValue> = Type.allEnums(eventCommandsEnum);
				for (value in extraCommandEnums){
					commandMap.set(Std.string(value), value);
				}
		}
		
		var commandMethodFields:Array<String> = [];
		for (field in commandFields){
			if (Reflect.isFunction(Reflect.field(_eventCommands, field))){
				commandMethodFields.push(field);
			}
		}
		
		for (field in commandMethodFields){
			var index:EnumValue = commandMap.get(field);
			var method:Function = Reflect.field(_eventCommands, field);
			this.addNetEventListener(index, method);
			
			trace(index, method);
		}
		
		
	}
	
	private function _onConnectToEndpoint(e:RUDPEvent):Void
	{
		trace("Connected to " + e.connection.hash);
		communications.onConnect = _courier.onConnect;
		communications.onError = _courier.onError;		
		
		//_courier._addEntryNode(e.connection);
		
		//node._addPeer(Peer._getPeer(e.connection, FULL_NODE));
		_courier.onConnect(e);
		
	}

	private function _onError(e:RUDPErrorEvent):Void
	{
		if (e.error == CONNECTION_ERROR)
		{
			_findOpenEndpoint();
		}
		else if (e.error == ERROR)
		{
			//log(e.errorMessage);
			trace(e.errorMessage);
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
				_onError(new RUDPErrorEvent(RUDPErrorEvent.ERROR, false, false, ERROR, "Malformed endpoint address detected"));
			}

		}
		else
		{
			_onError(new RUDPErrorEvent(RUDPErrorEvent.ERROR, false, false, ERROR, "Could not find an open endpoint"));
		}
	}

	private function _setupLiteNode():Void
	{
		_setupClient();
		_liteNode = new LiteNode(this);
	}

	private function _setupHalfNode():Void
	{
		_setupClient();
		_halfNode = new HalfNode(this);
	}

	private function _setupFullNode():Void
	{
		communications.localAddress = HaxeCoin.current.config.ip;
		communications.localPort = HaxeCoin.current.config.port;
		communications.start(_courier.onData, _courier.onConnect, _courier.onClose, _courier.onError, SERVER);
		
		_fullNode = new FullNode(this);
	}

	private function _setupClient():Void
	{
		communications.start(_courier.onData, _onConnectToEndpoint, _courier.onClose, _onError);
		_findOpenEndpoint();
	}
	public function connectToPeer(ip:String, port:UInt):Void
	{
		communications.connect(ip, port);
	}
	
}