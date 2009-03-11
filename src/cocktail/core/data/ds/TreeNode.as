package cocktail.core.data.ds 
{	import cocktail.core.Index;					

	/**	 * @author nybras | nybras@codeine.it	 */	public class TreeNode extends Index 
	{
		private var _up: TreeNode;
		private var _prev: TreeNode;
		private var _next: TreeNode;
		
		private var _data : *;
		private var _stack : *;
		private var _depth: uint;
		
		
		
		public function TreeNode ( data : * )
		{
			_stack = {};			_data = data;		}
		
		
		
		public function get depth(): uint
		{
			return _depth;
		}

		public function get next(): TreeNode
		{
			return _next;
		}

		public function get prev(): TreeNode
		{
			return _prev;
		}

		public function size(): TreeNode
		{
			return _stack.le
		}

		public function size(): TreeNode
		{
		}
	}}