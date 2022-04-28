package protocol;

/**
 * ...
 * @author Christopher Speciale
 */
@:keep
class EventCommands
{

	private var _millipede:Millipede;
	public function new()
	{

		trace("loading event commands");
	}

	public function sharePeerID(e:NetEvent):Void
	{
		if (e.payload.op == 1)
		{
			//maybe instead of __discardPeerKey, we use an alternative method that makes it clear its returning a valid boolean check
			//on whether or not this peer is a valid peer
			if (@:privateAccess Millipede.current._courier._discardPeerKey(e.peer, e.payload.data.key, true)){
			
				/*if (!e.peer.connection.isIncoming){
					if (Millipede.current.node.intent == BOOTSTRAP){
						Millipede.current.node.bootstrapNode = e.peer;
					}
					e.peer.id = e.payload.data;			
					e.payload.eventEnum = EventCommandsEnum.declareIntent;
					e.payload.data = {intent:Millipede.current.node.intent};
					e.payload.op = 0;
					e.peer.send(e.payload);
				}			*/		
				
				
				e.peer.id = e.payload.data.id;
				@:privateAccess e.peer.nodeType = e.payload.data.nodeType;
			} else{
				e.peer.close();
			}
			
		}
		else {			
				e.payload.data = {
					key:e.payload.data.key,
					id:Millipede.current.node.peerID,
					nodeType:Millipede.current.node.nodeType
				};
				e.payload.op = 1;
				e.peer.send(e.payload);			
		}

	}
	
	public function declareIntent(e:NetEvent):Void{
		switch((e.payload.data.intent:Intent)){
			case Intent.BOOTSTRAP:
				e.payload.op = 0;
				e.payload.data = Millipede.current.bootstrapper.endpoints;
				///e.payload.eventEnum = bootstrap;
				e.peer.send(e.payload);		
			case Intent.ANCHOR:
				trace("achnor");
			default:
				trace("default");
		}
	}
	
	public function bootstrap(e:NetEvent):Void{
		/*if(e.payload.op == 0){
		var reciprocalEndpoints:Array<String> = Millipede.current.bootstrapper.concatEndpoints(e.payload.data.endpoints);
		e.payload.op = 1;
		e.payload.data = Millipede.current.bootstrapper.endpoints;
		e.payload.eventEnum = bootstrap;
		e.peer.send(e.payload);		
		}else if(e.payload.op == 1){
			Millipede.current.bootstrapper.concatVerifiedEndpoints(e.payload.data.endpoints);
		}*/
	}
	
	
}