package protocol;
import openfl.utils.Object;

/**
 * @author Christopher Speciale
 */
interface IPayload 
{
	var eventEnum:EnumValue;
	var data:Object;
	var op:UInt;
}