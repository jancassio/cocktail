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
		
		private var _cocktail : Cocktail;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Initializes App & Cocktail.
		 */
		public function Codeine ()
		{
			_cocktail = new Cocktail (
				this,
				new Embedder(),
				new Routes(),
				"codeine",
				"main/index"
			);
		}
	}
}