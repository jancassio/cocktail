package cocktail.lib.view 
{
	import cocktail.core.Index;
	import cocktail.lib.View;

	import de.polygonal.ds.DLinkedList;

	/**
	 * @author hems - hems@henriquematias.com
	 */
	public class ViewStack extends Index
	{
		public var ids : Object;
		public var list : DLinkedList;

		public function ViewStack()
		{
			ids = {};
			list = new DLinkedList( );
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
	}
}
