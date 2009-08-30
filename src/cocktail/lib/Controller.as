package cocktail.lib 
{
	import cocktail.Cocktail;
	import cocktail.core.Index;
	import cocktail.core.gunz.Bullet;
	import cocktail.core.request.Request;	

	public class Controller extends Index
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _loaded : int;
		private var _model : Model;
		private var _layout : Layout;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		public function Controller( cocktail : Cocktail )
		{
			var name : String;
			
			super( cocktail);
			
			name = classname.replace( "Controller", "" );
			
			_model = new ( cocktail.factory.model( name ) )( this );
			_layout = new ( cocktail.factory.layout( name ) )( this );
			
			_model.listen.boot( _boot ).die();
			_layout.listen.boot( _boot ).die();
		}
		
		
		
		/* ---------------------------------------------------------------------
			BOOTING
		--------------------------------------------------------------------- */
		
		/**
		 * TODO: write docs
		 */
		private function _boot() : void
		{
			if( ++_load == 2 )
			{
				
			}
		}
		
		
		
		/* ---------------------------------------------------------------------
			RUNNING
		--------------------------------------------------------------------- */
		
		public function before_run( request : Request ) : Boolean
		{
			request, return true;
		}
		
		final public function run( request : Request ) : void
		{
			if( before_run( request ) )
				_load( request );
			
//				request.route.api.run( this );
		}
		
		
		 
		/* ---------------------------------------------------------------------
			LOADING
		--------------------------------------------------------------------- */
		
		/**
		 * Load Model and Layout.
		 * @param request	Request to load. 
		 */
		private function _load( request : Request ) : void
		{
			_loaded = 0;
			_model.load( request ).listen.complete( _after_load ).die();
			_layout.load( request ).listen.complete( _after_load );
		}
		
		/**
		 * TODO: write docs
		 */
		private function _after_load( bullet : Bullet ) : void
		{
			bullet;
			if( ++_load == 2 )
			{
				
			}
		}
		
		
		/* ---------------------------------------------------------------------
			RENDERING
		--------------------------------------------------------------------- */
		
		final public function before_render( request : Request ) : Boolean
		{
			request;
			return true;
		}
		
		final public function after_render( request : Request ) : void
		{
			request;
		}
	}
}