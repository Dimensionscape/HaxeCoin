package protocol;
import openfl.utils.Object;

/**
 * @author Christopher Speciale
 */
interface IPayload 
{
	var event:EnumValue;
	var data:Object;
}