package cocktail.core.slave.slaves 
{
	import cocktail.core.slave.gunz.VideoSlaveBullet;
	import cocktail.core.slave.ASlave;
	import cocktail.core.slave.ISlave;

	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Timer;

	/**
	 * @author nybras | nybras@codeine.it
	 */
	public class VideoSlave extends ASlave implements ISlave
	{
		/* VARS */
		private var _netconn : NetConnection;
		private var _netstream : NetStream;
		private var _target : Video;
		private var _trigger_set : Boolean = false;
		
		private var _progress_timer : Timer;
		private const DEFAULT_TIMER_DELAY: Number = 10;
//		private var _stream_paused : Boolean;

		/**
		 * Construct a new VideoSlave object.
		 * 
		 * @param uri The video URL.
		 * @param auto_load If true, the load is started automatically.
		 * @param target The video target to render the stream.
		 */
		public function VideoSlave() : void
		{
			
		}

		/**
		 * Start the loading process.
		 * @return	Self reference for inline reuse.
		 */
		public function load( uri : String = null ) : ISlave
		{
			// Check if this class was destroyed
			if( _status == ASlave._DESTROYED )
			{
				trace( "This class was destroyed! " +
				"You cannot load content anymore." );
				return this;
			}
			
			// Change _uri with new value
			if ( uri != null)
				_uri = uri;
			
			// Lock loading if _uri is null
			if ( _uri == null )
			{
				trace( "Set the uri param before loading." );
				return this;
			}
				
			_progress_timer = new Timer( DEFAULT_TIMER_DELAY );
			
			_netconn = new NetConnection( );
			_netconn.connect( null );
			
			// updating status
			_status = ASlave._LOADING;
			
			// start connection
			_netstream = new NetStream( _netconn );
			_netstream.client = new StatusHandler( );
			
			if( _target )
				_target.attachNetStream( _netstream );
				
			_netstream.play( _uri );
			_netstream.pause();
			
			_set_triggers();
			
			gunz_start.shoot( new VideoSlaveBullet( loaded, total ) );
			
			return this;
		}
		
		private function _set_triggers() : void
		{
			_netconn.addEventListener( 	NetStatusEvent.NET_STATUS, 
										_on_net_status );
			_netconn.addEventListener( 	SecurityErrorEvent.SECURITY_ERROR, 
										_on_security_error );
			
			_netstream.addEventListener( NetStatusEvent.NET_STATUS, 
											_on_net_status );
			_netstream.addEventListener( AsyncErrorEvent.ASYNC_ERROR, 
											_on_net_status );
			
			_progress_timer.addEventListener( TimerEvent.TIMER, _pull_time );
			_progress_timer.start();
			
			_trigger_set = true;
		}
		
		private function _unset_triggers() : void
		{
			_netconn.removeEventListener( NetStatusEvent.NET_STATUS, 
										_on_net_status );
			_netconn.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, 
										_on_security_error );
			
			_netstream.removeEventListener( NetStatusEvent.NET_STATUS, 
											_on_net_status );
			_netstream.removeEventListener( AsyncErrorEvent.ASYNC_ERROR, 
											_on_net_status );
			
			_progress_timer.stop();
			_progress_timer.removeEventListener( TimerEvent.TIMER, _pull_time );
			
			_trigger_set = false;
		}

		/**
		 * Computes the bytes total and return it.
		 * @return	Bytes total.
		 */
		public function get total() : Number
		{
			return _netstream.bytesTotal;
		}

		/**
		 * Computes the bytes loaded and return it.
		 * @return	Bytes loaded.
		 */
		public function get loaded() : Number
		{
			return _netstream.bytesLoaded / _netstream.bytesTotal;
		}

		/* PUTTING */
		
		/**
		 * Puts the loaded content into the given target, right after the
		 * loading process is completed.
		 * @param target	Target to put the loaded content into.
		 * @return Self reference for inline reuse.
		 */
		public function put( target : Video ) : VideoSlave
		{
			_target = target;
			return this;
		}

		/* HANDLERS */
		
		/**
		 * Invoked by the timer to calc the buff progress and shoot the gun.
		 * 
		 * @param event TimerEvent.
		 */
		private function _pull_time( event: TimerEvent ) : void
		{
			gunz_progress.shoot( new VideoSlaveBullet( loaded, total ) );
		}
		
		/**
		 * Handler to all th connection/status event types.
		 * 
		 * @param event NetStatusEvent.
		 */
		private function _on_net_status( event : NetStatusEvent ) : void
		{
			switch ( event.info[ "code" ] ) 
			{
				case "NetConnection.Connect.Success":
					//Success
					break;
				case "NetStream.Play.StreamNotFound":
					gunz_error.shoot( new VideoSlaveBullet( loaded, total,
					 "Unable to locate video: " + _uri ) );
					break;
				case "NetStream.Buffer.Full":
					if( _status == ASlave._LOADED )
						break;
					_status = ASlave._LOADED;
					
					_unset_triggers();
					
					break;	
			}
		}
		
		/**
		 * Handler to the security or IO possible errors on the stream.
		 * 
		 * @param event NetStatusEvent
		 */
		private function _on_security_error( event : NetStatusEvent ) : void
		{
			gunz_error.shoot( new VideoSlaveBullet( loaded, total ) );
		}
		
		/* GETTERS */
		
		/**
		 * Return the NetStream object used to load and controll the video 
		 * stream.
		 * 
		 * @return NetStream object.
		 */
		public function get net_stream () : NetStream
		{
			return _netstream;
		}
		
		public function unload() : ISlave
		{
			_netconn.close();
			_netstream.close( );
			
			if ( _trigger_set )
				_unset_triggers();
				
			_progress_timer = null;
			
			if( _target )
				_target.clear();
			_target = null;
			
			return null;
		}
		
		public function destroy() : ISlave
		{
			// TODO: Auto-generated method stub
			return null;
		}
		
		
		/* STREAM CONTROLS */
		
//		/**
//		 * Stop the stream.
//		 */
//		public function stop () : VideoSlave
//		{
//			_stream_paused = true;
//			_netstream.seek( 0 );
//			_netstream.pause();
//			return this;
//		}
//		
//		/**
//		 * Play or pause the stream.
//		 */
//		public function play_pause () : VideoSlave
//		{
//			_stream_paused = !_stream_paused;
//			
//			if ( _stream_paused )
//				_netstream.pause();
//			else
//				_netstream.resume();
//			
//			return this;
//		}
//		
//		/**
//		 * Play the stream.
//		 */
//		public function play () : VideoSlave
//		{
//			if ( _stream_paused )
//			{
//				_netstream.resume();
//				_stream_paused = true;
//			}
//			return this;
//		}
//		
//		/**
//		 * Pause the stream.
//		 */
//		public function pause () : VideoSlave
//		{
//			if ( !_stream_paused )
//			{
//				_netstream.pause();
//				_stream_paused = false;
//			}
//			return this;
//		}
		
	}
}

internal class StatusHandler 
{
	public var duration : Number;

	public function onMetaData( info : Object ) : void 
	{
		this.duration = Math.round( info[ "duration" ] * 100 ) / 100;
	}

	public function onXMPData(infoObject : Object) : void 
	{ 
	}
}