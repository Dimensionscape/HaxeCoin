package protocol;

/**
 * ...
 * @author Christopher Speciale
 */
enum abstract NodeType(String) from String to NodeType
{

	var LITE_NODE = "lite";
	var HALF_NODE = "half";
	var FULL_NODE = "full";
	
}