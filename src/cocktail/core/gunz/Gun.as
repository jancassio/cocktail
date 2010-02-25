package cocktail.core.gunz 
{
	import flash.events.IEventDispatcher;

	/**
	 * Has the main functionality for adding and removing gunz victim listeners.
	 * @author nybras | me@nybras.com
	 */
	public class Gun 
	{
		/* VARS */
		
		/** Gunz list. */
		internal var _gunz : Gunz;
		/** Gun owner. */
		internal var _owner : *;
		/** Gun type. */
		internal var _type : String;
		/** Gun victims listeners. */
		internal var _victims : Array;
		/** Captured items list. */
		internal var _captured : Array;

		/* INITIALIZING */
		
		/**
		 * Creates a new Gun, with an onwer and type, pointing to a Gunz list
		 * reference.
		 * @param gunz	Gunz list, where this Gun will be stored.
		 * @param owner	Gun owner (any instance or object you want to use).
		 * @param type	Gun type.
		 */
		public function Gun( gunz : Gunz, owner : *, type : String ) : void
		{
			( _gunz = gunz )._keep( this );
			
			_owner = owner;
			_type = type;
			_victims = [];
			
			_captured = [];
		}

		/* ADDING VICTIM LISTENERS */
		
		/**
		 * Adds a new victim listener to the Gun.
		 * @param handler	Listener handler.
		 * @param params	Listener params--get it with
		 * <code>bullet.params</code>.
		 * @return	Self reference for reuse.
		 */
		public final function add(
			handler : Function,
			params : * = null
		) : Victim
		{
			var victim : Victim = new Victim( this, handler, params );
			_victims.push( victim );
			return victim;
		}

		/* SHOOTING BULLETS */
		
		/**
		 * Shoots the given bullet across all victim listeners.
		 * @param bullet 	The Bullet to be shot, if <code>null</code> a new
		 * empty Bullet is created.
		 * @return	The fired bullet, for reuse.
		 */
		public final function shoot( bullet : Bullet = null ) : Bullet
		{
			var i : int;
			var victim : Victim;
			
			if( bullet )
				bullet._type = _type;
			
			if( _victims.length ) do
			{
				victim = Victim( _victims[ i ] );
				victim.scream( bullet || new Bullet() );
			} while( ++i < _victims.length );
			
			return bullet;
		}

		/* CAPTURING ADOBE AS3 EVENTS */
		
		/**
		 * Captures all events from the given <code>type</code> in the given
		 * <code>target</code>.
		 * @param target	Target to be captured.
		 * @param event_type Event type to captured on the target.
		 * @return	Capured item instance.
		 */
		public final function capture(
			target : IEventDispatcher,
			event_type : String
		) : Captured
		{
			var captured : Captured;
			
			captured = new Captured( this, target, event_type );
			return captured;
		}

		/* REMOVING AND DESTROYING VICTIM LISTENERS */
		
		/**
		 * Removes some previously added Victim listener.
		 * @param handler	Listener handler to be removed.
		 */
		public final function rm( handler : Function ) : void
		{
			var i : int;
			var victim : Victim;
			
			if( _victims.length ) do
			{
				victim = Victim( _victims[ i ] );
				if( victim._handler == handler )
				{
					_victims.splice( i, 1 );
					break;
				}
			} while( ++i < _victims.length );
		}

		/**
		 * Removes all previously added victim listeners.
		 */
		public final function rm_all() : void
		{
			var i : int;
			
			if( _victims.length ) do
			{
				Victim( _victims[ i ] ).destroy( );
			}
			while( ++i < _victims.length );
			
			_victims = null;
			_victims = [];
		}

		/**
		 * Destroys the Gun unlistening everything and doing some 
		 * garbage collection. 
		 */
		public final function destroy() : void
		{
			var i : int;
			
			rm_all( );
			
			if( _captured.length ) do
			{
				Captured( _captured[ i ] )._destroy( );
			} while( ++i < _captured.length );
			
			_gunz = null;
			_owner = null;
			_type = null;
			_victims = null;
			_captured = null;
		}

		/* GETTERS */
		
		/**
		 * Returns the Gun type.
		 * @return	The gun type.
		 */
		public final function get type() : String
		{
			return _type;
		}
	}
}