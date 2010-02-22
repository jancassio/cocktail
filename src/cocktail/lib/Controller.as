package cocktail.lib {
	import cocktail.Cocktail;
	import cocktail.core.gunz.Bullet;
	import cocktail.core.gunz.GunzGroup;
	import cocktail.core.process.Process;
	import cocktail.core.request.Request;

	/**
	 * @author hems
	 * @author nybras
	 */
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
		
		/**
		 * Run filtering. If returns false, wont run the action
		 */
		public function before_run( request : Request ) : Boolean
		{
			request;
			return true;
		}

		/**
		 * Run the desired request
		 */
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
			if( !_is_scheme_loaded ) 
			{
				_load_scheme( request );
				return;
			}
			
			_group = new GunzGroup( );
			_group.add( _layout.gunz_complete );
			_group.add( _model.gunz_complete );
			_group.gunz_complete.add( _after_load, request );
			
			_model.load( request );
			_layout.load( request );
		}

		/**
		 * Called after loading needed data to render the request
		 */
		private function _after_load( bullet : Bullet, request: Request ) : void
		{
			bullet;
			request;
		}

		/* LOADING SCHEME */
		
		/**
		 * Load Model and Layout scheme.
		 * @param request	Request that will be loaded after load scheme. 
		 */
		private function _load_scheme( request : Request ) : void
		{
			_group = new GunzGroup( );
			_group.add( _layout.gunz_scheme_loaded );
			_group.add( _model.gunz_scheme_loaded );
			_group.gunz_complete.add( _after_load_scheme, request );
			
			_model.load( request );
			_layout.load( request );
		}

		/**
		 * Triggered after load  model and layout scheme
		 */
		private function _after_load_scheme( 
			bullet : Bullet, 
			request: Request 
		) : void
		{
			bullet;
			_is_scheme_loaded = true;
			_load( request );
		}

		/* RENDERING */
		
		/**
		 * Rendering filter. If returns false, wont render
		 */
		public function before_render( process : Process ) : Boolean
		{
			process;
			return true;
		}

		/**
		 * Called after process completes
		 */
		public function after_render( process : Process ) : void
		{
			process;
		}
	}
}