package protocol;
import haxe.ds.IntMap;
import openfl.utils.Function;
import openfl.utils.Object;
/**
 * ...
 * @author Christopher Speciale
 */
class NetEventDispatcher{

	private var _eventMap:IntMap<Function>;
	
	public function new()
	{
		_eventMap = new IntMap();		
		
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