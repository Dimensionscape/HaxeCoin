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
	
	
	public inline function new(event:EnumValue, ?data){
		this = new Object();
		this.data = data == null ? {} : data;
		this.event = event;
	}
	
	
}