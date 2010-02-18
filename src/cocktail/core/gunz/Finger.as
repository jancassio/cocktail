package cocktail.core.gunz 
{

	/**
	 * @author nybras | me@nybras.com
	 */
	public class Finger 
	{
		/* ===== VARS ======================================================= */
		internal var _id : int;
		internal var _gun : Gun;
		internal var _handler : Function;
		internal var _params : Object;
		internal var _times : int;
		internal var _time : int;

		/* ===== INITIALIZING =============================================== */
		public function Finger(
			gun : Gun,
			handler : Function,
			params : Object
		)
		{
			_id = gun._fingers.length;
			
			_gun = gun;
			_handler = handler;
			_params = params;
		}

		/* ===== TIMES / ONCE =============================================== */
		public final function times( number : int ) : Finger
		{
			_times = number;
			return this;
		}

		public final function once() : Finger
		{
			times( 1 );
			return this;
		}

		/* ===== PULL / RELEASE ============================================= */
		internal function pull( bullet : Bullet ) : Finger
		{
			_time++;
			
			bullet._params = _params;
			bullet._owner = _gun._owner;
			bullet._now = new Date( );
			bullet._times = _times;
			bullet._time = _time;
			
			_handler( bullet );
			
			return this;
		}
	}
}