package protocol;

import net.Connection;
import net.RUDP;
import net.RUDPEvent;
import net.Test;
import openfl.utils.ByteArray;


/**
 * ...
 * @author Christopher Speciale
 */
class Millipede extends NetEventDispatcher
{
	private var _udp:RUDP;
	private var _courier:Courier;
	
	
	public function new() 
	{
		super();
		_udp = new RUDP();		
		
		_udp.start((_courier = new Courier(this)).reciever, onConnect, onClose, onError);
		_udp.connect("192.168.1.197", 34970);
		//var ba:ByteArray = new ByteArray();
		//ba.writeUTF("Hello World4");
		//_udp.connect("192.168.1.197", 34970);
		//_udp.send(ba, "192.168.1.197", 34970);
	
	}
	
	public function onConnect(e:RUDPEvent):Void{
		trace("recieved connection from ", e.connection.hash);
		//e.connection.close();
		for (i in 0...1){
			var ba:ByteArray = new ByteArray();
			ba.writeUTFBytes(Test.longString);
			//ba.writeUTF("SDFSDF");
			e.connection.send(ba);
			//e.connection.checkResend();
		}
		//_udp.close();
	}
	
	public function onClose(e:RUDPEvent):Void{
		trace("connection closed at:", e.connection.hash);
		//e.connection.send(null);
	}
	
	public function onError(e:RUDPEvent):Void{
		trace(e.error);
	}
	
	public function startBeacon():Void{
		
	}
	
	
}