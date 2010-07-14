package cocktail.lib 
{
	import cocktail.Cocktail;
	import cocktail.core.gunz.Bullet;
	import cocktail.core.request.Request;
	import cocktail.core.slave.Slave;
	import cocktail.core.slave.gunz.ASlaveBullet;
	import cocktail.core.slave.slaves.TextSlave;
	import cocktail.lib.gunz.LayoutBullet;
	import cocktail.lib.gunz.ViewBullet;
	import cocktail.utils.StringUtil;
	import cocktail.utils.Timeout;

	import flash.display.Sprite;

	/**
	 * This class will load the respective xml and it assets.
	 * 
	 * It has some filters:
	 * 	before_render( request: Request )
	 * 	before_load( request: Request )
	 * 
	 * And some callbacks:
	 *  after_render( request )
	 *  after_load( success ) //triggered after all request assets were loaded
	 *  
	 * @author hems	hems@henriquematias.com
	 */
	public class Layout extends View 
	{
		/** queue of this layout an respective children **/
		private var _loader : Slave;

		/** 
		 * path to "container" asset.
		 * format is: {controller}/{area}:{view_id}
		 */
		private var _target : String;

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
			load_uri( _xml_path ).on_complete.add( _xml_loaded );
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

		
		override internal function _load_attributes() : void 
		{
			super._load_attributes( );
			
			if( xml_node.hasOwnProperty( 'target' ) )
				target = attribute( 'target' );
		}

		/**
		 * Checks if the scheme is valid.
		 * @return	If shceme is valid, returns <code>true</code> otherwise
		 * return <code>false</code>.
		 */
		private function get _is_scheme_valid() : Boolean 
		{
			log.info( "Running..." );
			// TODO: check for some reserved word, or things like that
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
			
			//.( @id == action || @id == "*" );
			list = _xml[ action ];
			
			if( list )
				xml_node = XML( list.toXMLString( ) );
			
			//TODO: If target isnt rendered, redirect to asset page
			if( !factory.layout( name ).childs.has( "" ) )
			{
				//redirect
			}
			
			_loader.reset();			
			
			if( !super.load( request ) ) return false;
			
			if( loader.length )
			{
				loader.on_complete.add( _after_load_assets, request ).once( );
				loader.on_error.add( _load_assets_failed, request ).once( );
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
			bullet;
			
			log.info( "Running..." );
			
			after_load( true );
			
			//this will tell controller, that everything was ok
			on_load_complete.shoot( new ViewBullet( ) );
		}

		private function _load_assets_failed( bullet : Bullet ) : void
		{
			log.error( "Failed to load all layout assets" );
			_after_load_assets( bullet );
		}

		override protected function _instantiate_display() : * 
		{
			return _cocktail.app.addChild( sprite = new Sprite( ) );
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

		override public function get loader() : Slave
		{
			return _loader;
		}
		
		
		/** 
		 * ATRIBUTTE SETTERS
		 * 
		 * This setters will receive the properties from xml_node, each
		 * time the "load" method is called
		 */
		 
		/**
		 * Unload the current source if any, then load the new path
		 * Will trigger _source_loaded after complete 
		 * 
		 * @param path	Path to the desired asset
		 */
		public function set target( path : String ) : void
		{
			_target = path;
		}
		
		
		public function get scope() : View 
		{
			var full_path : Array;
			var controller_name : String;
			var action_name : String;
			var asset_id : String;
			
			//ATT: see Route::api
			full_path = String( xml_node.attribute( 'target' ) ).split( ":" ); 
			
			controller_name = full_path[ 0 ][ 'split' ]( '/' )[ 0 ];
			action_name     = full_path[ 0 ][ 'split' ]( '/' )[ 1 ];
			asset_id        = full_path[ 1 ];

			if( !factory.layout( controller_name ).childs.by_id( asset_id ) )
				return null;
			
			return factory.layout( name ).childs.by_id( asset_id );
		}
	}
}