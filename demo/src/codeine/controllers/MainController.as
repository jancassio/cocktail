package codeine.controllers 
{
	import cocktail.Cocktail;
	
	import codeine.AppController;	

	/**
	 * Handles the main Controller behaviors.
	 * @author nybras | nybras@codeine.it
	 */
	public class MainController extends AppController 
	{
		public function MainController(cocktail : Cocktail)
		{
			super( cocktail );
		}
	}
}
