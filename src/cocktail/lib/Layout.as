package cocktail.lib 
{
	import cocktail.Cocktail;
	import cocktail.core.gunz.Gun;
	import cocktail.core.request.Request;
	import cocktail.core.slave.gunz.ASlaveBullet;
	import cocktail.core.slave.slaves.TextSlave;
	import cocktail.lib.gunz.LayoutBullet;

	import flash.display.DisplayObjectContainer;

	public class Layout extends View 
	{
		/* GUNZ */
		public var gunz_render_complete : Gun;

		private function _init_gunz() : void 
		{
			gunz_render_complete = new Gun( gunz, this, "render_complete" );
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

		/* LOADING, VALIDATING AND PARSING SCHEME */
		
		/**
		 * Load model scheme.
		 * @param process	Running process.
		 */
		public function load_scheme( process : Request ) : Layout 
		{
			process;
			log.info( "Running..." );
			load_uri( _xml_path ).gunz_complete.add( _after_load_scheme );
			return this;
		}

		/**
		 * Parsing model xml scheme.
		 * @param bullet	SlaveBullet.
		 */
		public function _after_load_scheme( bullet : ASlaveBullet ) : void 
		{
			log.info( "Running..." );
			
			_scheme = new XML( TextSlave( bullet.owner ).data );
			if( !_is_scheme_valid )
				log.fatal( "The scheme in this file has errors." + _xml_path );
			else
				gunz_scheme_load_complete.shoot( new LayoutBullet( ) );
		}

		/**
		 * Checks if the scheme is valid.
		 * @return	If shceme is valid, returns <code>true</code> otherwise
		 * return <code>false</code>.
		 */
		private function get _is_scheme_valid() : Boolean 
		{
			log.info( "Running..." );
			// TODO: scheme needs to be validated against any inconsistence or
			//  problem cause that may exists
			return true;
		}

		/* GETTERS */

		public function get name() : String
		{
			return classname.toLowerCase().replace("layout", "");
		}

		/**
		 * Evaluates the path for the xml file.
		 * @return	The path to the xml file.
		 */
		private function get _xml_path() : String 
		{
			log.info( "Running..." );
			var path : String;
			
			path = config.path( ".xml" ) + "layouts/";
			path += name + ".xml";
			
			return path;
		}

		private function get _target() : DisplayObjectContainer 
		{
			var full_path : Array;
			
			full_path = String( xml_node['target'] ).split( ":" ); 
			
			//controller - full_path.split( '/' )[ 0 ]
			//action - full_path.split( '/' )[ 1 ]
			//asset - full_path[ 1 ]

			return new DisplayObjectContainer( );
		}
	}
}