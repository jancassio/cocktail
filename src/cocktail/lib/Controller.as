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
{	import cocktail.Cocktail;
	import cocktail.core.Index;
	import cocktail.core.Processes;
	import cocktail.core.Task;
	import cocktail.core.connectors.RequestConnector;
	import cocktail.core.connectors.request.RequestEvent;
	import cocktail.core.data.bind.Bind;
	import cocktail.core.data.dao.ProcessDAO;
	import cocktail.lib.Model;
	import cocktail.lib.cocktail.preprocessor.PreProcessor;
	import cocktail.lib.cocktail.tweaks.ControllerTweaks;
	import cocktail.utils.ArrayUtil;
	
	import flash.display.Sprite;	

	/**
	 * Main cocktail Controller class. This is the base class for every single
	 * Controller you have in your application.
	 * @author nybras | nybras@codeine.it
	 * @see Index
	 * @see Cocktail
	 * @see Controller
	 * @see Model
	 */
	public class Controller extends ControllerTweaks
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		protected var _preprocessor : PreProcessor;
		
		protected var _request : RequestConnector;
		protected var _bind : Bind;
		
		public var model : Model;
		public var layout : Layout;
		
		public var stage : Sprite;
		
		public var current_process : ProcessDAO;
		public var dead_process : ProcessDAO;
		public var active_process : Array;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Boot the Controller according the cocktail strict flow.
		 * @param root	Cocktail reference.
		 */
		public function boot ( root : Cocktail ) : void
		{
			var auth : Namespace;
			var model_path : String;
			var layout_path : String;
			
			authorized = [ Processes ];
			
			root = root;
			stage = root.sprite;
			
			auth = root.auth( this );
			_task = root.auth::task;
			
			_bind = new Bind( );
			_request = new RequestConnector( );
			active_process = new Array();
			
			model_path = config.appId +".models."+ clean_class_name +"Model";
			layout_path = config.appId +".layouts."+ clean_class_name +"Layout";
			
			model = new ( get_class( model_path ) ) ();
			layout = new ( get_class( layout_path ) ) ();
			
			_preprocessor = new PreProcessor ( _bind, model, layout );
		}
		
		
		
		/* ---------------------------------------------------------------------
			RESTRICTED - RUN & DESTROY ( invoked by Processes class )
		--------------------------------------------------------------------- */
		
		/**
		 * Run the given process.
		 * @param process	Process to run.
		 */
		restricted function run ( process : ProcessDAO ) : void
		{
			log.info( "run ( "+ process +" );" );
			
			// sets the current proccess and notify "load_start"
			current_process = process;
//			_load_start( null, false );
			
			// executes the controller action
			try
			{
				this[ process.action ].apply( this, process.params );
			}
			catch ( e1 : Error )
			{
				if ( e1.errorID == 1069 )
					log.notice( "Action '"+ process.action +"' not found on "+ class_path +"." );
				else
					log.notice( e1 );
			};
			
			// wait for model and layout boot
			_task.wait([
				layout.class_path +"/boot",
				model.class_path +"/boot"
			], run_process );
			
			// boot model and layout
			model.boot( this, _preprocessor, _task, _bind, _request );
			layout.boot( this, _preprocessor, _task, _bind, _request );
		}
		
		/**
		 * Destroy the given process.
		 * @param dao	The process to be destroyed.
		 */
		restricted function destroy ( process : ProcessDAO ) : void
		{
			ArrayUtil.del( active_process , ( dead_process = process ) );
			
			_destroying();
			
			_task.wait( [
				layout.class_path +"/destroy_done"
			], _destroy_done );
			
			model.destroy( process );
			layout.destroy( process );
		}
		
		/**
		 * 
		 */
		private function run_process () : void
		{
			trace ( "RUN PROCESS!!!" );
			
			if ( current_process.freeze )
			{
				execMVC ();
				return;
			}
			
			active_process.push ( current_process );
			
			_task.wait([
				model.class_path +"/run",
				layout.class_path +"/run"
			], _load );
			
			model.run ( current_process );
			layout.run ( current_process );
		}
		
		
		
		/* ---------------------------------------------------------------------
			MODEL / LAYOUT LOADING CONTROL
		--------------------------------------------------------------------- */
		
		/**
		 * Loads the model.
		 */
		private function _load_model () : void
		{
			_task.wait( model.class_path +"/_after_load", _load_layout );
			model._load();
			
		}
		
		/**
		 * Loads the layout.
		 */
		private function _load_layout () : void
		{
			layout._load();
			_task.wait( layout.class_path +"/_after_load", _load_layout );
			
//			_request.listen( _load_complete, null, _load_progress, _load_start );
//			_request.start();
		}
		
		
		
//		/* ---------------------------------------------------------------------
//			LOAD NOTIFICATIONS
//		--------------------------------------------------------------------- */
//		
//		// sending load output to view
//		
//		private var running : Boolean;
//		
//		private function _load_start ( event : RequestEvent = null, known : Boolean = true ) : void
//		{
//			if ( running ) return;
//			
//			running = true;
//			try {
//				layout["load_start"]( known );
//			} catch ( e : Error )
//			{
//				try {
//					layout["load_start"]();
//				} catch ( e1 : Error ) {}
//			}
//		}
//		
//		private function _load_progress ( event : RequestEvent ) : void
//		{
//			var t : Number;
//			var l : Number;
//			var p : Number;
//			
//			t = event.iMassLoader.bytesTotal;
//			l = event.iMassLoader.bytesLoaded;
//			p = ( l / t );
//			
//			try { layout["load_progress"]( p, l, t ); } catch ( e : Error ){}
//		}
//		
//		private function _load_complete ( event : RequestEvent = null ) : void
//		{
//			running = false;
//			
//			try { layout["load_complete"](); } catch ( e : Error ) {}
//			
//			new Timeout( proxy( _after_load, event ), 300 ).exec();
//		}
		
		
		
		/* ---------------------------------------------------------------------
			LOAD SEQUENCE EXECUTION
		--------------------------------------------------------------------- */
		
		/**
		 * Invoked Before load starts.
		 */
		private function _before_load () : void
		{
			log.info( "_before_load();");
			_loading();
			try_exec ( this, "before_load" );
		}
		
		/**	
		 * Loads the required action.
		 */
		private function _load () : void
		{
			trace ( "_LOAD!" );
			
			_before_load();
			_load_model();
		}
		
		/**
		 * Invoked after load complete.
		 */
		private function _after_load ( event : RequestEvent ) : void
		{
			_request = new RequestConnector( );
			
			log.info( "_after_load();");
			try_exec ( this, "after_load" );
			
			_request.unlisten( _after_load );
			execMVC();
			
			_rendering();
			_task.wait( layout.class_path + "/render_done", _render_done );
			
			layout._render( );
		}		
		
		
		/**
		 * 
		 */		private function execMVC () : void		{
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
				layout[ current_process.action ].apply( layout, current_process.params );
			} catch ( e3 : Error ) {
				if ( e3.errorID == 1069 )
					layout.log.notice( "Action '"+ current_process.action+ "' not found on "+ layout.class_path +"." );
				else
					layout.log.error( e3 );
			};
		}		
		
		
		/* ---------------------------------------------------------------------
			DESTROY SEQUENCE EXECUTION
		--------------------------------------------------------------------- */
//		
//		/**
//		 * 
//		 */
//		private function _before_destroy () : void
//		{
//			log.info( "_before_destroy();");
//			destroying();
//			try { this[ "before_destroy" ](); } catch ( e : Error ) {};
//		}
//		
//		/**
//		 * 
//		 */
//		private function _destroy ( dao : ProcessDAO ) : void
//		{
//			_before_destroy();
//			
//			task.wait( view.class_path +"/destroy_done", destroy_done );
//			
//			// TODO - pass dao as argument to model/view destroy method
//			dao;
//			
//			model._destroy();
//			view._destroy();
//		}
//		
//		/**
//		 * 
//		 */
//		private function _after_destroy () : void
//		{
//			log.info( "_after_destroy();");
//			try { this[ "after_destroy" ](); } catch ( e : Error ) {};
//		}
	}
}