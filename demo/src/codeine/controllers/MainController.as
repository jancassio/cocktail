package codeine.controllers 
{
	import codeine.AppController;	

	/**
	 * Handles the main Controller behaviors.
	 * @author nybras | nybras@codeine.it
	 */
	public class MainController extends AppController 
	{
		public function home() : void
		{
			log.notice( "Fucking running mothafucka!" );
		}
	}
}
