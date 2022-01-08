package protocol;
import haxe.ds.IntMap;
import net.RUDP;
import openfl.utils.Function;
import openfl.utils.Object;
/**
 * ...
 * @author Christopher Speciale
 */
class NetEventDispatcher
{

	public var communications:RUDP;

	private var _eventMap:IntMap<Function>;

	public function new(?communications:RUDP)
	{
		_eventMap = new IntMap();
		if (communications != null)
		{
			this.communications = communications;
		}
	}

	public function addNetEventListener(event:Int, listener:Function):Void
	{
		_eventMap.set(event, listener);
	}

	public function removeNetEventListener(event:Int):Void
	{
		_eventMap.remove(event);
	}

	public function dispatchNetEvent(event:Int, ?data:Object):Void
	{
		if (_eventMap.exists(event)) _eventMap.get(event)();
	}

}