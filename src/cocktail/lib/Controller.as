package cocktail.lib 
{
	import cocktail.Cocktail;
	import cocktail.core.bind.Bind;
	import cocktail.core.gunz.Bullet;
	import cocktail.core.gunz.GunzGroup;
	import cocktail.core.request.Request;
	import cocktail.lib.gunz.ControllerBullet;
	import cocktail.lib.gunz.ModelBullet;
	import cocktail.lib.gunz.ViewBullet;

	/**
	 * @author hems	hems@henriquematias.com
	 * @author nybras	me@nybras.com
	 */
	public class Controller extends MVC
	{
		/** Each render, this flag turns true.
		 * If your action turns this to false, _layout_render wont occur
		 */
		private var _auto_render : Boolean;

		/**
		 * Last runned _request. 
		 * ATT: Doesnt means the request is rendered
		 */
		private var _request : Request;

		/* 
		 * Cocktail will instantiate a model for each controller.
		 * 
		 * Will try to find a model with the same name, if it doesnt
		 * exists, will instantiate an AppModel 
		 */
		private var _model : Model;

		/* 
		 * Cocktail will instantiate a layout for each controller.
		 * 
		 * Will try to find a layout with the same name, if it doesnt
		 * exists, will instantiate an AppLayout
		 */
		private var _layout : Layout;

		/** 
		 * Has model and view loaded theirs xmls?
		 **/
		private var _is_xml_loaded : Boolean;
		
		/**
		 * Group Event manager for needed loadings
		 */
		private var _load_group : GunzGroup;

		/**
		 * Saves / broadcasts all transitory variables / binds
		 */
		internal var _bind : Bind;

		/**
		 * @param cocktail
		 */
		override public function boot( cocktail : Cocktail ) : *
		{
			var result : *;
		
			result = super.boot( cocktail );
			
			log.info( "Running..." );
			
			_model  = factory.model( name );
			_layout = factory.layout( name );
			
			_bind   = new Bind( );
			
			_model._controller  = this;
			_layout._controller = this;
			
			_model.boot( cocktail );
			_layout.boot( cocktail );
			
			return result;
		}

		/* RUNNING */
		
		/**
		 * Run filtering. If returns false, wont run the action.
		 * 
		 * @param request
		 */
		public function before_run( request : Request ) : Boolean
		{
			log.info( "Running..." );
			request;
			return true;
		}

		/**
		 * Run the desired request.
		 * 
		 * @param request
		 */
		final public function run( request : Request ) : void
		{
			if( !before_run( request ) ) return;
			
			log.info( "Running..." );
			
			_request = request;
			
			_load( request );
		}

		/* LOADING */
		
		/**
		 * Load filtering. If returns false, wont load anything.
		 * 
		 * @param request
		 */
		public function before_load( request : Request ) : Boolean
		{
			log.info( "Running..." );
			request;
			return true;
		}

		/**
		 * Load Model ( data ) and Layout ( assets ).
		 * 
		 * @param request. 
		 */
		private function _load( request : Request ) : void
		{
			if( !before_load( request ) ) return;
			
			log.info( "Running..." );
			
			if( !_is_xml_loaded ) 
			{
				_load_xml( request );
				on_load_start.shoot( new ControllerBullet( ) );
				return;
			}
			
			_load_model( request );
		}


		/**
		 * Load Model and Layout scheme.
		 * 
		 * @param request	Request that will be loaded after load scheme. 
		 */
		private function _load_xml( request : Request ) : void
		{
			_load_group = new GunzGroup( );
			_load_group.add( _layout.on_xml_load_complete );
			_load_group.add( _model.on_xml_load_complete );
			_load_group.gunz_complete.add( _xml_loaded, request );
			
			_model.load_xml( request );
			_layout.load_xml( request );
		}

		/**
		 * Triggered after load  model and layout xml.
		 * 
		 * @param bullet
		 */
		private function _xml_loaded( bullet : Bullet ) : void
		{
			log.info( "Running..." );
			bullet;
			_is_xml_loaded = true;
			_load( bullet.params );
		}

		/**
		 * @param request
		 */
		private function _load_model( request : Request ) : void
		{
			log.info( "Running..." );
			
			_model.on_load_complete.add( _model_loaded, request ).once();
			
			if( !_model.load( request ) )
			{
				_model.on_load_complete.rm( _model_loaded );
				
				_load_layout( request );
			}
		}

		/**
		 * @param bullet
		 */
		private function _model_loaded( bullet : ModelBullet ) : void
		{
			log.info( "Running..." );
			
			_load_layout( bullet.params );
		}

		/**
		 * @param request
		 */
		private function _load_layout( request : Request ) : void
		{
			log.info( "Running..." );
			
			_layout.on_load_complete.add( _layout_loaded, request ).once();
			
			_layout.load( request );
		}

		/**
		 * @param bullet
		 */
		private function _layout_loaded( bullet : ViewBullet ) : void
		{
			log.info( "Running..." );
			
			render( bullet.params );
		}

		/* RENDERING */
		
		/**
		 * Rendering filter. If returns false, wont render.
		 * 
		 * @param request
		 */
		public function before_render( request : Request ) : Boolean
		{
			log.info( "Running..." );
			request;
			return true;
		}

		/**
		 * Called after render request completes.
		 * 
		 * @param request
		 */
		public function render( request : Request ) : void
		{
			if( !before_render( request ) ) return;
			
			log.info( "Running..." );
			
			_auto_render = true;
			
			// _auto_render
			if( is_defined( request.route.api.action ) )
			{
				this[ request.route.api.action ]( ); 
			}
			
			if( _auto_render == false ) return;
			
			_layout.gunz_render_done.add( after_render, request ).once( );
			_layout.render( request );
		}

		/**
		 * Called after render request completes.
		 * 
		 * @param request
		 */
		public function after_render( request : Request ) : void
		{
			log.info( "Running..." );
			request;
		}


		/* GETTERS */

		/**
		 * 
		 */
		public function get layout() : Layout
		{
			return _layout;
		}
	}
}