package cocktail.lib 
{
	import cocktail.Cocktail;
	import cocktail.core.gunz.Bullet;
	import cocktail.core.gunz.Gun;
	import cocktail.core.request.Request;
	import cocktail.core.slave.ASlave;
	import cocktail.core.slave.ISlave;
	import cocktail.core.slave.Slave;
	import cocktail.lib.views.ViewStack;

	import de.polygonal.ds.DListNode;

	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class View extends MV 
	{
		/* GUNZ */
		public var gunz_render_done : Gun;

		/* GUNZ */
		public var gunz_destroy_done : Gun;

		/** Contains and indexes all the childs **/
		private var _childs : ViewStack;

		/** The string identifier on parent's ViewStack **/
		public var identifier : String;

		/** The view node on the ViewStack DLinkedList **/
		public var node : DListNode;

		/** Reference to the parent view container **/
		public var up : View;

		/** When created trought xml, this will hold the xml node**/
		private var _xml_node : XML;

		/** View sprite **/
		public var sprite : Sprite;
		
		/** slave for loading **/
		private var _src_slave : ASlave;

		private function _init_gunz() : void 
		{
			gunz_render_done = new Gun( gunz, this, "render_done" );
			gunz_destroy_done = new Gun( gunz, this, "destroy_done" );
		}

		
		/**
		 * 
		 */
		override public function boot( cocktail : Cocktail ) : * 
		{
			var s : *;
		
			s = super.boot( cocktail );
			
			_init_gunz( );
			
			_childs = new ViewStack( this );
			_childs.boot( cocktail );
			return s;
		}

		/* basic api */
		
		/**
		 * Returns desired atribute in xml_node
		 */
		public function attribute( name : String ) : String
		{
			return xml_node.attribute( name ).toString( );
		}
		
		/**
		 * Removes a view from the view stack
		 */
		public function remove( id : String ) : View 
		{
			return childs.remove( id );
		}

		/* loeaing related */

		/**
		 * Filters the loading action. If return false, load routine will
		 * pause
		 */
		public function before_load( request : Request ) : Boolean 
		{
			log.info( "Running..." );
			
			request;
			return true;
		}

		/**
		 * Load will parse all views, instantiate they, and listen for
		 * all loads to complete. After that, will trigger _after_load_assets
		 */
		public function load( request : Request ) : Boolean 
		{
			if( !before_load( request ) ) return false;

			log.info( "Running..." );
			
			var i : int;
			var assets : Array;
			var view : View;
			
			//will mark all views as dead ( not in current render )
			childs.clear_render_poll( );

			//ATT: _parse assets should run after childs.clear_render_poll()			
			assets = _parse_assets( request ); 

			_load_src();			
			
			if( ( this is Layout ) == false )
				up.childs.mark_as_alive( this );
			
			if( assets.length == 0 ) return true;
			
			//TODO: use a lambda to run all selected assets				
			do 
			{
				view = assets[ i ];
				view.load( request );
			} while( ++i < assets.length );

			return true;
		}
		
		/**
		 * This function will load the "src" attribute of the xml_node
		 */
		internal function _load_src() : void
		{
			var path: String;
			var src: String;
			
			src = attribute( "src" );
						
			path = root.name + "/" + src;
			
			if( _src_slave.uri == path ) 
				return;
			else if( _src_slave.is_loaded )
				ISlave( _src_slave ).destroy();
			
			_src_slave = load_uri( path, false ); 
			
			loader.append( _src_slave );
			
			_src_slave.gunz_complete.add( _populate_content );
		}

		/**
		 * This function is a victim from _src_slave's gunz_complete
		 */
		internal function _populate_content( bullet: Bullet ) : void
		{
			log.error( "This function should be overrided by your view" );
			bullet;
		}

		/**
		 * Parses all necessary Datasources for given Process.
		 * @param process	Running process.
		 * @return	An array with all Datasources, properly instantiated. 
		 */
		private function _parse_assets( request : Request ) : Array 
		{
			log.info( "Running..." );
			var i : int;
			var assets : Array;
			var list : XMLList;
			var node : XML;
			var action : String;
			
			action = request.route.api.action;
			assets = [];
			
			//layout will work just if it finds 1 action.
			if( this is Layout )
			{
				list = _scheme..action.( @id == action || @id == "*" );
				
				xml_node = XML( list.toXMLString( ) );
				
				//TODO: If target isnt rendered, redirect to home
				if( !controller( name ).layout.childs.has( "" ) )
				{
					//redirect
				}
			}
			
			list = xml_node.children( );
			
			if( list == null || !list.length( ) ) return assets;
			
			do
			{
				node = list[i];
					
				assets.push( _instantiate_view( node ) );
			} while( ++i < list.length( ) );
			
			
			return assets;
		}

		/**
		 * Instantiate a view based on a xml_node, if it already exists, 
		 * will just return the reference.
		 */
		internal function _instantiate_view( xml_node : XML ) : View 
		{
			var view : View;
			
			if( !xml_node.hasOwnProperty( 'id' ) && false )
			{
				log.warn( "Your view needs to have and id" );
				//FIXME: this ['id'] is becoming a child, not a prop
				xml_node[ 'id' ] = Math.random( ) * 100000000000;
				log.warn( "Assigned a random id: " + xml_node[ 'id' ] );
			}
			
			if( ( view = childs.by_id( xml_node.@id ) ) != null ) 
			{
				return childs.by_id( xml_node.@id );
			}
			
			return childs.create( xml_node );
		}

		public function before_render( request : Request ) : Boolean 
		{
			log.info( "Running..." );
			request;
			return true;
		}

		public function render( request : Request ) : *
		{
			if( !before_render( request ) ) return false;
			
			log.info( "Running..." );
			
			_instantiate_sprite( );
			
			_apply_styles( request );

			childs.render( request );
			
			return after_render( request );
		}

		/**
		 * Creates then attachs the view sprite
		 */
		private function _instantiate_sprite() : Boolean
		{
			if( sprite ) return false;
			
			sprite = new Sprite( );
			
			if( this == root )
				root.scope.addChild( sprite );
			else
				up.sprite.addChild( sprite );
			
			set_triggers( );
			
			return true;
		}

		/**
		 * Apply the styles for the current request
		 */
		private function _apply_styles( request : Request ) : void
		{
			//FIXME: Implement a real style system
			request;
			//properties rendering
			//need to think in a good automated process to apply it
			if( xml_node.@x )
				sprite.x = Number( xml_node.@x );
				 	
			if( xml_node.@y )
				sprite.y = Number( xml_node.@y ); 	
		}

		/**
		 * Called just after the render function
		 */
		public function after_render( request : Request ) : void
		{
			log.info( "Running..." );
			request;
		}

		/**
		 * Will check if user customized some events, if so, will plug
		 * then for the user.
		 * 
		 * Called automatically once - when creating the view sprite
		 */
		public function set_triggers() : void 
		{
			if( is_defined( 'click' ) )
				event( sprite, MouseEvent.CLICK, this[ 'click' ] );
				
			if( is_defined( 'mouse_over' ) )
				event( sprite, MouseEvent.MOUSE_OVER, this[ 'mouse_over' ] );
				
			if( is_defined( 'mouse_out' ) )
				event( sprite, MouseEvent.MOUSE_OVER, this[ 'mouse_out' ] );
				
			if( is_defined( 'mouse_up' ) )
				event( sprite, MouseEvent.MOUSE_UP, this[ 'mouse_up' ] );
				
			if( is_defined( 'mouse_down' ) )
				event( sprite, MouseEvent.MOUSE_UP, this[ 'mouse_down' ] );
			
			if( is_defined( 'double_click' ) )
				event( sprite, MouseEvent.DOUBLE_CLICK, this[ 'double_click' ] );
		}

		/**
		 * Should unset all possible triggers.
		 * 
		 * Called automatically once - when destroying the view
		 */
		public function unset_triggers() : void
		{
		}
		
		/**
		 * Destroy filter, if returns false, wont destroy
		 */
		public function before_destroy( request : Request ) : Boolean
		{
			log.info( "Running..." );
			request;
			return true;
		}

		public function destroy( request : Request ) : Boolean 
		{
			if( !before_destroy( request ) ) return false;
			
			log.info( "Running..." );
			
			return true;
		}

		public function after_destroy( request : Request ) : void 
		{
			log.info( "Running..." );
			request;
		}

		/** GETTERS / SETTERS **/
		public function get xml_node() : XML  
		{
			return _xml_node;
		}

		public function set xml_node( xml_node : XML ) : void 
		{
			_xml_node = xml_node;
		}

		public function get root() : Layout 
		{
			return ( up == null ) ? Layout( this ) : up.root;
		}

		public function get loader() : Slave
		{
			return root.loader;
		}

		public function get childs() : ViewStack
		{
			return _childs;
		}
	}
}