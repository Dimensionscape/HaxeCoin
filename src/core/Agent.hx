package core;
import protocol.EventCommands;
import protocol.Peer;
import openfl.Lib;
import openfl.events.Event;
import protocol.Millipede;

/**
 * ...
 * @author Christopher Speciale
 */
class Agent 
{
	public var protocol:Millipede;
	//public var connection:Connection<INode>;
	public function new() 
	{
		protocol = new Millipede(HXEventCommands, HXEventCommandsEnum);
		//connection = Connection.connect(HaxeCoin.current.config.ip, HaxeCoin.current.config.port, HaxeCoin.current.config.nodeType);
		Lib.current.addEventListener(Event.ENTER_FRAME, _onDeltaUpdate);
	}
	
	
	private function _onDeltaUpdate(e:Event):Void{
		//connection.updateDelta();
	}
	
	
}