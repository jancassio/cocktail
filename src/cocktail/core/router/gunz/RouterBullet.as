package cocktail.core.router.gunz 
{
	import cocktail.core.gunz.Bullet;			

	/**
	 * @author hems | hems@codeine.it
	 */
	public class RouterBullet extends Bullet
	{
		/* ---------------------------------------------------------------------
			BULLET PROPERTIES
		--------------------------------------------------------------------- */
		
		public var location : String;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new RouterBullet.
		 * @param type	Bullet type.
		 * @param location	User name.
		 */
		public function RouterBullet(
			type : String,
			location : String
		) : void
		{
			super ( type );
			this.location = location;
		}
	}
}