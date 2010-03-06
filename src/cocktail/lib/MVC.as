package cocktail.lib 
{
	import flash.events.EventDispatcher;
	import cocktail.Cocktail;
	import cocktail.core.Index;
	import cocktail.core.gunz.Gun;
	import cocktail.utils.Timeout;

	/**
	 * @author nybras | me@nybras.com
	 */
	public class MVC extends Index 
	{
		/* GUNZ */
		public var gunz_load_start : Gun; 

		public var gunz_load_progress : Gun; 

		public var gunz_load_complete : Gun; 

		/*Clean class name */
		private var _name : String;

		/** hold all timeouts created by this class  **/
		private var _timeouts : Array;
		
		private function _init_gunz() : void
		{
			gunz_load_start = new Gun( gunz, this, "load_start" );
			gunz_load_progress = new Gun( gunz, this, "load_progress" );
			gunz_load_complete = new Gun( gunz, this, "load_complete" );
		}

		/* BOOTING */
		override public function boot( cocktail : Cocktail ) : *
		{
			var s : *;
			var regexp : RegExp;
			
			s = super.boot( cocktail );
			
			_init_gunz( );
			
			regexp = /(Model|View|Controller|Layout$)/;
			_name = classname.replace( regexp, '' );
			
			return s;
		}

		public function go( url : String, silent : Boolean = false ) : void
		{
			silent;
			router.get( url );
		}


		/**
		 * Create, start then return the timeout
		 */
		public function timeout( 
			method: Function, 
			delay: Number, 
			params: * = null 
		): Timeout
		{
			var to: Timeout;
			
			to = new Timeout( method, delay * 1000, params );
			_timeouts.push( to );
			
			return to; 
		}
		
		/**
		 * Stops and destroy all timeouts
		 */
		public function clear_timeouts(): void
		{
			var i: int;
			
			if( !_timeouts.length ) return;
			do
			{
				Timeout( _timeouts[ i ] ).abort();
			} while ( ++i < _timeouts.length );
		}

		public function event(
			dispatcher: EventDispatcher,
			type: String,
			method: Function,
			params: * = null
		): Gun
		{
			var gun: Gun;
			
			gun = new Gun( gunz, this, type );
			gun.capture( dispatcher, type );
			gun.add( method, params );
			
			return gun;
		}
		
		/*Clean class name */
		public function get name() : String
		{
			return _name;
		}
	}
}