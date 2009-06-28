package codeine.views.elements
{

		/**
	 * Application base preloader class.
	 * 
	 * @author nybras | nybras@codeine.it
	 */
//	public class PreloaderElement extends PreloaderElementTail 
	public class PreloaderElement 
	{
//		private var _asset : MovieClip;
//		private var _status : String;
//		private var _follower : Timer;
//		
//		
//		
//		public function PreloaderElement ( )
//		{
//			var _class : Class;
//			
//			_class = getClassByAlias( "Preloader" );
//			_asset = new _class ();
//			
//			sprite.x = ( config.widthStage - _asset.width ) / 2;
//			sprite.y = ( config.heightStage - _asset.height ) / 2;
//			sprite.alpha = 0;
//			
//			_follower = new Timer ( 30, 0 );
//			_follower.addEventListener( TimerEvent.TIMER, move_preloader );
//			
//			_status = "out";
//		}
//		
//		override public function show ( follow_mouse : Boolean = true ) : void
//		{
//			if ( _status == "in" )
//				return;
//			
//			sprite.addChild( _asset );
//			motion.alpha( 1, .5 );
//			
//			if ( follow_mouse )
//				start_followig();
//			
//			_status = "in";
//		}
//		
//		override public function hide () : void
//		{
//			if ( _status == "out" )
//				return;
//			
//			stop_followig();
//			motion.alpha( 0, .5 ).listen( remove_preloader );
//		}
//		
//		private function remove_preloader ( ...doesntmatter ) : void
//		{
//			if ( _status == "out")
//				return;
//			
//			try {
//				_asset.parent.removeChild( _asset );
//			} catch ( e : Error ) {}
//			_status = "out";
//		}
//		
//		
//		
//		private function start_followig () : void
//		{
//			Mouse.hide();
//			if ( ! _follower.running )
//				_follower.start();
//		}
//		
//		private function stop_followig () : void
//		{
//			Mouse.show();
//			if ( _follower.running )
//				_follower.stop();
//		}
//		
//		private function move_preloader ( event : TimerEvent ) : void
//		{
//			sprite.x += ( sprite.parent.mouseX - sprite.x ) * .15;
//			sprite.y += ( sprite.parent.mouseY - sprite.y ) * .15;
//		}
	}
}