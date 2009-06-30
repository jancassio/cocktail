package cocktail.lib.view.styles.gunz 
{
	import cocktail.core.gunz.Trigger;										

	/**
	 * Trigger for Styles class.
	 * @author nybras | nybras@codeine.it
	 */
	public class StylesTrigger extends Trigger
	{
		/* ---------------------------------------------------------------------
			BULLET TYPES
		--------------------------------------------------------------------- */
		
		public static const COMPLETE : String = "complete";
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		 
		/**
		 * Creates a new StylesTrigger.
		 * @param owner	Trigger owner.
		 */
		public function StylesTrigger  ( owner : * )
		{
			super ( owner );
		}
		
		
		
		/* ---------------------------------------------------------------------
			EVENT LISTENERS
		--------------------------------------------------------------------- */
		
		/**
		 * Start/stop listening for COMPLETE bullets.
		 * @param hanlder	Bullet handler.
		 * @param params	Bullet params.
		 * @return	A reference to the StylesTrigger itself, for inline reuse.
		 */
		public function complete (
			handler : Function,
			params : * = null
		) : StylesTrigger
		{
			handle( COMPLETE, handler, params );
			return this;
		}
	}
}