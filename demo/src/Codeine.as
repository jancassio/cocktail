package  
{
	import cocktail.Cocktail;

	import codeine.boot.Embedder;
	import codeine.boot.Routes;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
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
		public function Codeine()
		{
			var embedder : Embedder;
			var routes : Routes;
			var app_id : String;
			var url : String;
			
			_uris = [ "main/index/a/b/c", "main/edit/a/b/c", "main/del/a/b/c" ];
			
			embedder = new Embedder();
			routes = new Routes();
			app_id = "codeine";
			url = _uris.shift();
			
			_cocktail = new Cocktail( this, embedder, routes, app_id, url );
			
			_cocktail.log_level = 6;
			_cocktail.log_detail = 2;
			
			addEventListener( Event.ADDED_TO_STAGE, _added );
		}

		private function _added( event : Event ) : void
		{
			stage.addEventListener( KeyboardEvent.KEY_DOWN, _keydown );
		}

		private function _keydown( event : KeyboardEvent ) : void
		{
			switch( event.keyCode )
			{
				case Keyboard.RIGHT:
					if( _uris.length )
						_cocktail.router.get( _uris.shift( ) );
					break;
			}
		}
	}
}