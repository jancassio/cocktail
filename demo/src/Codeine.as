package  
{
	import de.polygonal.ds.DLinkedList;
	import cocktail.core.slave.slaves.GraphSlave;
	import cocktail.core.slave.Slave;
	import cocktail.Cocktail;
	import cocktail.core.slave.gunz.ASlaveBullet;
	import cocktail.core.slave.gunz.GraphSlaveBullet;
	import cocktail.core.slave.gunz.VideoSlaveBullet;
	import cocktail.core.slave.slaves.VideoSlave;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.media.Video;
	import flash.ui.Keyboard;

	/**
	 * Document class.
	 * @author nybras | nybras@codeine.it
	 */
	public class Codeine extends Sprite 
	{
		/* 	VARS */
		
		private var _cocktail : Cocktail;
		private var _uris : Array;
		
		
		
		/* 	INITIALIZING */
		
		/**
		 * Initializes App & Cocktail.
		 */
		public function Codeine ()
		{
//			_uris = [
//				"main/index/a/b/c",
//				"main/edit/a/b/c",
//				"main/del/a/b/c"
//			];
//			
//			_cocktail = new Cocktail (
//				this,
//				new Embedder(),
//				new Routes(),
//				"codeine",
//				_uris.shift()
//			);
//			
			addEventListener( Event.ADDED_TO_STAGE, _added);
		}
		
		private var stat : Stats = new Stats();
		
		private function _added( event : Event ) : void
		{
			stage.addEventListener( KeyboardEvent.KEY_DOWN, _keydown );
			
			addChild( stat );
			
			slave_to_job();
		}

		
		private function _keydown( event : KeyboardEvent ) : void
		{
			switch( event.keyCode )
			{
				case Keyboard.RIGHT:
					if( _uris.length )
						_cocktail.router.get( _uris.shift() );
				break;
			}
		}
		
		/* ---------------------------------------------------------------------
			SLAVE TESTS
		--------------------------------------------------------------------- */
		
		private function slave_to_job () : void
		{
			
//			var list : DLinkedList = new DLinkedList();
//			list.append( "1" );
//			list.append( "1" );
//			trace( "@@@@@@@@@@@@@@@ ", list.size );
//			list.removeHead();
//			trace( "@@@@@@@@@@@@@@@ ", list.size );
			
						
			//video tests
//			var video : Video = new Video();
//			addChild( video );
//			slave = new VideoSlave( "http://localhost/codeine/cocktail/flv/video.flv" ).put( video );
//			slave.gunz_progress.add( _prog );
//			slave.gunz_complete.add( _comp );
//			slave.load();			
//			
//			var btn : Sprite = new Sprite();
//			btn.graphics.beginFill( 0xf3f5af );
//			btn.graphics.drawCircle( 0, 0, 50 );
//			btn.x = 380;
//			btn.y = 70;
//			btn.buttonMode = true;
//			btn.addEventListener( MouseEvent.CLICK, btn_click );
//			addChild( btn );
			
			//var slaveImg : GraphSlave = new GraphSlave( "http://localhost/codeine/cocktail/img/01.jpg" ).put( this );
			//slaveImg.load();
			
//			var spr : Sprite = new Sprite();
//			spr.x = 100;
//			spr.y = 100;
//			addChild( spr );
			
//			var video : Video = new Video();
//			addChild( video );
//			var mainSlave : Slave = new Slave();
//			mainSlave.video( "http://localhost/codeine/cocktail/flv/video.flv" ).put( video ).gunz_error.add( _error );
//			mainSlave.load();
			
			//video tests
//			var video1 : Video = new Video();
//			addChild( video1 );
//			var slave2 : Slave = new Slave( true );
//			slave2.video( "http://localhost/codeine/cocktail/flv/video.flv" );
//			slave2.gunz_progress.add( _prog );
//			slave2.gunz_complete.add( _comp );
//			//slave2.load();
//			video1.x = 500;

			
			//Graph tests
			var slave : Slave = new Slave( false, false );
			
			slave.gunz_complete.add( _comp2 );
			
			slave.graph( "http://localhost/codeine/cocktail/img/01.jpg" ).put( this ).gunz_complete.add( _comp, "CARLOS" );
			slave.graph( "http://localhost/codeine/cocktail/img/01.jpg" ).put( this ).gunz_complete.add( _comp, "CARLOS" );
			slave.graph( "http://localhost/codeine/cocktail/img/01.jpg" ).put( this ).gunz_complete.add( _comp, "CARLOS" );
			slave.graph( "http://localhost/codeine/cocktail/img/01.jpg" ).put( this ).gunz_complete.add( _comp, "CARLOS" );
			slave.graph( "http://localhost/codeine/cocktail/img/01.jpg" ).put( this ).gunz_complete.add( _comp, "CARLOS" );
			slave.graph( "http://localhost/codeine/cocktail/img/01.jpg" ).put( this ).gunz_complete.add( _comp, "CARLOS" );
			slave.graph( "http://localhost/codeine/cocktail/img/01.jpg" ).put( this ).gunz_complete.add( _comp, "CARLOS" );
			slave.graph( "http://localhost/codeine/cocktail/img/01.jpg" ).put( this ).gunz_complete.add( _comp, "CARLOS" );
			slave.graph( "http://localhost/codeine/cocktail/img/01.jpg" ).put( this ).gunz_complete.add( _comp, "CARLOS" );
			slave.graph( "http://localhost/codeine/cocktail/img/01.jpg" ).put( this ).gunz_complete.add( _comp, "CARLOS" );
			slave.graph( "http://localhost/codeine/cocktail/img/01.jpg" ).put( this ).gunz_complete.add( _comp, "CARLOS" );
			slave.graph( "http://localhost/codeine/cocktail/img/01.jpg" ).put( this ).gunz_complete.add( _comp, "CARLOS" );
			slave.graph( "http://localhost/codeine/cocktail/img/01.jpg" ).put( this ).gunz_complete.add( _comp, "CARLOS" );
			slave.graph( "http://localhost/codeine/cocktail/img/01.jpg" ).put( this ).gunz_complete.add( _comp, "CARLOS" );
			slave.graph( "http://localhost/codeine/cocktail/img/01.jpg" ).put( this ).gunz_complete.add( _comp, "CARLOS" );
			
			slave.load();
		}
		
		private function btn_click ( event : MouseEvent ) : void
		{
			
		}
		
		private function _star( bullet : GraphSlaveBullet ) : void
		{
			trace( "START" );
//			trace( ":START -> "+ bullet.bytes_loaded, bullet.bytes_total, bullet.bytes_progress );
		}
 
		private function _prog( bullet : VideoSlaveBullet ) : void
		{
			trace( "PROG ", bullet.bytes_loaded );
//			trace( ":PROG -> "+ bullet.bytes_loaded, bullet.bytes_total, bullet.bytes_progress );
		}
		
		private function _error( bullet : VideoSlaveBullet ) : void
		{
			trace( "ERROR ", bullet.msg );
		}
 
		public function _comp( bullet : GraphSlaveBullet ) : void
		{
			bullet.content.x = Math.random() * stage.stageWidth;
			bullet.content.y = Math.random() * stage.stageHeight;
			
			addChild( stat );			
		}
		
		public function _comp2( bullet : ASlaveBullet ) : void
		{
			//trace( "COMPLETE - OUT! 222222222" );
			slave_to_job();
		}
		
	}
}