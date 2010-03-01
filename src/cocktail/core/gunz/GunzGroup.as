package cocktail.core.gunz 
{

	/**
	 * Groups multiples gunz, listens to every single one, and fires the
	 * "complete" gun when all guns have fired.
	 * @author nybras | me@nybras.com
	 */
	public class GunzGroup 
	{
		/* GUNZ */
		
		/** Gunz list. **/
		public var gunz : Gunz;
		/** Gunz complete event. **/
		public var gunz_complete : Gun;

		/**
		 * Initializes gunz event system.
		 */
		private function _init_gunz() : void
		{
			gunz = new Gunz( this );
			gunz_complete = new Gun( gunz, this, "complete" );
		}

		/* VARIABLES */
		
		/** Compute the number of fired guns, in the queue. **/
		private var _fired : int;
		/** Keeps all queued guns. **/
		private var _items : Array;

		/* INITIALIZING */
		
		/**
		 * Initializes the module.
		 */
		public function GunzGroup()
		{
			_init_gunz( );
			_items = [];
		}

		/* ADDING ITEMS AND LISTENING THEM */

		/**
		 * Adds a new Gun to the queue list.
		 * @param gun	Gun to be added.
		 * @return	Self reference for reuse.
		 */
		public function add( gun : Gun ) : GunzGroup
		{
			gun.add( _fire );
			_items.push( gun );
			return this;
		}

		/**
		 * Listens for all queued gunz, checking if all gunz already finished
		 * or not, and if is the last, fires a complete gun.
		 */
		private function _fire( ...bullet ) : void
		{
			if( ++_fired == _items.length )
				gunz_complete.shoot( );
		}
	}
}