package cocktail.lib 
{
	import cocktail.Cocktail;
	import cocktail.core.gunz.Gun;
	import cocktail.core.request.Request;
	import cocktail.core.slave.ASlave;
	import cocktail.core.slave.ISlave;
	import cocktail.core.slave.Slave;
	import cocktail.core.slave.gunz.ASlaveBullet;
	import cocktail.lib.views.ViewStack;

	import de.polygonal.ds.DListNode;

	import flash.display.Sprite;

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
			
			sprite = null;
			
			return s;
		}

		/* basic api */
		
		/**
		 * Returns desired atribute in xml_node.
		 * 
		 * i.e. attribute( 'x' )
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

			_load_attributes( );
			
			if( assets.length == 0 ) return true;
			
			//PIMP: use a lambda to run all selected assets				
			do 
			{
				view = assets[ i ];
				
				childs.mark_as_alive( view );
				
				view.load( request );
			} while( ++i < assets.length );

			return true;
		}

		/**
		 * Loads tag attributes into view.
		 * 
		 * Currently only reading "src" attribute.
		 */
		internal function _load_attributes() : void 
		{
			if( attribute( 'src' ) )		
				src = root.name + "/" + attribute( "src" );
		}

		/**
		 * This function is a victim from _src_slave's gunz_complete.
		 * 
		 * If your view has any kind of source, you should override this
		 * function and save a typed reference for it.
		 * 
		 * Also your view should extend the respective kind of view.
		 */
		protected function source_loaded( bullet : ASlaveBullet ) : void
		{
			log.error( "This function should be overrided by your view" );
			bullet;
		}
		
		/**
		 * This function is a victim from _src_slave's gunz_error.
		 * 
		 * If your view has any kind of source, you should override to
		 * make a custom error handling
		 * 
		 */
		protected function load_fails( bullet : ASlaveBullet = null ) : void
		{
			log.notice( "This function could be overrided by your view" );
			bullet;
		}

		/**
		 * Parses all necessary Views for given request.
		 * 
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
			
			list = xml_node.children( );
			
			// return home early!
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

		/**
		 * Render itself and the children.
		 * 
		 * Wont render if before_render returns false
		 */
		public function render( request : Request ) : *
		{
			if( !before_render( request ) ) return false;
			
			log.info( "Running..." );
			
			if( sprite == null )
				_instantiate_display( );
			
			_apply_styles( request );

			childs.render( request );
			
			return after_render( request );
		}

		/**
		 * Creates then attachs the view sprite.
		 * 
		 * You view should override this function if it has a different
		 * kind of display.
		 * 
		 * ATT: Called by render method when sprite == null
		 */
		protected function _instantiate_display() : *
		{
			sprite = new Sprite( );
			
			return up.sprite.addChild( sprite );
		}

		/**
		 * Apply the styles for the current request
		 */
		private function _apply_styles( request : Request ) : void
		{
			//FIXME: Implement a style system
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
		
		/** Alias to the main view ( layout ) of the viewstack **/
		public function get root() : Layout 
		{
			return ( up == null ) ? Layout( this ) : up.root;
		}

		/** Alias to layout loader **/
		public function get loader() : Slave
		{
			return root.loader;
		}

		/** Getter for the viewstack **/
		public function get childs() : ViewStack
		{
			return _childs;
		}

		/** Returns the raw XML of this view **/
		public function get xml_node() : XML  
		{
			return _xml_node;
		}

		/** Set the xml_node for this view **/
		public function set xml_node( xml_node : XML ) : void 
		{
			_xml_node = xml_node;
		}

		
		/** 
		 * ATRIBUTTE SETTERS
		 * 
		 * This setters will receive the properties from xml_node, each
		 * time the "load" method is called
		 */
		 
		/**
		 * Unload the current source if any, then load the new path
		 * 
		 * Will load using _src_slave
		 * 	on_complete triggers source_loaded
		 * 	on_error triggers load_fails
		 * 
		 * @param path	Path to the desired asset
		 */
		public function set src( path : String ) : void
		{
			if( _src_slave != null )
			{
				if( _src_slave.uri == path ) 
				{
					return;
				}
				else if( _src_slave.is_loaded )
				{
					ISlave( _src_slave ).destroy( );
				}
			}
			
			_src_slave = load_uri( path, false ); 
			
			_src_slave.on_error.add( load_fails );
			_src_slave.on_complete.add( source_loaded );
			
			loader.append( _src_slave );
		}
		
		/**
		 * Alias to _src_slave.uri
		 * 	if nothing was loaded here yet, returns null
		 */
		public function get src(): String
		{
			if( !_src_slave ) return null;
			
			return _src_slave.uri;
		}
	}
}