package cocktail.lib.view 
{
	import cocktail.core.Index;
	import cocktail.core.request.Request;
	import cocktail.lib.View;

	import de.polygonal.ds.DLinkedList;
	import de.polygonal.ds.DListNode;

	/**
	 * @author hems - hems@henriquematias.com
	 */
	public class ViewStack extends Index
	{
		public var ids : Object;
		
		/** Double linked list of view childs **/
		public var list : DLinkedList;

		/** 
		 * Everytime an action is rendered, cocktail needs to know
		 * who will be rendered and who will de destroyed in the view
		 * stack.
		 */
		private var _will_render : Object;

		/** The holder of the view stack **/
		private var _view : View;

		public function ViewStack( view: View )
		{
			ids = {};
			list = new DLinkedList( );
			_view = view;
		}

		/**
		 * Adds a view to the view stack
		 */
		public function add( view : View ) : View
		{
			if( has( view.identifier ) )
			{
				//TODO: just run the boot routine again
				log.error( "Identifier is unique in ViewStack" );
				
				return view;
			}
			
			//indexing child
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
			
			//removing from child index
			list.remove( list.nodeOf( by_id( id ) ) );
			ids[ id ] = null;
			
			return null;
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
		public function clear_render_poll(): void
		{
			_will_render = {};
		}
		
		/**
		 * Mark the view as renderable
		 */
		public function mark_as_alive( view: View ): View
		{
			_will_render[ view.identifier ] = true;
			
			return view;
		}

		/**
		 * Will execute render on alive views and destroy on dead views
		 */
		public function render( request: Request ) : void 
		{
			var node: DListNode;
			var view: View;
			
			node = list.head;
			while ( node )
			{
				view = node.data;
				
				if( _will_render[ view.identifier ] )
					view.render( request );
				else
					view.destroy( request );
					
				node = node.next;
			}
			
			//reset render flags
			_will_render = {};
		}

		public function create( xml_node : XML ) : View 
		{
			var view: View;
			var path: String;
			
			path = parent.root.name + '.' + xml_node.attribute( 'class' );
			
			view = View( new ( _cocktail.factory.view( path ) ) );
			view.boot( _cocktail );
			view.identifier = xml_node.attribute( 'id' );
			view.xml_node = xml_node;
			
			return view;
		}
		
		public function get parent() : View
		{
			return _view;
		}
	}
}
