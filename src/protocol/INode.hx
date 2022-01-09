package protocol;
import protocol.NodeType;

/**
 * @author Christopher Speciale
 */
interface INode 
{
	var nodeType(default, null):NodeType;
	var neighborCount(get, null):UInt;
	var fullNodeCount(default, null):UInt;
	var halfNodeCount(default, null):UInt;
	var liteNodeCount(default, null):UInt;
}