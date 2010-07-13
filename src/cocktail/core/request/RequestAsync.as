package cocktail.core.request 
{
	import cocktail.Cocktail;

	/**
	 * Handles async requests.
	 * @author nybras | nybras@codeine.it
	 */
	public class RequestAsync extends Request 
	{
		/* INITIALIZING */
		
		/**
		 * TODO: implement this class, using core load || slave ?
		 */
		public function RequestAsync(
			uri : String,
			data : *
		)
		{
			super( Request.POST, uri, data );
		}

		/* BOOTING */
		
		/**
		 * Boots the Index base class.
		 * @param cocktail	Cocktail reference.
		 */
		override public function boot( cocktail : Cocktail ) : *
		{
			super.boot( cocktail );
			
			return this;
		}
	}
}
