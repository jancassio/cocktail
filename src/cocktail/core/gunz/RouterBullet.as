package cocktail.core.gunz 
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
		public var freezed : Boolean;
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new RouterBullet.
		 * @param type	Bullet type.
		 * @param location	User name.
		 * @param freezed	User gender.
		 * @param age	User age.
		 */
		public function RouterBullet (
			type : String,
			location : String, 
			freezed : Boolean 
		) : void
		{
			super ( type );
			
			this.location = location;
			this.freezed = freezed;
		}
	}
}