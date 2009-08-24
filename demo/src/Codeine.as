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
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _cocktail : Cocktail;
		private var _uris : Array;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Initializes App & Cocktail.
		 */
		public function Codeine ()
		{
			_uris = [
				"main/index/a/b/c",
				"main/edit/a/b/c",
				"main/del/a/b/c"
			];
			
			_cocktail = new Cocktail (
				this,
				new Embedder(),
				new Routes(),
				"codeine",
				_uris.shift()
			);
			
			addEventListener( Event.ADDED_TO_STAGE, _added);
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
					_cocktail.router.get( _uris.shift() );
				break;
			}
		}
	}
}