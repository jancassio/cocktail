package  
{
	import cocktail.Cocktail;
	
	import codeine.boot.Embedder;
	import codeine.boot.Routes;
	
	import flash.display.Sprite;	

	/**
	 * Document class.
	 * @author nybras | nybras@codeine.it
	 */
	public class Codeine extends Sprite 
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var cocktail : Cocktail;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Initializes App & Cocktail.
		 */
		public function Codeine ()
		{
			cocktail = new Cocktail (
				this,
				"codeine",
				new Embedder(),
				new Routes(),
				"Main/home"
			);
		}
	}
}