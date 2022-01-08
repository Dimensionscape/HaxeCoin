package protocol;
import net.Connection;
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
	private var _target:NetEventDispatcher;
	public function new(?target:NetEventDispatcher) 
	{
		_target = target;
	}
	
	
	public function reciever(data:ByteArray, connection:Connection):Void{
		
		trace("courier got data");
		//_target.dispatchNetEvent(data.event, data.data);
	}
	
}