package cocktail.lib 
{
	import cocktail.Cocktail;
	import cocktail.core.gunz.Bullet;
	import cocktail.core.gunz.GunzGroup;
	import cocktail.core.processes.Process;
	import cocktail.core.request.Request;

	public class Controller extends BaseMVCL
	{
		/* ---------------------------------------------------------------------
		VARS
		--------------------------------------------------------------------- */

		private var _group : GunzGroup;

		private var _model : Model;
		private var _layout : Layout;

		private var _scheme_is_loaded : Boolean;

		
		
		/* ---------------------------------------------------------------------
		BOOTING
		--------------------------------------------------------------------- */

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

		private function _after_boot() : void
		{
			trace( "After oot!" );
		}

		
		
		/* ---------------------------------------------------------------------
		RUNNING
		--------------------------------------------------------------------- */

		public function before_run( process : Process ) : Boolean
		{
			process;
			return true;
		}

		final public function run( process : Process ) : void
		{
			if( before_run( process ) )
				_load( process );
			
//				process.route.api.run( this );
		}

		
		
		/* ---------------------------------------------------------------------
		LOADING
		--------------------------------------------------------------------- */
		
		/**
		 * Load Model and Layout.
		 * @param process	Process to load. 
		 */
		private function _load( process : Process ) : void
		{
			if( _scheme_is_loaded )
			{
				_group = new GunzGroup( );
				_group.add( _layout.gunz_scheme_loaded );
				_group.add( _model.gunz_scheme_loaded );
				_group.gunz_complete.add( _after_load_scheme );
				return;
			}
			
			_model.load( process ).gunz_complete.add( _after_load ).once( );
			_layout.load( process ).gunz_complete.rm( _after_load ).once( );
		}

		/**
		 * TODO: write docs
		 */
		private function _after_load( bullet : Bullet ) : void
		{
			bullet;
		}

		/* ---------------------------------------------------------------------
		LOADING SCHEME
		--------------------------------------------------------------------- */
		
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
			_scheme_is_loaded = true;
//			_load();
		}

		
		/* ---------------------------------------------------------------------
		RENDERING
		--------------------------------------------------------------------- */

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