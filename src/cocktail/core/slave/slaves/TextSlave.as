package cocktail.core.slave.slaves 
{
	import flash.system.System;
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
		private var _trigger_set : Boolean = false;

		/* INITIALIZING */
		
		/**
		 * Creates a new GraphLoader instance.
		 * @param uri	Uniform Resource Identifier to be loaded.
		 * @param auto_load	If <code>true</code> all subsequent loading calls
		 * will start loading immediatelly, otherwise <code>false</code> you'll
		 * need to call the "load" method to start the loading process.
		 */
		public function TextSlave() : void
		{			
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

		/* LOADING */
		
		/**
		 * Start the loading process.
		 * @return	Self reference for inline reuse.
		 */
		final public function load( uri : String = null ) : ISlave
		{
			if( _status == ASlave._DESTROYED )
			{
				trace( "This class was destroyed! " +
				"You cannot load content anymore." );
				
				return this;
			}
			
			_uri = uri;
			
			unload();
			
			_loader  = new URLLoader( );
			_request = new URLRequest( uri );
			
			_set_triggers();
			
			// updating status
			_status = ASlave._LOADING;
			
			// start loading
			_loader.load( _request );
			
			return this;
		}
		
		/**
		 * Unload yhe last loaded content.
		 */
		public function unload() : ISlave
		{
			if ( _status == ASlave._LOADING )
				_loader.close();
			
			if ( _trigger_set )
				_unset_triggers();
			
			return this;
		}
		
		/**
		 * Destroy the slave.
		 * After this method call, this slave can't be loaded anymore.
		 */
		public function destroy() : ISlave
		{
			unload();
			
			_status = _DESTROYED;
			
			gunz.rm_all();
			
			System.gc();
			
			return this;
		}
		
		/* TRIGGERS */
		
		private function _set_triggers () : void
		{
			_loader.addEventListener( Event.OPEN, _start );
			_loader.addEventListener( ProgressEvent.PROGRESS, _progress );
			_loader.addEventListener( Event.COMPLETE, _complete );
			_loader.addEventListener( IOErrorEvent.IO_ERROR, _error );
			
			_trigger_set = true;
		}
		
		private function _unset_triggers () : void
		{
			if( _loader == null ) return;
			
			_loader.removeEventListener( Event.OPEN, _start );
			_loader.removeEventListener( ProgressEvent.PROGRESS, _progress );
			_loader.removeEventListener( Event.COMPLETE, _complete );
			_loader.removeEventListener( IOErrorEvent.IO_ERROR, _error );
			
			_trigger_set = false;
		}
	}
}
