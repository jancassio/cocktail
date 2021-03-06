package cocktail.lib 
{
	import cocktail.Cocktail;
	import cocktail.core.Index;
	import cocktail.core.gunz.Gun;
	import cocktail.core.gunz.Gunz;
	import cocktail.core.gunz.Victim;
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
		public var gunz : Gunz; 

		/* GUNZ */
		public var on_load_start : Gun; 

		public var on_load_progress : Gun; 

		public var on_load_complete : Gun; 

		/** Clean class name **/
		private var _name : String;

		/** hold all delays created by this class  **/
		private var _delays : Array;
		
		private function _init_gunz() : void
		{
			gunz = new Gunz( this );
			
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
			_name  = StringUtil.toUnderscore( classname.replace( regexp, '' ) );
			
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
		public function delay( 
			delay: Number, 
			method: Function, 
			params: * = null 
		): Timeout
		{
			var to: Timeout;
			
			if( !_delays ) _delays = new Array();
			
			to = new Timeout( method, delay * 1000, params );
			
			_delays.push( to );
			
			return to; 
		}
		
		/**
		 * Abort and set all timeouts to null
		 */
		public function clear_delays(): void
		{
			var i: int;
			
			if( !_delays ) return;
			
			do
			{
				Timeout( _delays[ i ] ).abort();
				_delays[ i ]  = null;
			} while ( ++i < _delays.length );
		}
		
		/**
		 * Creates a gun that listen for EventDispatcher events ( screams )
		 */
		public function listen( 
			dispatcher: EventDispatcher, 
			type: String 
		): Gun
		{
			
			var gun: Gun;
			
			gun = new Gun( gunz, this, type );
			gun.capture( dispatcher, type );
			
			return gun;
		}
		
		/**
		 * Get a gun for given EventDispatcher event ( screm ) AND adds a  
		 * victim :
		 * 	a callback wich will receive a bullet with params in its prop
		 */
		public function capture(
			dispatcher: EventDispatcher,
			type: String,
			method: Function,
			params: * = null
		): Victim
		{
			return listen( dispatcher, type ).add( method, params );
		}
		
		
		/* GETTERS  /  SETTERS */
		
		
		public function get name() : String
		{
			return _name;
		}
		
	}
}