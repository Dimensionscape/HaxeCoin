package core;

/**
 * @author Christopher Speciale
 */
interface IConfig 
{
	var ip:String;
	var port:Int;
	var nodeType:String;
	var blockchainVer:String;
	var protocolVer:String;
	var miner:Bool;
	var remoteEndpoints:Array<String>;
}