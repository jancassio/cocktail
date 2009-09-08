package cocktail.lib 
{
	import cocktail.Cocktail;
	import cocktail.core.Index;
	import cocktail.core.gunz.Bullet;
	import cocktail.core.request.Request;
	import cocktail.lib.Layout;	

	public class Controller extends Index
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _booted : int;
		private var _loaded : int;
		
		private var _model : Model;
		private var _layout : Layout;
		
		
		
		/* ---------------------------------------------------------------------
			BOOTING
		--------------------------------------------------------------------- */
		
		override public function boot( cocktail : Cocktail ) : *
		{
			var name : String;
			var s : *;
		
			s = super.boot( cocktail );
			
			name = classname.replace( "Controller", "" );
			
			_model = new ( _cocktail.factory.model( name ) )();
			_model.boot( _cocktail ).listen.boot( _boot );
			
			_layout = new ( _cocktail.factory.layout( name ) )();
			_layout.boot( _cocktail ).listen.boot( _boot );;
			
			return s;
		}
		
		
		
		/* ---------------------------------------------------------------------
			BOOTING
		--------------------------------------------------------------------- */
		
		/**
		 * TODO: write docs
		 */
		private function _boot() : void
		{
			if( ++_booted == 2 )
			{
				
			}
		}
		
		
		
		/* ---------------------------------------------------------------------
			RUNNING
		--------------------------------------------------------------------- */
		
		public function before_run( request : Request ) : Boolean
		{
			request;
			return true;
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
			_model.load( request ).listen.complete( _after_load ).once();
			_layout.load( request ).listen.complete( _after_load ).once();
		}
		
		/**
		 * TODO: write docs
		 */
		private function _after_load( bullet : Bullet ) : void
		{
			bullet;
			if( ++_loaded == 2 )
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