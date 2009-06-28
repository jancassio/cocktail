package codeine.controllers 
{
	import codeine.AppController;		

	/**
	 * Handles the main controller.
	 * @author nybras | nybras@codeine.it
	 */
	public class MainController extends AppController
	{
		/* ---------------------------------------------------------------------
			DEPENDENCIES
		--------------------------------------------------------------------- */
		
		/**
		 * Specify dependencies for action /home/.
		 */
		public function home_uses () : void
		{
			uses ( "Main/base", true );
		}
	}
}