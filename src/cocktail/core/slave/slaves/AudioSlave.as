package cocktail.core.slave.slaves 
{
	import cocktail.core.slave.ASlave;
	import cocktail.core.slave.ISlave;
	import cocktail.core.slave.gunz.ASlaveBullet;
	import cocktail.core.slave.gunz.AudioSlaveBullet;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;

	/**
	 * @author rafael cordoba | rafael@rafaelcordoba.com
	 */
	public class AudioSlave extends ASlave implements ISlave
	{
		private var _request : URLRequest;
		private var _sound : Sound;

		public function AudioSlave( 
			uri : String,
			auto_load : Boolean = false
		) : void
		{
			super( uri );
			
			_uri = uri;
			
			_init();
			
			if( auto_load )
				load( );
		}
		
		private function _init() : void
		{
			_request = new URLRequest( _uri );
			_sound = new Sound();
			
			_set_triggers();
		}
		
		/* LISTENERS */
		
		/**
		 * Listen for open event and pull the SlaveTrigger.STAR trigger.
		 * @param ev	Event.OPEN.
		 */
		private function _start( ev : Event ) : void
		{
			gunz_start.shoot( new AudioSlaveBullet( loaded, total, sound ) );
		}

		/**
		 * Listen for progress event and pull the SlaveTrigger.PROG trigger.
		 * @param ev	ProgressEvent.PROGRESS.
		 */
		private function _progress( ev : ProgressEvent ) : void
		{
			gunz_progress.shoot( new AudioSlaveBullet( loaded, total, sound ) );
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
			gunz_complete.shoot( new AudioSlaveBullet( loaded, total, sound ) );
			
			_unset_triggers();
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
		
		/* LOADNIG */
		
		/**
		 * Start the loading process.
		 * @return	Self reference for inline reuse.
		 */
		final public function load( uri : String = null ) : ISlave
		{
			if ( uri )
				_uri = uri;
				
			if( _status != ASlave._QUEUED )
				return this;
			
			// updating status
			_status = ASlave._LOADING;
            
			if ( !_sound || !_request )
				_init();
			
			_sound.load( _request );
			
			return this;
		}
		
		/* TRIGGERS */
		
		private function _set_triggers() : void
		{
			_sound.addEventListener( Event.OPEN, _start );
			_sound.addEventListener( ProgressEvent.PROGRESS, _progress );
			_sound.addEventListener( IOErrorEvent.IO_ERROR, _error );
			_sound.addEventListener( Event.COMPLETE, _complete );
		}
		
		private function _unset_triggers() : void
		{
			_sound.removeEventListener( Event.OPEN, _start );
			_sound.removeEventListener( ProgressEvent.PROGRESS, _progress );
			_sound.removeEventListener( Event.INIT, _complete );
			_sound.removeEventListener( IOErrorEvent.IO_ERROR, _error );
		}
		
		/* GETTERS */
		
		/**
		 * Computes the bytes total and return it.
		 * @return	Bytes total.
		 */
		public function get total() : Number
		{
			return _sound.bytesTotal;
		}

		/**
		 * Computes the bytes loaded and return it.
		 * @return	Bytes loaded.
		 */
		public function get loaded() : Number
		{
			return _sound.bytesLoaded;
		}

		/**
		 * Get the loaded content.
		 * @return	Loaded content.
		 */
		public function get sound() : Sound
		{
			return _sound;
		}
		
		/**
		 * Unload content.
		 * @return	ISlave.
		 */
		public function unload() : ISlave
		{
			_unset_triggers();
			
			try { _sound.close(); } catch ( e : Error ) { trace ( e ); };
			
			_sound = null;
			_request = null;
			
			return null;
		}
		
		/**
		 * Unload content and remove gunz listeners.
		 * @return	ISlave.
		 */
		public function destroy() : ISlave
		{
			unload( );
			
			gunz_complete.rm_all();
			gunz_progress.rm_all();
			gunz_start.rm_all();
			
			return null;
		}
	}
}
