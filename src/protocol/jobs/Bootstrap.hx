package protocol.jobs;
import protocol.Job;
import protocol.controllers.IBootstrapController;

/**
 * ...
 * @author Christopher Speciale
 */
class Bootstrap extends Job<IBootstrapController>
{
	
	public function new() 
	{
		super();
		
		doWork(_work);
	}
	
	private function _work():Void{
		Millipede.current.node.
	}
}