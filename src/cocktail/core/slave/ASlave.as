package cocktail.core.slave 
{
	import cocktail.core.gunz.Gun;
	import cocktail.core.gunz.Gunz;
	import cocktail.core.slave.slaves.AudioSlave;
	import cocktail.core.slave.slaves.GraphSlave;
	import cocktail.core.slave.slaves.TextSlave;
	import cocktail.core.slave.slaves.VideoSlave;

	import de.polygonal.ds.DLinkedList;
	import de.polygonal.ds.DListNode;

	/**
	 * Slave extends the ASlave and adds some functionality to it, becoming
	 * the base class for every slave in this package.
	 * 
	 * @author nybras | nybras@codeine.it
	 * @author hems | henrique@codeine.it
	 */
	public class ASlave 
	{
		/** GUNZ **/
		
		public var gunz : Gunz;

		public var on_start : Gun;

		public var on_progress : Gun;

		public var on_complete : Gun;

		public var on_error : Gun;

		/**  CONSTANTS **/
		
		protected static const _QUEUED : String = "queued";

		protected static const _LOADING : String = "loading";

		protected static const _LOADED : String = "loaded";

		protected static const _ERROR : String = "error";

		protected static const _DESTROYED : String = "destroyed";

		/** VARS **/
		
		protected var _uri : String;

		protected var _node : DListNode;

		protected var _status : String;

		public var dlist : DLinkedList;

		/**
		 * Instantiate a slave based on uri
		 * @param uri	Path of the desired file
		 */
		public static function slave( uri : String ) : ASlave 
		{
			switch( uri.toLowerCase( ).split( "." ).pop( ) )
			{
				case "flv":
				case "mov":
					return new VideoSlave( );
				
				case "mp3":
				case "wav":
					return new AudioSlave( );
				
				case "xml":
					return new TextSlave( );
					break;
				
				case "jpg": 
				case "jpeg": 
				case "png": 
				case "gif": 
				case "swf":
					return  new GraphSlave( );
				
				default:
					return new TextSlave( );
			}
		}
		
		/* INITIALIZING */
		
		/**
		 * Creates a new Slave instance.
		 * @param uri	Uniform Resource Identifier to be loaded.
		 */
		public function ASlave( uri : String = null )
		{
			_init_gunz( );
			_uri    = uri;
			_status = _QUEUED;
		}

		private function _init_gunz() : void
		{
			gunz = new Gunz( this );
			on_start = new Gun( gunz, this, "start" );
			on_progress = new Gun( gunz, this, "progress" );
			on_complete = new Gun( gunz, this, "complete" );
			on_error = new Gun( gunz, this, "error" );
		}

		/* GETTERS */
		
		/**
		 * Get the item status, that could be:
		 * 	1- queued
		 * 	2- loading
		 * 	3- loaded
		 * 	4- error
		 * 	5- destroyed
		 * @return	Item status.
		 */
		final public function get status() : String
		{
			return _status;
		}

		/**
		 * Returns the slave node, in the linked list.
		 * @param	Slave node.
		 */
		final public function get node() : DListNode
		{
			return _node;
		}

		/**
		 * Returns the slave node, in the linked list.
		 * @param	Slave node.
		 */
		final public function set node( node : DListNode ) : void
		{
			_node = node;
		}

		/**
		 * Returns the slave prev node, in the linked list.
		 * @param	Slave prev node.
		 */
		final public function get prev() : DListNode
		{
			return _node.prev;
		}

		/**
		 * Returns the slave next node, in the linked list.
		 * @param	Slave next node.
		 */
		final public function get next() : DListNode
		{
			return _node.next;
		}

		public function get uri() : String 
		{
			return _uri;
		}

		public function set uri(uri : String) : void 
		{
			_uri = uri;
		}
	
		/** QUESTION GETTERS **/
		
		public function get is_queued(): Boolean
		{
			return status == _QUEUED;
		}

		public function get is_loading(): Boolean
		{
			return status == _LOADING;
		}

		public function get is_loaded(): Boolean
		{
			return status == _LOADED;
		}
		
		public function get is_error(): Boolean
		{
			return status == _ERROR;
		}

		public function get is_destroyed(): Boolean
		{
			return status == _DESTROYED;
		}

	}
}