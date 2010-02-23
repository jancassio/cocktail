package cocktail.lib 
{
	import cocktail.Cocktail;
	import cocktail.core.gunz.Gun;
	import cocktail.core.request.Request;

	/**
	 * @author hems
	 * @author nybras
	 */
	public class Model extends MVC
	{
		/* GUNZ */
		public var gunz_scheme_loaded : Gun; 

		private function _init_gunz() : void
		{
			gunz_scheme_loaded = new Gun( gunz, this, "shcheme_loaded" );
		}

		/* INITIALIZING */
		
		/**
		 * 
		 */
		override public function boot( cocktail : Cocktail ) : *
		{
			var s : *;
		
			s = super.boot( cocktail );
			_init_gunz( );
			
			return s;
		}

		/* LOAD */
		
		/**
		 * Filtering load action, if returns false, no load will occur
		 */
		public function before_load(): Boolean
		{
			return true;
		}
		
		/**
		 * Load model scheme.
		 */
		public function load_scheme( process : Request ) : Model
		{
			process;
			return this;
		}
		
		/**
		 * Load all datasources needed for the request.
		 */
		public function load_data( process : Request ) : Model
		{
			process;
			return this;
		}
		
		/**
		 * Filtering load action, if returns false, no load will occur
		 */
		public function after_load(): void
		{
		}
		
		/**
		 * Evaluates the path for the xml file.
		 * @return	The path to the xml file.
		 */
		public function get xmlPath () : String
		{
			return ( config.path( ".xml" ) + "models/" + classname.toLowerCase( ) ) + ".xml";
		}
		
	}
}