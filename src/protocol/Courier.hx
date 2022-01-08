package protocol;
import haxe.ds.StringMap;
import net.Connection;
import net.RUDPEvent;
import openfl.events.DatagramSocketDataEvent;
import openfl.utils.ByteArray;
import openfl.utils.Function;
import openfl.utils.Object;

/**
 * ...
 * @author Christopher Speciale
 */
class Courier 
{
	private var _peerRegistry:StringMap<Peer>;
	
	public function new() 
	{
		_peerRegistry = new StringMap();
		
	}
	
	public function onConnect(e:RUDPEvent):Void{
		trace("connected");
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
	
	public function sender(payload:IPayload, connection:Connection):Void{
		
	}
	
}