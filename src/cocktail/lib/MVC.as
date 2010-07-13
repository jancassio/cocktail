package cocktail.lib 
{
	import cocktail.Cocktail;
	import cocktail.core.Index;
	import cocktail.core.gunz.Gun;
	import cocktail.utils.StringUtil;
	import cocktail.utils.Timeout;

	import flash.events.EventDispatcher;

	/**
	 * @author nybras | me@nybras.com
	 * @author hems | hems@henriquematias.com
	 */
	public class MVC extends Index 
	{
		/* GUNZ */
		public var on_load_start : Gun; 

		public var on_load_progress : Gun; 

		public var on_load_complete : Gun; 

		/** Clean class name **/
		private var _name : String;

		/** hold all timeouts created by this class  **/
		private var _timeouts : Array;
		
		private function _init_gunz() : void
		{
			on_load_start    = new Gun( gunz, this, "load_start" );
			on_load_progress = new Gun( gunz, this, "load_progress" );
			on_load_complete = new Gun( gunz, this, "load_complete" );
		}

		/* BOOTING */
		override public function boot( cocktail : Cocktail ) : *
		{
			var s : *;
			var regexp : RegExp;
			
			s = super.boot( cocktail );
			
			_init_gunz( );
			
			regexp = /(Model|View|Controller|Layout)$/;
			_name = StringUtil.toUnderscore( classname.replace( regexp, '' ) );
			
			return s;
		}

		/**
		 * Navigate to desired url
		 * @param url	dedired url
		 * @param silent	if true, wont run SWFAddress call
		 */
		public function go( url : String, silent : Boolean = false ) : void
		{
			router.get( url, silent );
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

		public function capture(
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
		
		
		/* GETTERS  /  SETTERS */
		
		
		public function get name() : String
		{
			return _name;
		}
		
	}
}