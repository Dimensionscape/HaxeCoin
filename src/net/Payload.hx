package net;

import openfl.utils.Object;
/**
 * ...
 * @author Christopher Speciale
 */
@:forward
abstract Payload(Object) from IPayload to Object
{
	
	
	public inline function new(event:Int = 0, data = null){
		this = new Object();
		this.data = data == null ? {} : data;
		this.event = event;
	}
	
	
}