package net;

import openfl.events.Event;
import net.Connection;

/**
 * ...
 * @author Christopher Speciale
 */
class RUDPEvent extends Event 
{
	public static inline var CONNECT:String = "connect";
	public static inline var CLOSE:String = "close";
	public static inline var ERROR:String = "error";
	
	public var connection(default, null):Connection;
	public var error(default, null):String;
	public function new(type:String, bubbles:Bool=false, cancelable:Bool=false, error:String = "", connection:Connection) 
	{
		super(type, bubbles, cancelable);
		this.connection = connection;
		this.error = error;
		
	}
	override public function clone():Event 
	{
		return new RUDPEvent(type, bubbles, cancelable, error, connection);
	}
	
}