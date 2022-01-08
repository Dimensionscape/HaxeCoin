package core;
import net.Peer;
import net.IFullNode;
import net.INode;
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
		protocol = new Millipede();
		//connection = Connection.connect(HaxeCoin.current.config.ip, HaxeCoin.current.config.port, HaxeCoin.current.config.nodeType);
		Lib.current.addEventListener(Event.ENTER_FRAME, _onDeltaUpdate);
	}
	
	
	private function _onDeltaUpdate(e:Event):Void{
		//connection.updateDelta();
	}
	
	
}