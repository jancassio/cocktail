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
		public function VideoSlave(
			uri : String,
			auto_load : Boolean = false,
			target : Video = null
		) : void
		{
			super( uri );
			
			if( target )
				put( target );
			
			_progress_timer = new Timer( DEFAULT_TIMER_DELAY );
			_progress_timer.stop();
			_progress_timer.addEventListener( TimerEvent.TIMER, _pull_time );
			_progress_timer.start();
			
			_netconn = new NetConnection( );
			_netconn.addEventListener( 	NetStatusEvent.NET_STATUS, 
										_on_net_status );
			_netconn.addEventListener( 	SecurityErrorEvent.SECURITY_ERROR, 
										_on_security_error );
			_netconn.connect( null );
						
			if( auto_load )
				load( );
		}

		/**
		 * Start the loading process.
		 * @return	Self reference for inline reuse.
		 */
		public function load() : ISlave
		{
			if( _status != ASlave._QUEUED )
				return this;
				
			if( !_target )
				return this;	
			
			// updating status
			_status = ASlave._LOADING;
			
			// start connection
			_netstream = new NetStream( _netconn );
			_netstream.client = new StatusHandler( );
			_netstream.addEventListener( 	NetStatusEvent.NET_STATUS, 
											_on_net_status );
			_netstream.addEventListener( 	AsyncErrorEvent.ASYNC_ERROR, 
											_on_net_status );
			_target.attachNetStream( _netstream );
			_netstream.play( _uri );
			gunz_start.shoot( new VideoSlaveBullet( loaded, total ) );
			
			return this;
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
					_progress_timer.stop();
					_progress_timer.removeEventListener( TimerEvent.TIMER, 
														 _pull_time );
					_netstream.removeEventListener( NetStatusEvent.NET_STATUS, 
													_on_net_status );
					_netstream.removeEventListener( AsyncErrorEvent.ASYNC_ERROR, 
													_on_net_status );															
					gunz_complete.shoot( new VideoSlaveBullet( loaded, 
																total ) );
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