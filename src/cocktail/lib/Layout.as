package cocktail.lib 
{
	import cocktail.Cocktail;
	import cocktail.core.gunz.Bullet;
	import cocktail.core.logger.msgs.LayoutMessages;
	import cocktail.core.request.Request;
	import cocktail.core.slave.Slave;
	import cocktail.core.slave.gunz.ASlaveBullet;
	import cocktail.core.slave.slaves.TextSlave;
	import cocktail.lib.gunz.LayoutBullet;
	import cocktail.lib.gunz.ViewBullet;
	import cocktail.utils.StringUtil;
	import cocktail.utils.Timeout;

	import flash.display.DisplayObjectContainer;

	/**
	 * This class will load the respective xml and it assets 
	 * 
	 * @author hems	hems@henriquematias.com
	 */
	public class Layout extends View 
	{
		/** queue of this layout an respective children **/
		private var _loader : Slave;

		override public function boot(cocktail : Cocktail) : * 
		{
			_loader = new Slave( );
			
			return super.boot( cocktail );
		}

		/**
		 * Load layout's xml scheme.
		 * 
		 * @param request	request responsible for the action
		 */
		public function load_xml( request : Request ) : Layout 
		{
			request;
			log.info( "Running..." );
			load_uri( _xml_path ).gunz_complete.add( _xml_loaded );
			return this;
		}

		/**
		 * Parsing model xml scheme.
		 * 
		 * @param bullet	SlaveBullet.
		 */
		private function _xml_loaded( bullet : ASlaveBullet ) : void 
		{
			log.info( "Running..." );
			
			_xml = new XML( TextSlave( bullet.owner ).data );
			
			if( !_is_scheme_valid )
				log.fatal( "The scheme in this file has errors." + _xml_path );
			else
				on_xml_load_complete.shoot( new LayoutBullet( ) );
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

		/**
		 * 
		 */
		override public function load( request : Request ) : Boolean 
		{
			var list : XMLList;
			var action : String;
			
			action = request.route.api.action;
			
			list = _xml..action.( @id == action || @id == "*" );
			
			if( list )
				xml_node = XML( list.toXMLString( ) );
			
			//TODO: If target isnt rendered, redirect to home
			if( !factory.layout( name ).childs.has( "" ) )
			{
				//redirect
			}
			
			if( !super.load( request ) ) return false;
			
			if( loader.length )
			{
				loader.gunz_complete.add( _after_load_assets, request ).once( );
				loader.gunz_error.add( _load_assets_failed, request ).once( );
				loader.load( );
			}
			else
			{
				var bullet : ViewBullet;
				
				bullet = new ViewBullet( );
				bullet.params = request;
				
				new Timeout( _after_load_assets, 1, bullet );
			}
				
			return true;
		}

		/**
		 * Triggered after all views have loaded its content
		 */
		private function _after_load_assets( bullet : Bullet ) : void 
		{
			log.info( "Running..." );
			bullet;
			//this will tell controller, that everything was ok
			on_load_complete.shoot( new ViewBullet( ) );
		}

		private function _load_assets_failed( bullet : Bullet ) : void
		{
			log.error( "Failed to load all layout assets" );
			_after_load_assets( bullet );
		}

		/* PRIVATE GETTERS */

		/**
		 * Evaluates the path for the xml file.
		 * @return	The path to the xml file.
		 */
		private function get _xml_path() : String 
		{
			log.info( "Running..." );
			
			return "layouts/" + StringUtil.toUnderscore( name ) + ".xml";
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
		public function get scope() : DisplayObjectContainer 
		{
			var full_path : Array;
			var controller_name : String;
			var action_name : String;
			var asset_id : String;
			
			if( !xml_node.hasOwnProperty( 'target' ) )
			{
				log.info( LayoutMessages.no_target_found );
				return _cocktail.app;
			}
			
			full_path = String( xml_node.attribute( 'target' ) ).split( ":" ); 
			
			controller_name = full_path[ 0 ].split( '/' )[ 0 ];
			action_name = full_path[ 0 ].split( '/' )[ 1 ];
			asset_id = full_path[ 1 ];

			return factory.layout( name ).childs.by_id( asset_id ).sprite;
		}

		override public function get loader() : Slave
		{
			return _loader;
		}
	}
}