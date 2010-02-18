package cocktail.lib 
{
	import cocktail.Cocktail;
	import cocktail.core.gunz.Bullet;
	import cocktail.core.gunz.GunzGroup;
	import cocktail.core.process.Process;
	import cocktail.core.request.Request;

	public class Controller extends MVC
	{
		/* VARS */
		private var _group : GunzGroup;
		private var _model : Model;
		private var _layout : Layout;
		private var _is_scheme_loaded : Boolean;

		/* BOOTING */
		override public function boot( cocktail : Cocktail ) : *
		{
			var name : String;
			
			var s : *;
		
			s = super.boot( cocktail );
			name = classname.replace( "Controller", "" );
			
			_model = new ( _cocktail.factory.model( name ) )( );
			_layout = new ( _cocktail.factory.layout( name ) )( );
			
			_model.boot( cocktail );
			_layout.boot( cocktail );
			
			return s;
		}

		/* RUNNING */
		public function before_run( request : Request ) : Boolean
		{
			request;
			return true;
		}

		final public function run( request : Request ) : void
		{
			_load( request );
		}

		/* LOADING */
		
		/**
		 * Load Model and Layout.
		 * @param process	Process to load. 
		 */
		private function _load( request : Request ) : void
		{
			if( _is_scheme_loaded )
			{
				_group = new GunzGroup( );
				_group.add( _layout.gunz_scheme_loaded );
				_group.add( _model.gunz_scheme_loaded );
				_group.gunz_complete.add( _after_load_scheme );
				return;
			}
			
			_model.load( request ).gunz_complete.add( _after_load ).once( );
			_layout.load( request ).gunz_complete.rm( _after_load );
		}

		/**
		 * TODO: write docs
		 */
		private function _after_load( bullet : Bullet ) : void
		{
			bullet;
		}

		/* LOADING SCHEME */
		
		/**
		 * Load Model and Layout.
		 * @param request	Request to load. 
		 */
		private function _load_scheme( request : Request ) : void
		{
		}

		private function _after_load_scheme( bullet : Bullet ) : void
		{
			bullet;
			_is_scheme_loaded = true;
//			_load();
		}

		/* RENDERING */
		final public function before_render( process : Process ) : Boolean
		{
			process;
			return true;
		}

		final public function after_render( process : Process ) : void
		{
			process;
		}
	}
}