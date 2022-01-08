package blockchain;

import openfl.utils.Object;
/**
 * ...
 * @author Christopher Speciale
 */
class Blockchain
{
	public var chain:Array<Block>;
	public var lastBlock(get, null):Block;
	public var difficulty:UInt = 0;
	public var seed:Null<Int>;

	private function get_lastBlock():Block
	{
		if (chain == null) return null;
		return chain == null ? null : chain[chain.length - 1];
	}
	public function new(?blockchainData:BlockchainData)
	{
		chain = [];

		if (blockchainData == null)
		{
			_createGenesisBlock();
		}
		else
		{
			_populateBlockchain();
		}
	}

	public function isValid():Bool
	{
		for (i in 1...chain.length)
		{
			var currentBlock:Block = chain[i];
			var prevBlock:Block = chain[i-1];

			// Check validation
			if (currentBlock.hash != currentBlock.hash || prevBlock.hash != currentBlock.prevHash)
			{
				return false;
			}
		}

		return true;
	}
	public function getBlock(?index:Null<Int>):Block
	{
		if (index == null) return new Block(Blockchain.getTime(), {}, lastBlock);
		return chain == null ? null : chain[index];
	}

	public function writeBlock(?data:Object):Block
	{
		var block:Block = getBlock();
		if(data != null) block.writeData(data);
		
		var nextBlockMined:Bool = false;

		while (!nextBlockMined)
		{
			nextBlockMined = block.mine(difficulty, seed);
			if (seed != null) seed++;
		}
		return block;
	}

	private function _populateBlockchain():Void
	{
		//create existsing blockchain structure
	}

	private function _createGenesisBlock():Void
	{
		_addBlock(Blockchain.getTime());
	}

	private function _addBlock(timestamp:Float, ?data:Object):Void
	{
		var blockData = data == null ? {} : data;
		chain.push(new Block(timestamp, blockData, lastBlock));
	}

	public static function getTime():Float
	{
		return Date.now().getTime();
	}

}

