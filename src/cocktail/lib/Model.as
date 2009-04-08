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

package cocktail.lib {
	import cocktail.core.Index;	import cocktail.core.Task;	import cocktail.core.connectors.RequestConnector;	import cocktail.core.data.bind.Bind;	import cocktail.core.data.dao.ProcessDAO;	import cocktail.core.data.so.SO;	import cocktail.lib.Controller;	import cocktail.lib.cocktail.PreProcessor;	import cocktail.lib.cocktail.fxml.model.FxmlModel;	import cocktail.lib.cocktail.fxml.model.FxmlModelAction;	import cocktail.lib.cocktail.tweaks.ModelTweaks;		import flash.events.Event;		/**
	 * Main Model class. This is the base class for every single Model you have
	 * in your application.
	 * @author nybras | nybras@codeine.it
	 * @see Index
	 * @see Cocktail
	 * @see Controller
	 * @see Model
	 */
	public class Model extends ModelTweaks
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		protected var _task : Task;
		protected var _bind : Bind;
		protected var _request : RequestConnector;
		
		protected var _controller : Controller;
		
		protected var _so : SO;
		protected var _fxml : FxmlModel;
		protected var _status : String;
		
		protected var _actions : *;
		protected var _current_action : FxmlModelAction;
		protected var _current_process : ProcessDAO;
		
		public var booted : Boolean;
		
		
				/* ---------------------------------------------------------------------
			BOOTING
		--------------------------------------------------------------------- */
		
		/**
		 * Run the Model according the cocktail strict flow.
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
			
			_so = new SO ( class_path );
			
			_controller = controller;
			_actions = {};
			
			_task = task;
			_bind = bind;
			_request = request;
			
			fxml_path = config.path( ".fxml" ) + "models/";
			fxml_path += clean_class_name.toLowerCase( ) + ".fxml";
			
			_fxml = new FxmlModel();
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
			RUN & DESTROY
		--------------------------------------------------------------------- */
		
		/**
		 * Run the given action.
		 * @param process	The action ( in ProcessDAO format ) to be runned.
		 */
		internal function run ( process : ProcessDAO ) : void
		{
			var contents : XML;
			
			contents = _fxml.action( process.action );
			_current_process = process;
			
			_current_action = new FxmlModelAction ();
			_current_action.boot( this, _bind, _request, contents );
			
//			_processes.push ( _current );
		}
		
		/**
		 * Destroy the given action.
		 * @param process	The action ( in ProcessDAO format ) to be destroyed.
		 */
		internal function destroy ( process : ProcessDAO ) : void
		{
			FxmlModelAction ( _actions[ process.action ] ).destroy();
			_destroy();
		}
		
		
		
		/* ---------------------------------------------------------------------
			LOADING
		--------------------------------------------------------------------- */
		
		/**
		 * Invoked before the requested action load starts.
		 */
		internal final function _before_load () : void
		{
			log.info( "_before_load();" );
			try { this[ "before_load" ](); } catch ( e : Error ) {}			
		}
		
		/**
		 * Load the requested action.
		 */
		internal final function _load () : void
		{
			_before_load();
			_current_action.load().listen ( _after_load );
		}				/**
		 * Invoked after the requested action is loaded.
		 */
		internal final function _after_load () : void
		{
			log.info( "_after_load();");
			try { this[ "after_load" ](); } catch ( e : Error ) {};
			_task.done( class_path +"/_after_load" );
		}
		
		
		
		/* ---------------------------------------------------------------------
			DESTROYING
		--------------------------------------------------------------------- */
		
		/**
		 * Invoked before destroy.
		 */
		internal function _before_destroy () : void
		{
			log.info( "_before_destroy();" );
			try { this[ "before_destroy" ](); } catch ( e1 : Error ) {};
		}
		
		/**
		 * Destroy the requested action.
		 */
		internal function _destroy () : void
		{
			log.info( "_destroy();" );
			
			_before_destroy();
			
			// TODO - implement method
			
			_after_destroy();
		}
		
		/**
		 * Invoked after the requested action is destroyed.
		 */
		internal function _after_destroy () : void
		{
			log.info( "_after_destroy();" );
		}
	}
}