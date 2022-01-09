package protocol;
import haxe.ds.EnumValueMap;
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

	private var _eventMap:EnumValueMap<EnumValue, Function>;

	public function new(?communications:RUDP)
	{
		_eventMap = new EnumValueMap();
		if (communications != null)
		{
			this.communications = communications;
		}
	}

	public function addNetEventListener(event:EnumValue, listener:Function):Void
	{
		_eventMap.set(event, listener);
	}

	public function removeNetEventListener(event:EnumValue):Void
	{
		_eventMap.remove(event);
	}

	public function dispatchNetEvent(event:EnumValue, ?data:Object):Void
	{
		if (_eventMap.exists(event)) _eventMap.get(event)();
	}

}