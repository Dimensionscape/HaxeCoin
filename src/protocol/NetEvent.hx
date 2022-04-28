package protocol;

import openfl.events.Event;

/**
 * ...
 * @author Christopher Speciale
 */
class NetEvent 
{
	public var peer:Peer;
	public var payload:IPayload;
	public function new(payload:IPayload, peer:Peer)
	{
		this.peer = peer;
		this.payload = payload;
	}
	
}