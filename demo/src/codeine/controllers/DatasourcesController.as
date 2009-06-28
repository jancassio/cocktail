package codeine.controllers 
{
	import codeine.AppController;						

	/**
	 * Handles the datasources controller.
	 * @author nybras | nybras@codeine.it
	 */
	public class DatasourcesController extends AppController
	{
		/* ---------------------------------------------------------------------
			DEPENDENCIES
		--------------------------------------------------------------------- */
		
		/**
		 * Specify dependencies for action /index/.
		 */
		public function index_uses () : void
		{
			uses ( "Main/base", true );
		}
	}
}