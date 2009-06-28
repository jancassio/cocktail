package cocktail.lib 
{
	import cocktail.core.Task;
	import cocktail.core.connectors.RequestConnector;
	import cocktail.core.data.bind.Bind;
	import cocktail.core.data.dao.ProcessDAO;
	import cocktail.lib.Controller;
	import cocktail.lib.View;
	import cocktail.lib.cocktail.preprocessor.PreProcessor;
	import cocktail.lib.cocktail.fxml.Fxml;
	import cocktail.lib.cocktail.fxml.layout.FxmlLayout;
	import cocktail.lib.view.styles.Styles;
	
	import flash.display.Sprite;
	import flash.events.Event;	

	/**
	 * Cocktail Layout base class.
	 * @author nybras | nybras@codeine.it
	 */
	public class Layout extends View 
	{
		private var _actions : *;
//		private var _controller : Controller;
		
		private var _active_processes : Array;
		private var _current_processes : Array;
		private var _dead_processes : Array;
		
		private var _process_running : ProcessDAO;
		private var _process_destroying : ProcessDAO;
		
		private var _fxml : Fxml;
		private var _styles : Styles;
//		private var _sprite : Sprite;
		
		public var booted : Boolean;
		
		
		
		/* ---------------------------------------------------------------------
			BOOTING
		--------------------------------------------------------------------- */
		
		/**
		 * Run the Layout according the cocktail strict flow.
		 * @param controller	Area controller.
		 * @param preprocessor	Controller reference.
		 * @param task	Task referente.
		 * @param bind	Bind reference.
		 * @param request	Request reference.
		 */
		internal function boot (
			controller : Controller,
			preprocessor : PreProcessor,
			task : Task,
			bind : Bind,
			request : RequestConnector
		) : void
		{
			var fxml_path : String;
			
			if ( booted )
			{
				boot_done ();
				return;
			}
			
			_task = task;
			_bind = bind;
			_request = request;
			
			_styles = new Styles();
			_actions = new Object();
			
			_active_processes = [];
			_current_processes = [];
			_dead_processes = [];
			
			_controller = controller;
			_controller.stage.addChild( _sprite = new Sprite() );
			
			fxml_path = config.path( ".fxml" ) + "layouts/";
			fxml_path += clean_class_name.toLowerCase() + ".fxml";
			
			_fxml = new FxmlLayout ();
			_fxml.boot( preprocessor );
			_fxml.load( fxml_path ).listen( boot_done );
		}
		
		/**
		 * Listen for boot load complete.
		 * @param event	Event.COMPLETE.
		 */
		public function boot_done ( event : Event = null ) : void
		{
			trace ( _fxml.structure );
			_task.done( class_path + "/boot" );
		}
		
		
		
		/* ---------------------------------------------------------------------
			ACTION's RUN & DESTROY
		--------------------------------------------------------------------- */
		
		/**
		 * Run the given action.
		 * @param dao	The action ( in ProcessDAO format ) to be runned.
		 */
		internal function run ( process : ProcessDAO ) : void
		{
			_active_processes.push( _process_running = process );
			
			// TODO - code method
			// instantiate
			// input styles w/ parent style etc
			
			_task.done( class_path + "/run" );
		}
		
		/**
		 * Destroy the given action.
		 * @param dao	The action ( in ProcessDATxtO format ) to be destroyed.
		 */
		internal function destroy ( process : ProcessDAO ): void
		{
//			var item : View;
			
			_process_destroying = process;
			
//			for each ( item in _actions[ process.url ] )
//				item._destroy( process );
		}
	}
}