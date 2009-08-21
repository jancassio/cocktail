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
				new TestURI( "lets/take/a/look/a/b/c",	"main/index/a/b/c" ),
				new TestURI( "lets/edit/a/b/c",			"main/edit/a/b/c" ),
				new TestURI( "ok/its/ok/delete/a/b/c",	"main/del/a/b/c" )
			];
			
			_cocktail = new Cocktail (
				this,
				new Embedder(),
				new Routes(),
				"codeine",
				TestURI( _uris.shift() ).target
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
					_cocktail.router.get( TestURI( _uris.shift() ).target );
				break;
			}
		}
	}
}


internal class TestURI
{
	
	public var mask : String;
	public var target : String;
	
	
	public function TestURI( mask : String, target : String )
	{
		this.mask = mask;
		this.target = target;
	}
}