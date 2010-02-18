package cocktail.core.gunz 
{
	import flash.display.DisplayObject;

	/**
	 * @author nybras | me@nybras.com
	 */
	public class Gun 
	{
		/* VARS */
		internal var _gunz : Gunz;
		internal var _owner : *;
		internal var _type : String;
		internal var _fingers : Array;
		internal var _captured : Array;

		/* INITIALIZING */
		public function Gun( gunz : Gunz, owner : *, type : String ) : void
		{
			( _gunz = gunz )._keep( this );
			
			_owner = owner;
			_type = type;
			_fingers = [];
			
			_captured = [];
		}

		/* LISTEN / UNLISTEN / DESTROY */
		public final function add(
			handler : Function,
			params : * = null
		) : Finger
		{
			var finger : Finger = new Finger( this, handler, params );
			_fingers.push( finger );
			return finger;
		}

		public final function rm( handler : Function ) : void
		{
			var i : int;
			var finger : Finger;
			
			while( i < _fingers.length )
			{
				finger = Finger( _fingers[ i ] );
				if( finger._handler == handler )
					_fingers.splice( i, 1 );
				else i++;
			}
		}

		public final function rm_all() : void
		{
			_fingers = [];
		}

		/* DESTROY */
		public final function destroy() : void
		{
			var captured : Captured;
			
			rm_all( );
			for each( captured in _captured )
				captured._destroy( );
		}

		/* PULLING */
		public final function pull( bullet : Bullet = null ) : void
		{
			for each( var finger : Finger in _fingers )
			{
				finger.pull( bullet || new Bullet( "null" ) );
				if( finger._time == finger._times )
					rm( finger._handler );
			}
		}

		/* CAPTURING */
		public final function capture(
			target : DisplayObject,
			event_type : String
		) : Captured
		{
			var captured : Captured;
			
			captured = new Captured( this, target, event_type );
			return captured;
		}

		/* GETTERS */
		public final function get type() : String
		{
			return _type;
		}
	}
}