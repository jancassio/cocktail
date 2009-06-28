package codeine.boot 
{
	import gs.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.net.getClassByAlias;
	import flash.net.registerClassAlias;
	import flash.ui.Mouse;
	import flash.utils.Timer;	

	/**
	 * Cocktail boot class - this class is 100% isolated from the rest and basically only loads the application main swf.
	 * @author nybras | nybras@codeine.it
	 */
	public class Boot extends Sprite
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _loader : Loader;
		private var _follower : Timer;
		private var _preloader : MovieClip; 
		private var _preloader_class : Class; 
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new Boot instance.
		 */
		public function Boot ()
		{
			stage.scaleMode = "noScale";
			stage.align = "LT";
			load_preloader();
		}
		
		
		
		/* ---------------------------------------------------------------------
			PRELOADER
		--------------------------------------------------------------------- */
		
		/**
		 * Load the preloader.
		 */
		private function load_preloader () : void
		{
			_loader = new Loader();
			_loader.load( new URLRequest ( root.loaderInfo.parameters[ "preloader" ] + random_str ) );
			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, render_preloader );
		}
		
		/**
		 * Render the preloader.
		 * @param event	Event.COMPLETE
		 */
		private function render_preloader ( event : Event ) : void
		{
			registerClassAlias( "Preloader" , Class ( _loader.contentLoaderInfo.applicationDomain.getDefinition( "Preloader" ) ) );
			
			_preloader_class = getClassByAlias( "Preloader" );
			_preloader = new _preloader_class ();
			
			_loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, render_preloader );
			_loader = null;
			
			_preloader.alpha = 0;
			TweenMax.to( addChild( _preloader ), .5, { alpha : 1 });
			
			_follower = new Timer ( 30, 0 );
			_follower.addEventListener( TimerEvent.TIMER, move_preloader );
			start_followig();
			
			load_app();
		}
		
		/**
		 * Hides mouse cursor and adds a follower preloading asset.
		 */
		private function start_followig () : void
		{
			Mouse.hide();
			if ( ! _follower.running )
				_follower.start();
		}
		
		/**
		 * Shows the mouse cursor again, removing the preloader asset.
		 */
		private function stop_followig () : void
		{
			Mouse.show();
			if ( _follower.running )
				_follower.stop();
		}
		
		/**
		 * Move the preloader according the x,y mouse, adding simple desaceleration easing.
		 * @param event	TimerEvent.EVENT.
		 */
		private function move_preloader ( event : TimerEvent ) : void
		{
			_preloader.x += ( _preloader.parent.mouseX - _preloader.x ) * .15;
			_preloader.y += ( _preloader.parent.mouseY - _preloader.y ) * .15;
		}
		
		
		
		/* ---------------------------------------------------------------------
			COCKTAIL / APPLICATION
		--------------------------------------------------------------------- */
		
		/**
		 * Loader application.
		 */
		private function load_app ( ) : void
		{
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, render_app );
			_loader.load( new URLRequest ( root.loaderInfo.parameters[ "app" ] + random_str ) );
		}
		
		/**
		 * Render/Start application. 
		 * @param event	Event.COMPLETE
		 */
		private function render_app ( event : Event ) : void
		{
			TweenMax.to( _preloader, .5, { alpha : 0, onComplete : function () : void {
				stop_followig();
				removeChild ( _preloader );
				addChild ( _loader.content );
				_loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, render_app );
				_loader = null;
			}});
			
		}
		
		
		
		/* ---------------------------------------------------------------------
			RANDOM
		--------------------------------------------------------------------- */
		
		/**
		 * Create a random string to avoid cache.
		 * @return	the random string formated to be used at the end of url.
		 */
		private function get random_str () : String
		{
			return "?cocktail="+ Math.random();
		}
		
	}
}