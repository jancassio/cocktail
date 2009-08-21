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
			var target_uri : String = "main/index/c/b/a";
			var mask_uri : String = "mask1/a/b/c";
			
			_cocktail = new Cocktail (
				this,
				new Embedder(),
				new Routes(),
				"codeine",
				mask_uri
			);
		}
	}
}