package cocktail.core.slave 
{
	import cocktail.core.slave.slaves.VideoSlave;
	import cocktail.core.slave.gunz.ASlaveBullet;
	import cocktail.core.slave.slaves.GraphSlave;
	import cocktail.core.slave.slaves.TextSlave;

	import de.polygonal.ds.DListIterator;
	import de.polygonal.ds.DListNode;
	import de.polygonal.ds.Iterator;

	/**
	 * Slave is a loading library.
	 * @author nybras | nybras@codeine.it
	 */
	public class Slave extends ASlave implements ISlave
	{
		/* VARS */
		private var _auto_load : Boolean;
		private var _started : int;
		private var _completed : int;

		/* INITIALIZING */
		
		/**
		 * Creates a new Slave.
		 * @param auto_load	If <code>true</code> all subsequent loading calls
		 * will start loading immediatelly, otherwise <code>false</code> you'll
		 * need to call the "load" method to start the loading process.
		 */
		public function Slave( auto_load : Boolean = false )
		{
			super( );
			_auto_load = auto_load;
		}

		/* LOADING */
		
		/**
		 * Start the loading process.
		 */
		public function load() : ISlave
		{
			var i : DListIterator;
			
			if( _auto_load )
				return this;
			
			i = DListIterator( dlist.getIterator( ) );
			while( i.hasNext( ) )
				DListNode( i.next( ) ).data[ "load" ]( );
			
			return this;
		}

		/* SHORTCUTS */
		
		/**
		 * Loads any binary graphic asset, such as jpg, gif, png, swf etc.
		 * @param uri	Uniform Resource Identifier to be loaded.
		 * @return	The created and appended GraphSlave instance.
		 */
		public function graph( uri : String ) : GraphSlave
		{
			return _queue( new GraphSlave( uri, _auto_load ) );
		}

		/**
		 * Loads any text request, such as xml, txt, etc.
		 * @param uri	Uniform Resource Identifier to be loaded.
		 * @return	The created and appended TextSlave instance.
		 */
		public function text( uri : String ) : TextSlave
		{
			return _queue( new TextSlave( uri, _auto_load ) );
		}
		
		/**
		 * Loads any video request (.flv).
		 * @param uri	Uniform Resource Identifier to be loaded.
		 * @return	The created and appended VideoSlave instance.
		 */
		public function video( uri : String ) : VideoSlave
		{
			return _queue( new VideoSlave( uri, _auto_load ) );
		}

		//		/**
		//		 * TODO: write docs
		//		 */
		//		public function au( uri : String ) : AudioSlave
		//		{
		//			return _queue( new AudioSlave( uri, _auto_load ) );
		//		}
		//
		//		/**
		//		 * TODO: write docs
		//		 */		
		//		public function vi( uri : String ) : VideoSlave
		//		{
		//			 return _queue( new VideoSlave( uri, _auto_load ) );
		//		}
		//
		//		/**
		//		 * TODO: write docs
		//		 */
		//		public function amf( uri : String ) : AmfSlave
		//		{
		//			return _queue( new AmfSlave( uri, _auto_load ) );
		//		}
		//
		//		/**
		//		 * TODO: write docs
		//		 */
		//		public function collada( uri : String ) : ColladaSlave
		//		{
		//			return _queue( new ColladaSlave( uri, _auto_load ) );
		//		}
		
		
		
		/* QUEUE */
		
		/**
		 * Enqueue the given slave item.
		 * @param slave	Slave item to be queued.
		 */
		private function _queue( slave : ASlave ) : *
		{
			slave.gunz_start.add( _start );
			slave.gunz_progress.add( _progress );
			slave.gunz_complete.add( _complete );
			slave.gunz_error.add( _error );
			
			dlist.append( slave.node );
			
			return slave;
		}

		/* LISTENERS */
		
		/**
		 * Listen for loading start and repass the event.
		 * @param bullet	SlaveBullet.STAR
		 */
		private function _start( bullet : ASlaveBullet ) : void
		{
			ASlave( bullet.owner ).gunz_start.rm( _start );
			if( !_started++ )
				gunz_start.shoot( new ASlaveBullet( loaded, total ) );
		}

		/**
		 * Listen for loading progress and repass the event.
		 * @param bullet	SlaveBullet.PROG
		 */
		private function _progress( bullet : ASlaveBullet ) : void
		{
			bullet;
			gunz_progress.shoot( new ASlaveBullet( loaded, total ) );
		}

		/**
		 * Listen for loading complete and repass the event.
		 * @param bullet	SlaveBullet.COMP
		 */
		private function _complete( bullet : ASlaveBullet ) : void
		{
			ASlave( bullet.owner ).gunz_progress.rm( _progress );
			ASlave( bullet.owner ).gunz_complete.rm( _progress );
			if( ++_completed == length )
				gunz_complete.shoot( new ASlaveBullet( loaded, total ) );
		}

		/**
		 * Listen for loading error and repass the event.
		 * @param bullet	SlaveBullet.ERRO
		 */
		private function _error( bullet : ASlaveBullet ) : void
		{
			ASlave( bullet.owner ).gunz_error.rm( _error );
			gunz_error.shoot( new ASlaveBullet( loaded, total ) );
		}

		/* APPENDING ANOTHERS SLAVES */
		
		/**
		 * Append the given slave into this one.
		 * @param slave	Slave instance to be appended.
		 * @return	A self reference for inline reuse.
		 */
		public function append( slave : ASlave ) : ASlave
		{
			var i : Iterator;
			var node : ASlave;
			
			i = dlist.getIterator( );
			while( i.hasNext( ) )
			{
				node = i.next( )[ "data" ];
				node.gunz_start.add( _start );
				node.gunz_progress.add( _progress );
				node.gunz_complete.add( _complete );
				node.gunz_error.add( _error );
			}
			
			dlist = dlist.concat( slave.dlist );
			
			return this;
		}

		/* GETTERS - items */
		
		/**
		 * Computes the childs length and return it.
		 * @return	The childs length.
		 */
		public function get length() : int
		{
			return dlist.size;
		}

		/**
		 * Counts the total of items already loaded.
		 * @return	The number of items already loaded.
		 */
		public function get loaded_items() : int
		{
			return _completed;
		}

		/**
		 * Counts the total of items being loaded.
		 * @return	The number of items being loaded.
		 */
		public function get loading_items() : int
		{
			return ( _started - _completed );
		}

		/* GETTERS - bytes */
		
		/**
		 * Computes the bytes total and return it.
		 * @return	Bytes total.
		 */
		public function get total() : Number
		{
			var i : DListIterator;
			var slave : ISlave;
			var total : Number;
			  
			i = DListIterator( dlist.getIterator( ) );
			total = 0;
			
			while( i.hasNext( ) )
			{
				slave = DListNode( i.next( ) ).data;
				if( slave.status != ASlave._QUEUED )
					total += slave.total;
			}
			
			return total;
		}

		/**
		 * Computes the bytes total and return it.
		 * @return	Bytes total.
		 */
		public function get loaded() : Number
		{
			var i : DListIterator;
			var slave : ISlave;
			var loaded : Number;
			  
			i = DListIterator( dlist.getIterator( ) );
			loaded = 0;
			
			while( i.hasNext( ) )
			{
				slave = DListNode( i.next( ) ).data;
				if( slave.status != ASlave._QUEUED )
					loaded += slave.loaded;
			}
			
			return loaded;
		}
	}
}