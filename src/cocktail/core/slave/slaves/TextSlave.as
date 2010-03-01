package cocktail.core.slave.slaves 
{
	import cocktail.core.slave.ASlave;
	import cocktail.core.slave.ISlave;
	import cocktail.core.slave.gunz.ASlaveBullet;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * TextSlave is the responsible for loading any kind of text request, such
	 * as xml, txt, etc.
	 * @author nybras | nybras@codeine.it
	 */
	public class TextSlave extends ASlave implements ISlave 
	{
		/* VARS */
		private var _loader : URLLoader;
		private var _request : URLRequest;

		/* INITIALIZING */
		
		/**
		 * Creates a new GraphLoader instance.
		 * @param uri	Uniform Resource Identifier to be loaded.
		 * @param auto_load	If <code>true</code> all subsequent loading calls
		 * will start loading immediatelly, otherwise <code>false</code> you'll
		 * need to call the "load" method to start the loading process.
		 */
		public function TextSlave(
			uri : String,
			auto_load : Boolean = false
		) : void
		{
			super( uri );
			
			_loader = new URLLoader( );
			_loader.addEventListener( Event.OPEN, _start );
			_loader.addEventListener( ProgressEvent.PROGRESS, _progress );
			_loader.addEventListener( Event.COMPLETE, _complete );
			_loader.addEventListener( IOErrorEvent.IO_ERROR, _error );
			
			_request = new URLRequest( uri );
			
			if( auto_load )
				load( );
		}

		/* LISTENERS */
		
		/**
		 * Listen for open event and pull the SlaveTrigger.STAR trigger.
		 * @param ev	Event.OPEN.
		 */
		private function _start( ev : Event ) : void
		{
			gunz_start.shoot( new ASlaveBullet( loaded, total ) );
		}

		/**
		 * Listen for progress event and pull the SlaveTrigger.PROG trigger.
		 * @param ev	ProgressEvent.PROGRESS.
		 */
		private function _progress( ev : ProgressEvent ) : void
		{
			gunz_progress.shoot( new ASlaveBullet( loaded, total ) );
		}

		/**
		 * Listen for init event and pull the SlaveTrigger.COMP trigger.
		 * @param ev	Event.INIT.
		 */
		private function _complete( ev : Event ) : void
		{
			// updating status
			_status = ASlave._LOADED;
			
			// pull the trigger
			gunz_complete.shoot( new ASlaveBullet( loaded, total ) );
		}

		/**
		 * Listen for error event and pull the SlaveTrigger.ERRO trigger.
		 * @param event	IOErrorEvent.IO_ERROR.
		 */
		private function _error( ev : IOErrorEvent ) : void
		{
			_status = ASlave._ERROR;
			gunz_error.shoot( new ASlaveBullet( 0, 0 ) );
		}

		/* GETTERS */
		
		/**
		 * Computes the bytes total and return it.
		 * @return	Bytes total.
		 */
		public function get total() : Number
		{
			return _loader.bytesTotal;
		}

		/**
		 * Computes the bytes loaded and return it.
		 * @return	Bytes loaded.
		 */
		public function get loaded() : Number
		{
			return _loader.bytesLoaded;
		}

		/**
		 * Get the loaded data.
		 * @return	Loaded data.
		 */
		public function get data() : String
		{
			return String( _loader.data );
		}

		/**
		 * Get the url reference.
		 * @return	Url request reference.
		 */
		public function get request() : URLRequest
		{
			return _request;
		}

		/**
		 * Get the loader reference.
		 * @return	Loader reference.
		 */
		public function get loader() : URLLoader
		{
			return _loader;
		}

		/* LOADNIG */
		
		/**
		 * Start the loading process.
		 * @return	Self reference for inline reuse.
		 */
		final public function load( uri : String = null ) : ISlave
		{
			if( _status != ASlave._QUEUED )
				return this;
			
			// updating status
			_status = ASlave._LOADING;
			
			// start loading
			_loader.load( _request );
			
			return this;
		}
		
		public function unload() : ISlave
		{
			// TODO: Auto-generated method stub
			return null;
		}
		
		public function close() : ISlave
		{
			// TODO: Auto-generated method stub
			return null;
		}
		
		public function destroy() : ISlave
		{
			// TODO: Auto-generated method stub
			return null;
		}
	}
}
