package  
{
	import cocktail.Cocktail;
	
	import codeine.boot.Embedder;
	
	import flash.display.Sprite;	

	/**
	 * This is the document class of this demo.
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
			cocktail = new Cocktail ( this, new Embedder(), "codeine", "Main/home", 3, 3 );
		}
	}
}