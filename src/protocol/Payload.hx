package protocol;

import openfl.utils.Object;
import protocol.IPayload;
/**
 * ...
 * @author Christopher Speciale
 */
@:forward
abstract Payload(Object) from IPayload to Object
{
	
	public inline function new(eventEnum:EnumValue, ?data, ?op:UInt = 0){
		this = new Object();
		this.data = data == null ? {} : data;
		this.eventEnum = eventEnum;
		this.op = op;
	}
	
	
}