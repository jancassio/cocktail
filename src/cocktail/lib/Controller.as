package cocktail.lib 
{
	import cocktail.Cocktail;
	import cocktail.core.gunz.Bullet;
	import cocktail.core.gunz.Gun;
	import cocktail.core.gunz.GunzGroup;
	import cocktail.core.process.Process;
	import cocktail.core.request.Request;
	import cocktail.lib.base.MVCL;
	import cocktail.lib.gunz.ControllerBullet;

	/**
	 * @author hems
	 * @author nybras
	 */
	public class Controller extends MVCL
	{
		/* GUNZ */
		private var gunz_load_change_phase : Gun;

		private function _init_gunz() : void
		{
			gunz_load_change_phase = new Gun( gunz, this, "load_change_phase" );
		}

		/* VARS */
		private var _model : Model;
		private var _layout : Layout;
		private var _group : GunzGroup;
		private var _is_scheme_loaded : Boolean;

		/* BOOTING */
		override public function boot( cocktail : Cocktail ) : *
		{
			var name : String;
			var s : *;
		
			_init_gunz( );
			
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
		 * Run filtering. If returns false, wont run the action.
		 */
		public function before_run( request : Request ) : Boolean
		{
			request;
			return true;
		}

		/**
		 * Run the desired request.
		 */
		final public function run( request : Request ) : void
		{
			if( before_run( request ) )
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
				gunz_load_start.shoot( new ControllerBullet( ) );
				return;
			}
			
			_group = new GunzGroup( );
			_group.add( _layout.gunz_load_complete );
			_group.add( _model.gunz_load_complete );
			_group.gunz_complete.add( _after_load, request );
			
			_model.load_data( request );
			_layout.load_assets( request );
		}

		/**
		 * Called after loading needed data to render the request.
		 */
		private function _after_load( bullet : Bullet ) : void
		{
			gunz_load_complete.shoot( new ControllerBullet( ) );
			render( bullet.params ) ;
		}

		/* LOADING SCHEME */
		
		/**
		 * Load Model and Layout scheme.
		 * @param request	Request that will be loaded after load scheme. 
		 */
		private function _load_scheme( request : Request ) : void
		{
			_group = new GunzGroup( );
			_group.add( _layout.gunz_load_complete );
			_group.add( _model.gunz_load_complete );
			_group.gunz_complete.add( _after_load_scheme, request );
			
			_model.load_scheme( request );
			_layout.load_scheme( request );
		}

		/**
		 * Triggered after load  model and layout scheme.
		 */
		private function _after_load_scheme( bullet : Bullet ) : void
		{
			bullet;
			_is_scheme_loaded = true;
			gunz_load_change_phase.shoot( new ControllerBullet( ) );
			_load( bullet.params );
		}

		/* RENDERING */
		
		/**
		 * Rendering filter. If returns false, wont render.
		 */
		public function before_render( process : Process ) : Boolean
		{
			process;
			return true;
		}

		/**
		 * Called after render process completes.
		 */
		public function render( process : Process ) : void
		{
			if( before_render )
			{
				_layout.gunz_render_complete.add( after_render, process );
				_layout.render( process );
			}
		}

		/**
		 * Called after render process completes.
		 */
		public function after_render( process : Process ) : void
		{
			log.debug( "Process rendered!!!" );
			process;
		}
	}
}