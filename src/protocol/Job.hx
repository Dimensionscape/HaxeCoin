package protocol;
import openfl.events.Event;
import openfl.utils.Function;
import openfl.utils.Object;
import openfl.events.EventDispatcher;

/**
 * ...
 * @author Christopher Speciale
 */
class Job<T> extends EventDispatcher
{
	
	public var controller:T;
	
	public function new() 
	{
		super();
		controller = new Object();
	}
	
	public function doWork(func:Function, ?args:Array<Dynamic>):Void{
		Reflect.callMethod(this, func, args);		
	}
	
	public function complete():Void{
		dispatchEvent(new Event(Event.COMPLETE));
	}
}