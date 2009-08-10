package cocktail.core.gunz 
{
	import cocktail.core.gunz.Trigger;		

	/**
	 * @author hems | hems@codeine.it
	 */
	public class RouterTrigger extends Trigger
	{
		/* ---------------------------------------------------------------------
			BULLET TYPES
		--------------------------------------------------------------------- */
		
		public static const UPDATE : String = "update";
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new UserTrigger.
		 * @param owner	Trigger owner.
		 */
		public function RouterTrigger  ( owner : * )
		{
			super ( owner );
		}
		
		
		
		/* ---------------------------------------------------------------------
			EVENT LISTENERS
		--------------------------------------------------------------------- */
		
		/**
		 * Start/stop listening for UPDATE bullets.
		 * @param hanlder	Bullet handler.
		 * @param params	Bullet params.
		 * @return	A reference to the UserTrigger itself, for inline reuse.
		 */
		public function update (
			handler : Function,
			params : Array = null
		) : RouterTrigger
		{
			handle( UPDATE, handler, params );
			return this;
		}
	}
}