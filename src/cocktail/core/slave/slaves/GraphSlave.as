package cocktail.core.slave.slaves 
{
	import cocktail.core.slave.gunz.GraphSlaveBullet;
	import cocktail.core.slave.ASlave;
	import cocktail.core.slave.ISlave;
	import cocktail.core.slave.gunz.ASlaveBullet;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;

	/**
	 * GraphSlave is the responsible for loading any binary graphic asset, such
	 * as jpg, gif, png, swf etc. 
	 * @author nybras | nybras@codeine.it
	 */
	public class GraphSlave extends ASlave implements ISlave
	{
		/* VARS */
		private var _loader : Loader;
		private var _loader_info : LoaderInfo;
		private var _request : URLRequest;
		private var _target : DisplayObjectContainer;

		/* INITIALIZING */
		
		/**
		 * Creates a new GraphLoader instance.
		 * @param uri	Uniform Resource Identifier to be loaded.
		 * @param auto_load	If <code>true</code> all subsequent loading calls
		 * will start loading immediatelly, otherwise <code>false</code> you'll
		 * need to call the "load" method to start the loading process.
		 */
		public function GraphSlave(
			uri : String,
			auto_load : Boolean = false
		) : void
		{
			super( uri );
			
			_loader_info = ( _loader = new Loader( ) ).contentLoaderInfo;
			_loader_info.addEventListener( Event.OPEN, _start );
			_loader_info.addEventListener( ProgressEvent.PROGRESS, _progress );
			_loader_info.addEventListener( Event.INIT, _complete );
			_loader_info.addEventListener( IOErrorEvent.IO_ERROR, _error );
			
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
			gunz_complete.shoot( new GraphSlaveBullet( loaded, total, content ) );
			
			// putting
			if( _target != null )
				_target.addChild( content );
			
			_loader_info.removeEventListener( Event.OPEN, _start );
			_loader_info.removeEventListener( ProgressEvent.PROGRESS, _progress );
			_loader_info.removeEventListener( Event.INIT, _complete );
			_loader_info.removeEventListener( IOErrorEvent.IO_ERROR, _error );
		}

		/**
		 * Listen for error event and pull the SlaveTrigger.ERRO trigger.
		 * @param event	IOErrorEvent.IO_ERROR.
		 */
		private function _error( ev : IOErrorEvent ) : void
		{
			_status = ASlave._ERROR;
			gunz_error.shoot( new ASlaveBullet( -1, -1 ).inject( ev ) );
		}

		/* GETTERS */
		
		/**
		 * Computes the bytes total and return it.
		 * @return	Bytes total.
		 */
		public function get total() : Number
		{
			return _loader_info.bytesTotal;
		}

		/**
		 * Computes the bytes loaded and return it.
		 * @return	Bytes loaded.
		 */
		public function get loaded() : Number
		{
			return _loader_info.bytesLoaded;
		}

		/**
		 * Get the loaded content.
		 * @return	Loaded content.
		 */
		public function get content() : DisplayObject
		{
			return _loader_info.content;
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
		public function get loader() : Loader
		{
			return _loader;
		}

		/* PUTTING */
		
		/**
		 * Puts the loaded content into the given target, right after the
		 * loading process is completed.
		 * @param target	Target to put the loaded content into.
		 */
		public function put( target : DisplayObjectContainer ) : GraphSlave
		{
			_target = target;
			return this;
		}

		/* LOADNIG */
		
		/**
		 * Start the loading process.
		 * @return	Self reference for inline reuse.
		 */
		final public function load() : ISlave
		{
			if( _status != ASlave._QUEUED )
				return this;
			
			// updating status
			_status = ASlave._LOADING;
			
			// start loading
			_loader.load( _request );
			
			return this;
		}
	}
}