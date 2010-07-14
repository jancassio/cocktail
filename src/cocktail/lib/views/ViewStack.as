package cocktail.lib.views 
{
	import cocktail.core.Index;
	import cocktail.core.gunz.Gun;
	import cocktail.core.gunz.GunzGroup;
	import cocktail.core.request.Request;
	import cocktail.lib.View;
	import cocktail.lib.gunz.ViewBullet;
	import cocktail.utils.StringUtil;

	import de.polygonal.ds.DLinkedList;
	import de.polygonal.ds.DListNode;

	import flash.utils.Dictionary;

	/**
	 * @author hems - hems@henriquematias.com
	 */
	public class ViewStack extends Index
	{
		/**
		 * ATT: May be will be usefull when coding 
		 * different action/layout transitions
		 */
		public var WILL_WAIT_DESTROY_BEFORE_TRIGGER_RENDER_DONE : Boolean;

		public var on_render_complete : Gun;

		/** The "owner" of the view stack **/
		private var _view : View;
		
		private var _group_rendering : GunzGroup;

		/** Double linked list of view childs **/
		public var list : DLinkedList;

		/** maping view's ids as key on a dictonary **/
		public var ids : Dictionary;
		
		/** 
		 * Everytime an action is rendered, cocktail needs to know
		 * who will be rendered and who will de destroyed in the view
		 * stack.
		 */
		private var _will_render : Object;

		/** Last rendered request **/
		private var _request : Request;

		public function ViewStack( view : View )
		{
			ids = new Dictionary( true );
			_view = view;
			
			list = new DLinkedList( );
			on_render_complete = new Gun( view.gunz, this, "render_complete" );
			
			WILL_WAIT_DESTROY_BEFORE_TRIGGER_RENDER_DONE = false;
		}

		/**
		 * Adds a view to the view stack
		 */
		public function add( view : View ) : View
		{
			if( has( view.identifier ) )
			{
				/**
				 * TODO: wont add a identifier twice, instead we need to think... 
				 * in a good way to pass those params to the already rendered 
				 * child
				 */
				log.error( "Identifier is unique in ViewStack" );
				
				return view;
			}
			
			// indexing child
			ids[ view.identifier ] = view;
			view.node = list.append( view );
			
			return view;
		}

		/**
		 * Remove a view from the index
		 */
		public function remove( id : String ) : View
		{
			if( !has( id ) )
			{
				log.error( "Requested identifier ( " + id + " ) isnt in the ViewStack" );
				
				return null;
			}
			
			by_id( id ).gunz_destroy_done.add( _after_child_destroy );
			by_id( id ).destroy( _request );
			
			return null;
		}

		private function _after_child_destroy( bullet : ViewBullet ) : void 
		{
			var view : View;
			
			view = bullet.owner;
			
			//removing from child index
			list.remove( list.nodeOf( view.identifier ) );
			ids[ view.identifier ] = null;
			
			if( _will_render.hasOwnProperty( view.identifier ) )
				_will_render[ view.identifier ] = null;
		}

		/**
		 * @return True if the identifier is already in the view stack
		 */
		public function has( id : String ) : Boolean
		{
			return ids[ id ] != null;
		}

		/**
		 * Get a view by id on the viewStack
		 */
		public function by_id( id : String ) : View
		{
			if( has( id ) ) 
				return ids[ id ];
			
			return null;
		}

		/**
		 * The method name is self explainatory
		 */
		public function clear_render_poll() : void
		{
			_will_render = {};
		}

		/**
		 * Mark the view as renderable
		 */
		public function mark_as_alive( view : View ) : View
		{
			_will_render[ view.identifier ] = true;
			
			return view;
		}

		/**
		 * Will execute render on alive views and destroy on dead views
		 */
		public function render( request : Request ) : void 
		{
			var node : DListNode;
			var view : View;
			
			// no childs, no render
			if( !list.size ) return;
			
			log.info( "Running..." );
			
			_request = request;
			_group_rendering = new GunzGroup( );
			_group_rendering.gunz_complete.add( _after_render );
			
			//populating group	
			node = list.head;
			while ( node )
			{
				view = node.data;

				if( _will_render[ view.identifier ] )
					_group_rendering.add( view.gunz_render_done );
				else
					if( WILL_WAIT_DESTROY_BEFORE_TRIGGER_RENDER_DONE )
						_group_rendering.add( view.gunz_destroy_done );
					
				node = node.next;
			}
			
			/*
			 *  made two independent functions to easily implement transitions
			 *  in a near future.
			 */
			_destroy_all(); /* ¿ transition ? */ _render_all();
			
			//reset render poll
			_will_render = {};
		}

		/**
		 * Run trough all views, and call destroy in those that arent in the
		 * current request
		 */
		private function _destroy_all() : void 
		{
			var node : DListNode;
			var view: View;
			
			node = list.head;
			while ( node )
			{
				view = node.data;
				
				if( !_will_render[ view.identifier ] )
					view.destroy( request );
					
				node = node.next;
			}
		}

		/**
		 * Run trough all views, and call render in those that arent in the
		 * current request
		 */
		private function _render_all() : void 
		{
			var node : DListNode;
			var view: View;
			
			node = list.head;
			while ( node )
			{
				view = node.data;
				
				if( _will_render[ view.identifier ] )
					view.render( request );
					
				node = node.next;
			}
		}

		/**
		 * Victim of _group_rendering
		 * 
		 * @see	ViewStack#render
		 * 
		 * @see	ViewStack#_group_rendering
		 */
		private function _after_render() : void 
		{
			log.info( "Running..." );
			
			on_render_complete.shoot( new ViewBullet( ) );
		}

		/**
		 * Instantiate a view based on a xml_node
		 */
		public function create( xml_node : XML ) : View 
		{
			var created : View;
			var area_path : String;
			var path : String;
			
			area_path = StringUtil.toUnderscore( view.root.name );
			
			if( xml_node.attribute( 'class' ).toString( ) )
				path = StringUtil.toCamel( xml_node.attribute( 'class' ) );
			else
				path = StringUtil.toCamel( xml_node.localName( ) );
			
			created = View( new ( _cocktail.factory.view( area_path, path ) ) );
			created.xml_node = xml_node;
			created.up = view;
			
			//ATT: boot should be runned after setting props
			created.boot( _cocktail );
			
			return list.append( created ).data;
		}

		/**
		 * Reference to the stack owner
		 */		
		public function get view() : View
		{
			return _view;
		}

		/** 
		 * Last rendered request 
		 **/
		public function get request() : Request
		{
			return _request;
		}
	}
}
