/*	****************************************************************************
		Cocktail ActionScript Full Stack Framework. Copyright (C) 2009 Codeine.
	****************************************************************************
   
		This library is free software; you can redistribute it and/or modify
	it under the terms of the GNU Lesser General Public License as published
	by the Free Software Foundation; either version 2.1 of the License, or
	(at your option) any later version.
		
		This library is distributed in the hope that it will be useful, but
	WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
	or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public
	License for more details.

		You should have received a copy of the GNU Lesser General Public License
	along with this library; if not, write to the Free Software Foundation,
	Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

	-------------------------
		Codeine
		http://codeine.it
		contact@codeine.it
	-------------------------
	
*******************************************************************************/

package cocktail.lib 
{	import cocktail.Cocktail;	import cocktail.core.Index;	import cocktail.core.Processes;	import cocktail.core.Task;	import cocktail.core.connectors.RequestConnector;	import cocktail.core.connectors.request.RequestEvent;	import cocktail.core.data.bind.Bind;	import cocktail.core.data.dao.ProcessDAO;	import cocktail.core.status.Status;	import cocktail.lib.Model;	import cocktail.lib.View;	import cocktail.lib.cocktail.PreProcessor;	import cocktail.utils.ArrayUtil;	import cocktail.utils.Timeout;		import flash.display.Sprite;	
	/**
	 * Main cocktail Controller class.
	 * 
	 * This is the base class for every single Controller you have in your application.
	 * 
	 * @author nybras | nybras@codeine.it
	 * @see Index
	 * @see Cocktail
	 * @see Controller
	 * @see Model
	 */
	public class Controller extends Index
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var preprocessor : PreProcessor;
		
		private var _dependences : Array;
		
		public var root : Cocktail;
		public var stage : Sprite;
		
		public var model : Model;		public var view : View;
		
		public var current_process : ProcessDAO;
		public var dead_process : ProcessDAO;
		public var active_process : Array;

		public var bind : Bind;
		internal var task : Task;
		internal var request : RequestConnector;
				protected var status : String;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new Controller instance.
		 */
		public function Controller(){}
		
		/**
		 * Boot the Controller according the cocktail strict flow.
		 * @param root	Cocktail reference.
		 */
		public function boot ( root : Cocktail ) : void
		{
			var auth : Namespace;
			
			authorized = new Array ( Processes );
			
			this.root = root;
			this.stage = root.sprite;
			
			auth = root.auth( this );
			task = root.auth::task;
			
			bind = new Bind( );
			request = new RequestConnector( );
			active_process = new Array();
			
			model = new ( get_class( config.appId +".models."+ clean_class_name +"Model" ) ) ();
			view = new ( get_class( config.appId +".views."+ clean_class_name +"View" ) ) ();
			
			preprocessor = new PreProcessor ( bind, model, view );
		}
		
		
		
		/* ---------------------------------------------------------------------
			STATUS MODIFIERS
		--------------------------------------------------------------------- */
		
		/**
		 * Mark controller execution status as <code>initializing</code>
		 */
		private function $initializing () : void
		{
			status = Status.INITIALIZING;
		}
		
		/**
		 * Mark controller execution status as <code>loading</code>
		 */
		private function $loading () : void
		{
			status = Status.LOADING;
		}
		
		/**
		 * Mark controller execution status as <code>rendering</code>
		 */
		private function $rendering () : void
		{
			status = Status.RENDERING;
			
			try
			{ this[ "render_start" ]();
			} catch ( e : Error ) {}
		}

		/**
		 * Mark controller execution status as <code>render_done</code>
		 */
		private function $render_done () : void
		{
			status = Status.RENDER_DONE;
			task.done( class_path + "/render_done" );
			
			try
			{ this[ "render_done" ]();
			} catch ( e : Error ) {}
		}
		
		/**
		 * Mark controller execution status as <code>destroying</code>
		 */
		private function $destroying () : void
		{
			status = Status.DESTROYING;
		}
		
		/**
		 * Mark controller execution status as <code>destroy_done</code>
		 */
		private function $destroy_done () : void
		{
			status = Status.DESTROY_DONE;
			task.done( class_path + "/destroy_done" );
		}
		
		
		
		/* ---------------------------------------------------------------------
			USES HANDLERS
		--------------------------------------------------------------------- */
		
		/**
		 * Specify the area dependences.
		 * @param url	The dependence url in string format (AreaName/action/param1/param2/praram...n).
		 * @param wait	if <code>true</code> waits for the previous <code>after_render</code> to continue, otherwise <code>false</code>, just goes on. 
		 */
		final protected function uses ( url : String, wait : Boolean ) : void
		{
			_dependences.push( new ProcessDAO( url , wait, false ) );
		}
		
		
		
		/* ---------------------------------------------------------------------
			NAVIGATION & LOCALE HANDLERs
		--------------------------------------------------------------------- */
		
		/**
		 * Redirects the application to the given url.
		 * @param url	Target location to redirect the application to.
		 * @param silentMode	If <code>true</code>, reflects the url in the address bar, otherwise <code>false</code> keeps the adress bar as it is.
		 */
		final public function redirect( url : String, silentMode : Boolean = false, freeze : Boolean = false ) : void
		{
			root.redirect( url, silentMode, freeze );
		}
		
		/**
		 * Change the current locale string for I18n.
		 * @param locale	The string locale to use.
		 */
		final public function switchLocale ( locale : String ) : void
		{
			if ( config.currentLocale == locale )
				return;
				
			config.currentLocale = locale;
			root.reboot();
		}
		
		
		
		/* ---------------------------------------------------------------------
			NOMENCLATURE HANDLERs
		--------------------------------------------------------------------- */
		
		/**
		 * Returns the controller name without the prefix "Controller".
		 * @return	The controller name.
		 */
		public final function get clean_class_name () : String
		{
			return class_name.replace( "Controller", "" );
		}
		
		
		
		/* ---------------------------------------------------------------------
			DEPENDENCE CONTROL
		--------------------------------------------------------------------- */
		
		/**
		 * 
		 */
		public function dependences ( action : String ) : Array
		{
			_dependences = new Array();
			
			try {
				this[ action +"_uses"]();
			} catch ( e : Error ) {
				log.info( "No dependencies for: "+ class_path +"/"+ action );
				log.info ( "\t \-> message # " ); 
			}
			
			return _dependences;
		}
		
		
		
		/* ---------------------------------------------------------------------
			RESTRICTED - RUN & DESTROY ( invoked by Processes class )
		--------------------------------------------------------------------- */
		
		/**
		 * Run the given process.
		 * @param dao	The process to be runned.
		 */
		restricted function run ( dao : ProcessDAO ) : void
		{
			var methods : Array;
			
			log.info( "run ( "+ dao +" );" );
			
			current_process = dao;
			
			try {
				this[ dao.action ].apply( this, dao.params );
			} catch ( e1 : Error ) {
				if ( e1.errorID == 1069 )
					log.notice( "Action '"+ dao.action +"' not found on "+ class_path +"." );
				else
					log.notice( e1 );
			};
			
			if ( model.booted && view.booted )
			{
				run_process ( dao );
				return;
			}
			
			methods = new Array();
			if ( ! model.booted )
			{
				methods.push( model.class_path +"/boot" );
				model.boot( this );
			}
			
			if ( ! view.booted )
			{
				methods.push( view.class_path +"/boot" );
				view.boot( this, true );
			}
			
			$load_start( null, false );
			task.wait( methods , proxy( run_process , dao ) );
		}
		
		
		
		private function run_process ( dao : ProcessDAO ) : void
		{
			var model_schema : XML;
			var model_structure : XML;
			
			model_structure = model.structure..action.( @name == dao.action )[ 0 ];
			
			if ( ! ( model_structure is XML ) )
				model_schema = <action name={dao.action} />;
			else
			{				model_schema = preprocessor.globals( model_structure, model.xmlPath );
				model_schema = preprocessor.params( model_schema, model.xmlPath );
				model_schema = preprocessor.loops ( model_schema, model.xmlPath );
			}			
			model.cache_action ( model_schema );
			
			if ( dao.freeze )
			{
				current_process = dao;
				execMVC ();
				return;
			}
			
			active_process.push ( current_process = dao );
			
			task.wait([
				model.class_path +"/run",
				view.class_path +"/run"
			], $init );
			
			model.run( dao );
			view.run( dao );
		}
		
		
		
		/**
		 * Destroy the given process.
		 * @param dao	The process to be destroyed.
		 */
		restricted function destroy ( dao : ProcessDAO ) : void
		{
			ArrayUtil.del( active_process , ( dead_process = dao ) );
			
			$destroying();
			
			task.wait( [
				view.class_path +"/destroy_done"
			], $destroy_done );
			
			model.destroy( dao );
			view.destroy( dao );
		}
		
		
		
		/* ---------------------------------------------------------------------
			INIT SEQUENCE EXECUTION
		--------------------------------------------------------------------- */
		
		private function $before_init () : void
		{
			log.info( "$before_init();");
			$initializing();
			try { this[ "before_init" ](); } catch ( e : Error ) {};
		}
		
		private function $init () : void
		{
			$before_init();
			
			task.wait([
				model.class_path +"/$after_init",
				view.class_path +"/$after_init"
			], $after_init );
			
			model.$init();
			view._init();
		}		
		private function $after_init () : void
		{
			log.info( "$after_init();");
			try { this[ "after_init" ](); } catch ( e : Error ) {};
			
			$load();
		}
		
		
		
		/* ---------------------------------------------------------------------
			LOAD SEQUENCE EXECUTION
		--------------------------------------------------------------------- */
		
		/**
		 * 
		 */
		private function $before_load () : void
		{
			log.info( "$before_load();");
			$loading();
			try { this[ "before_load" ](); } catch ( e : Error ) {};
		}
		
		/**
		 * 
		 */
		private function $load () : void
		{
			$before_load();
			$load_model();
		}
		
		/**
		 * 
		 */
		private function $load_model () : void
		{
			task.wait( model.class_path +"/$after_load", $load_view );
			model.$load();
			
		}
		
		/**
		 * 
		 */
		private function $load_view () : void
		{
			var view_structure : XML;
			var view_schema : XML;
			
			// try { view["load_complete"]( false ); } catch ( e : Error ) {}
			
			view_structure = view.structure..action.( @name == current_process.action )[ 0 ];
			
			if ( ! ( view_structure is XML ) )
				view_structure = <action name={current_process.action} />;
			
			view_schema = preprocessor.globals ( view_structure, view.xmlPath );
			view_schema = preprocessor.params( view_schema, view.xmlPath );
			view_schema = preprocessor.loops ( view_schema, view.xmlPath );
			view_schema = preprocessor.sweeps ( view_schema, view.xmlPath );
			
			view.cache_action( view_schema );
			view._load();
			
			request.listen( $load_complete, null, $load_progress, $load_start );
			request.start();
		}
		
		
		/**
		 * 
		 */
		private function $after_load ( event : RequestEvent ) : void
		{
			request = new RequestConnector( );
			
			log.info( "$after_load();");
			try { this[ "after_load" ](); } catch ( e1 : Error ) {};
			
			request.unlisten( $after_load );
			execMVC();
			
			$rendering();
			task.wait( view.class_path + "/render_done", $render_done );
			view._render( );
		}		
		/**
		 * 
		 */		private function execMVC () : void		{
			// controller
//			try {
//				this[ current_process.action ].apply( this, current_process.params );
//			} catch ( e1 : Error ) {
//				if ( e1.errorID == 1069 )
//					log.warn( "Action '"+ current_process.action, "' not found on ", model.class_path, "." );
//				else
//					log.warn( e2 );
//			};
			
			// model
			try {
				model[ current_process.action ].apply( model, current_process.params );
			} catch ( e2 : Error ) {
				if ( e2.errorID == 1069 )
					model.log.notice( "Action '"+ current_process.action+ "' not found on "+ model.class_path +"." );
				else
					model.log.error( e2 );
			};
			
			// view
			try {
				view[ current_process.action ].apply( view, current_process.params );
			} catch ( e3 : Error ) {
				if ( e3.errorID == 1069 )
					view.log.notice( "Action '"+ current_process.action+ "' not found on "+ view.class_path +"." );
				else
					view.log.error( e3 );
			};
		}				
				// sending load output to view
		
		private var running : Boolean;
		
		private function $load_start ( event : RequestEvent = null, known : Boolean = true ) : void
		{
			if ( running ) return;
			
			running = true;
			try {
				view["load_start"]( known );
			} catch ( e : Error )
			{
				try {
					view["load_start"]();
				} catch ( e1 : Error ) {}
			}
		}
		
		private function $load_progress ( event : RequestEvent ) : void
		{
			var t : Number;
			var l : Number;
			var p : Number;
			
			t = event.iMassLoader.bytesTotal;
			l = event.iMassLoader.bytesLoaded;
			p = ( l / t );
			
			try { view["load_progress"]( p, l, t ); } catch ( e : Error ){}
		}
		
		private function $load_complete ( event : RequestEvent = null ) : void
		{
			running = false;
			
			try { view["load_complete"](); } catch ( e : Error ) {}
			
			new Timeout( proxy( $after_load, event ), 300 ).exec();
		}
		
		
		
/* ---------------------------------------------------------------------
//			DESTROY SEQUENCE EXECUTION
//		--------------------------------------------------------------------- */
//		
//		/**
//		 * 
//		 */
//		private function $before_destroy () : void
//		{
//			log.info( "$before_destroy();");
//			destroying();
//			try { this[ "before_destroy" ](); } catch ( e : Error ) {};
//		}
//		
//		/**
//		 * 
//		 */
//		private function $destroy ( dao : ProcessDAO ) : void
//		{
//			$before_destroy();
//			
//			task.wait( view.class_path +"/destroy_done", destroy_done );
//			
//			// TODO - pass dao as argument to model/view destroy method
//			dao;
//			
//			model.$destroy();
//			view.$destroy();
//		}
//		
//		/**
//		 * 
//		 */
//		private function $after_destroy () : void
//		{
//			log.info( "$after_destroy();");
//			try { this[ "after_destroy" ](); } catch ( e : Error ) {};
//		}
	}
}