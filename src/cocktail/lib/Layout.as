package cocktail.lib 
{
	import cocktail.core.request.Request;
	import cocktail.core.slave.gunz.ASlaveBullet;
	import cocktail.core.slave.slaves.TextSlave;
	import cocktail.lib.gunz.LayoutBullet;
	import cocktail.messages.lib.LayoutMessages;

	import flash.display.DisplayObjectContainer;

	public class Layout extends View 
	{

		/* LOADING, VALIDATING AND PARSING SCHEME */
		
		/**
		 * Load model scheme.
		 * @param process	Running process.
		 */
		public function load_scheme( request : Request ) : Layout 
		{
			request;
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

		/* PRIVATE GETTERS */

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

		/**
		 * Returns true if childs.request is equal to param request
		 * @param request	The request you would check if is rendered
		 * @see	ViewStack#request
		 */
		public function is_rendered( request : Request ) : Boolean
		{
			return childs.request == request; 
		}
		
		/* PUBLIC GETTERS */
		
		public function get target() : DisplayObjectContainer 
		{
			var full_path : Array;
			var controller_name: String;
			var action_name: String;
			var asset_id: String;
			
			if( !xml_node.hasOwnProperty( 'target' ) )
			{
				log.info( LayoutMessages.no_target_found );
				return cocktail.app;
			}
			
			full_path = String( xml_node.attribute( 'target' ) ).split( ":" ); 
			
			controller_name = full_path[ 0 ].split( '/' )[ 0 ];
			action_name = full_path[ 0 ].split( '/' )[ 1 ];
			asset_id = full_path[ 1 ];

			return controller( name ).layout.childs.by_id( asset_id ).sprite;
		}
		
	}
}