package;

import blockchain.Blockchain;
import blockchain.Block;
import core.HaxeCoin;
import haxe.Json;
import lime.utils.UInt32Array;
import protocol.Peer;
import protocol.Payload;
import openfl.display.Sprite;
import openfl.Lib;
import src.blockchain.IBlockData;
import openfl.utils.Object;
/**
 * ...
 * @author Christopher Speciale
 */
class Main extends Sprite 
{
	
	public function new() 
	{
		super();
		
	
		// Assets:
		// openfl.Assets.getBitmapData("img/assetname.jpg");
		var blockchain:Blockchain = new Blockchain();
		blockchain.difficulty = 1;
		var data:IBlockData = new Object();
		data.transactions = new Array();
		data.transactions.push("From: Bob | To: Alice | 100");
		
		trace(blockchain.writeBlock(data).toString());
				
		HaxeCoin.start();
		
		var payload:Payload = new Object();
		
		trace(Json.stringify(payload));
		
	}

}
