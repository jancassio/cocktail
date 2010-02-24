package cocktail.lib 
{
	import cocktail.lib.base.MVL;
	import cocktail.lib.view.ViewStack;

	import de.polygonal.ds.DListNode;

	public class View extends MVL 
	{
		/** Contains and indexes all the childs **/
		public var childs : ViewStack;
		/** The string identifier on parent's ViewStack **/
		public var identifier : String;
		/** The view node on the ViewStack DLinkedList **/
		public var node : DListNode;
		/** Reference to the parent view container **/
		private var up : View;

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
		public function add( id : String, path : String ) : View
		{
			if( !childs.has( id ) )
				childs.add( create( id, path ) );
			
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
		private function create( id : String, path : String ) : View
		{
			var view : View;

			view = View( new ( _cocktail.factory.view( path ) ) );
			view.boot( _cocktail );
			view.up = this;
			view.identifier = id;
			
			return view;
		}
	}
}