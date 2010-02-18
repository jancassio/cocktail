package cocktail.lib 
{
	import cocktail.lib.view.ViewStack;

	import de.polygonal.ds.DListNode;

	public class View extends MVC 
	{
		/** Contains and indexes all the childs **/
		public var childs : ViewStack;
		/** The string identifier on the ViewStack **/
		public var identifier : String;
		/** The view node on the ViewStack DLinkedList **/
		public var node : DListNode;
		/** Reference to the view container **/
		private var parent : View;

		/**
		 * Initializes the view
		 */
		public function init( id : String ) : void
		{
			identifier = id;	
		}

		/**
		 * Adds a view to the view stack
		 * @param id The child
		 */
		public function add( id : String ) : View
		{
			if( !childs.has( id ) )
				childs.add( create( id ) );
			
			return childs.by_id( id );
		}

		/**
		 * Removes a view from the view stack
		 */
		public function remove( id : String ) : View
		{
			return childs.remove( id );
		}

		/**
		 * Creates a view from id
		 */
		private function create( id : String ) : View
		{
			var view : View;
			
			view = new View( );
			view.boot( _cocktail );
			view.parent = this;
			view.identifier = id;
			
			return view;
		}
	}
}