package cocktail.core.gunz 
{

	/**
	 * A Victim listens to Gun.shoot(). Everytime you
	 * use the "Gun.add()" method to start listening to some Gun, a Victim
	 * instance is created in order to keep things organized.
	 * @author nybras | me@nybras.com
	 */
	public class Victim 
	{
		/* VARS */
		
		/** Victim index in the Gun listeners array. */
		internal var _id : int;
		/** Gun being listened. */
		internal var _gun : Gun;
		/** Listener handler. */
		internal var _handler : Function;
		/**
		 * Listener params--get it in the dispatched bullet, with
		 * <code>bullet.params</code>.
		 */
		public var _params : Object;
		/** Victim index in the Gun listeners array. */
		internal var _times : int;
		/** Victim index in the Gun listeners array. */
		internal var _time : int;

		/* INITIALIZING */
		
		/**
		 * Creates a new Victim listener.
		 * @param gun	Gun to be listened.
		 * @param handler	Listener handler. Executed when a Gun.shoot()
		 * happens.
		 * @param params	Listener params included among all fired bullets.
		 */
		public function Victim(
			gun : Gun,
			handler : Function,
			params : Object
		)
		{
			_id = gun._victims.length;
			
			_gun = gun;
			_handler = handler;
			_params = params;
		}

		/* MOCK OBJECT MODIFIERS */
		
		/**
		 * If called, tells the Victim to stop listening Gun shots when the
		 * number of listened shots reach the given limit.
		 * @param limit	Times the event should be listened.
		 * @return	Self reference for reuse.
		 */
		public final function times( limit : int ) : Victim
		{
			_times = limit;
			return this;
		}

		/**
		 * If called, tells the Victim to listen just one event. Pretty much
		 * the same that the <code>times()</code> method, but hardcoded with
		 * a fixed 1 time.
		 * @return	Self reference for reuse.
		 */
		public final function once() : Victim
		{
			times( 1 );
			return this;
		}

		/* SCREAMING AND DESTROYING */
		
		/**
		 * Pull the given bullet across the cached Handler, inputing the also
		 * cached params.
		 * @param bullet	Bullet to be pulled.
		 * @return	Self reference for reuse.
		 */ 
		internal function scream( bullet : Bullet ) : Victim
		{
			bullet._params = _params;
			bullet._owner = _gun._owner;
			bullet._now = new Date( );
			bullet._times = _times;
			bullet._time = _time;
			
			_handler( bullet );
			
			if( ++_time == _times )
				_gun.rm( _handler );
			
			return this;
		}

		/**
		 * Destroys the Victim listener and perform some gc.
		 */
		public function destroy() : void 
		{
			_id = undefined;
			_gun = null;
			_handler = null;
			_params = null;
			_times = undefined;
			_time = undefined;
		}
	}
}