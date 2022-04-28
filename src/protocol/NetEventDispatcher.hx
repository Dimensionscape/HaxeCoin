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

	public function setNetEventListener(eventEnum:EnumValue, listener:Function):Void
	{
		_eventMap.set(eventEnum, listener);
		trace(eventEnum);
		trace(_eventMap.toString());
	}

	public function removeNetEventListener(eventEnum:EnumValue):Void
	{
		_eventMap.remove(eventEnum);
	}

	public function dispatchNetEvent(event:NetEvent):Void
	{
		trace("dispatch event", event.payload.eventEnum);
		var eventEnum:EnumValue = event.payload.eventEnum;
		if (_eventMap.exists(eventEnum)) _eventMap.get(eventEnum)(event);
		
	}

}