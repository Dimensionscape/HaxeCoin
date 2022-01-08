package core;

/**
 * ...
 * @author Christopher Speciale
 */
class Config implements IConfig
{

	public var ip:String;
	public var port:Int;
	public var nodeType:String;
	public var blockchainVer:String;
	public var protocolVer:String;
	public var miner:Bool;
	public var remoteEndpoints:Array<String>;
	
	public function new(ip:String, port:Int, nodeType:String, miner:Bool, blockchainVer:String, protocolVer:String, remoteEndpoints:Array<String>) 
	{
		this.ip = ip;
		this.port = port;
		this.nodeType = nodeType;
		this.miner = miner;
		this.blockchainVer = blockchainVer;
		this.protocolVer = protocolVer;
		this.remoteEndpoints = remoteEndpoints;
	}
	
}