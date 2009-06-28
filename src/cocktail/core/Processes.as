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

package cocktail.core 
{
	import cocktail.Cocktail;
	import cocktail.core.Index;
	import cocktail.core.data.dao.ProcessDAO;
	import cocktail.core.events.RouterEvent;
	import cocktail.lib.Controller;
	import cocktail.utils.ArrayUtil;	

	/**
	 * @author nybras | nybras@codeine.it
	 */
	public class Processes extends Index 
	{
		/* ---------------------------------------------------------------------
		-- VARS
		--------------------------------------------------------------------- */
		
		private var rebooting : Boolean;
		private var reboot_point : ProcessDAO;
		
		private var root : Cocktail;
		private var _router : Router;
		
		// type<Controller>
		private var processes : Array;
		// type<ProcessDAO>
		private var active_process : Array;
		// type<ProcessDAO>
		private var pending_process : Array; 
		// type<ProcessDAO>
		private var dead_process : Array;
		
		private var task : Task;
		private var current : ProcessDAO;
		
		private var acceptUserInput : Boolean;
		
		
		
		/* ---------------------------------------------------------------------
		-- INITIALIAZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new Processes instance.
		 * @param root	Reference to Cocktail ( caller ).
		 */
		public function Processes ( root : Cocktail )
		{
			log.info( "{Processes} created!" );
			this.root = root;
			this.acceptUserInput = true;
		}
		
		/**
		 * Initialize the module.
		 */
		public function init () : void
		{
			log.info( "init();" );
			
			var auth : Namespace;
			
			auth = root.auth( this );
			task = root.auth::task;
			
			
			_router = new Router();
			_router.listen( route );
			
			cacheRouter( _router );
			cacheFinder ( find );
			
			processes = new Array( );
			active_process = new Array( );
			pending_process = new Array( );
			dead_process = new Array( );
		}

		
		
		/* ---------------------------------------------------------------------
			RESTARTING APPLICATION
		--------------------------------------------------------------------- */
		
		/**
		 * Reboots the application.
		 */
		public function reboot ( ) : void
		{
			log.info( "reboot();" );
			
			rebooting = true;
			reboot_point = new ProcessDAO( _router.location, false, false );
			
			dead_process = active_process.concat( pending_process );
			
			destroy( );
		}
		
		
		
		/* ---------------------------------------------------------------------
			ROUTING ADDRESS BAR CALLS
		--------------------------------------------------------------------- */
		
		/**
		 * Route the application according the Router.CHANGE event.
		 * @param event	RouterEvent.
		 */
		private function route ( event : RouterEvent ) : void
		{
			log.info( "route();" );
			
			// //trace ( "[Processes] route() - "+ event.location );
			
			if ( ! acceptUserInput )
			{
				 log.warn ( "User interation is locked, please wait a moment. :)" );
			}
			
			var auth : Namespace;
			var ctrl : Controller;
			
			current = new ProcessDAO( event.location , false, event.freezed );
			config.current_locale = current.locale;
			
			if ( current.freeze )
			{
				// //trace ( "\tIF ( " + current.freeze + " )" );
				
				ctrl = controller( current );
				auth = ctrl.auth( this );
				ctrl.auth::run( current );
				return;
			}
			
			filter( );
			destroy( );
		}

		
		
		/* ---------------------------------------------------------------------
			RUNNING, DESTROYING, EXECUTING
		--------------------------------------------------------------------- */
		
		/**
		 * RUN + DESTROY + EXEC
		 */
		public function run ( url : String, silentMode : Boolean = false, freeze : Boolean = false ) : void
		{
			var requestedUrl : ProcessDAO;
			var currentUrl : ProcessDAO;
			
			// //trace ( "[Processes] run() - "+ url );
			
			log.info( "run(" + url , silentMode, freeze + ");" );
			
			if ( rebooting )
			{
				_router.redirect( reboot_point .url , false , false );
				
				rebooting = false;
				reboot_point = undefined;
				
				return;
			}
			
			requestedUrl = new ProcessDAO( url, false, false );
			currentUrl = new ProcessDAO( config.location, false, false );
			
			if ( requestedUrl.url == currentUrl.url && ! rebooting )
				return;
			
			if ( ! acceptUserInput ){
				// //trace ( "\t IF ( " + acceptUserInput + " )" );
				log.warn ( "User interation is locked, please wait a moment. :)" );
				return;
			}
			
			if ( ! freeze )
				acceptUserInput = false;
			
			_router.redirect( url, silentMode, freeze );
		}
		
		
		
		/**
		 * Desrtoy all dead_process (non-dependent / unused process).
		 */
		private function destroy () : void
		{
			var dao : ProcessDAO;
			var ctrl : Controller;
			var auth : Namespace;
			
			if ( ! dead_process.length ) 
			{
				run_pending_process( );
				return;
			}
			
//			for each ( dao in dead_process ) 
//			{
				dao = dead_process[ dead_process.length - 1 ];
				
				// trace ( " %%%%%%%%%%% DESTROYING %%%%%%%%%%% ( " + dao.controller_path + " ) " );
				
				ctrl = controller( dao );
				auth = ctrl.auth( this );
				
				task.wait( ctrl.class_path + "/destroy_done" , destroy_done );
				ctrl.auth::destroy( dao );
				
				// //trace ( " %%%%%%%%%%% /// DESTROYING %%%%%%%%%%% " );
//			}
		}
		
		/**
		 * Invoked by controller, each time some action is destroyed.
		 */
		private function destroy_done () : void
		{
			var dead : ProcessDAO;
			var ctrl : Controller;
			
			dead = dead_process.pop();
			
			// //trace ( "\r\r deletando dao... " + dead.url + " \r\r" );
			
			
			// //trace ( "\r\rANTES / dao -------- " );
//			for each ( var a : ProcessDAO in active_process )
				// //trace( a.url );
			
			
			ArrayUtil.del( active_process , dead.url , "url" );
			
			// //trace ( "\rDEPOIS / dao -------- \r\r" );
//			for each ( var b : ProcessDAO in active_process )
				// //trace( b.url );
			
//			ArrayUtil.del( processes , dead.controller_path, "class_path" );
			
			if ( dead_process.length )
			{
				destroy();
				return;
			}
			
			
			// //trace ( "\r\r deletando process... \r\r" );
			
			
			// //trace ( "\r\rANTES / process -------- " );
//			for each ( var c : Controller in processes )
				// //trace( c.class_path );
			
			
			for each ( ctrl in processes )
			{
				
				var IS_ACTIVE : Boolean = ArrayUtil.has( active_process , ctrl.class_path , "controller_path");
				var IS_PENDING : Boolean = ArrayUtil.has( pending_process , ctrl.class_path , "controller_path");
				
				// //trace ( "\t ( "+ ctrl.class_path +" ) active : "+ IS_ACTIVE );
				
				if ( ! IS_ACTIVE && ! IS_PENDING )
				{
					// //trace ("\tINACTIVE!" );
					ArrayUtil.del( processes, ctrl.class_path, "class_path" );
				}
			}
			
			
			
			// //trace ( "\r\rDEPOIS / process --------\r\r" );
			//for each ( var d : Controller in processes )
				// //trace( d.class_path );
			
			
			
			if ( ! rebooting )
				run_pending_process( );
			else
			{
				processes = new Array( );
				active_process = new Array( );
				pending_process = new Array( );
				dead_process = new Array( );
				
				run ( reboot_point.url );
			}
		}
		
		/**
		 * Waits for all dead_process to be destroyed and then execute all pending process.
		 */
		private function run_pending_process (...params) : void
		{
			var auth : Namespace;
			var dao : ProcessDAO;
			var ctrl : Controller;
			
			if ( ! pending_process.length )
			{
//				 trace ( "USER INTERACTION UNLOCKED!" );
				acceptUserInput = true;
				return;
			}
			
			ctrl = controller( dao = pending_process.pop( ) );
			
			if ( ! ArrayUtil.has( ctrl.active_process , dao.url, "url"  ) )
			{
//				trace ( "\r\r================================================= PROCESSES_RUNNING_PENDING" );
//				trace ( dao.url );
//				trace ( "================================================= PROCESSES_RUNNING_PENDING" );
				
				auth = ctrl.auth( this );
				
				if ( dao.wait )
				{
					//trace ( "\tmust wait: "+ ctrl.class_path + "/render_done" );
					task.wait( ctrl.class_path + "/render_done" , run_pending_process );
				}
				
				ctrl.auth::run( dao );
				active_process.push( dao );
				
				if ( ! dao.wait ) {
					//trace ( "\tshouldn't wait, so run next!");
					run_pending_process( );
				}
			}
			else
			{
				run_pending_process( );
			}
		}
		
		
		
		/* ---------------------------------------------------------------------
			FILTERING - computes the active, pending and dead process
		--------------------------------------------------------------------- */
		
		/**
		 * Filters all <code>pending_process</code> and <code>dead_process</code> process.
		 */
		private function filter () : void
		{
			filter_pendings ( );
			filter_excluding ( );
			filter_actives ( );
			
			//trace ( "\r\r\r" );
			//trace ( "================================================= PROCESSES_FILTERING" );
			//trace ( "------------ PENDINGS" );
			//for each ( var a : ProcessDAO in pending_process )
				//trace ( ">> " + a.controller_path , a.action );
			
			//trace ( "------------ EXCLUDING" );
			//for each ( var b : ProcessDAO in dead_process )
				//trace ( ">> " + b.controller_path , b.action );
			
			//trace ( "------------ ACTIVES" );
			//for each ( var c : ProcessDAO in active_process )
				//trace ( ">> " + c.controller_path , c.action );
			//trace ( "================================================= PROCESSES_FILTERING" );
			
			//trace ( "\r\r\r" );
		}
		
		/**
		 * Filters all <code>pending_process</code>.
		 */
		private function filter_pendings ( dao : ProcessDAO = null ) : void
		{
			var processDao : *;
			var ctrl : Controller; 
			var dependences : Array;
			
			dao = ( dao == null ? current : dao );
			
			ctrl = controller( dao );
			dependences = ctrl.dependences( dao.action );
			
			// //trace ( "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ADICIONA A PILHA! " + dao.controller_path , dao.action );
			
			pending_process.push( dao );
			
			for each ( processDao in dependences ) 
			{
				filter_pendings( processDao );
			}
		}
		
		/**
		 * Filters all <code>dead_process</code>.
		 */
		private function filter_excluding () : void
		{
			var active : ProcessDAO;
			var pending : ProcessDAO;
			var found : Boolean;
			
			dead_process = new Array( );
			
			for each ( active in active_process )
			{
				found = false;
				for each ( pending in pending_process ) 
				{
					if ( active.url == pending.url ) 
						found = true;
				}
				if ( ! found ) 
					dead_process.push( active );
			}
		}
		
		/**
		 * Exclude all <code>pending_process</code> already present in <code>acive_process</code>.
		 */
		private function filter_actives () : void
		{
			var process : ProcessDAO;
			var existents : Array;
			var url : String;
			
			existents = new Array();
			for each ( process in pending_process )
			{
				if ( ArrayUtil.has( active_process, process.url, "url" ) )
					existents.push( process.url );
			}
			
			for each ( url in existents  )
			{
				ArrayUtil.del( pending_process , url, "url" );
			}
		}
		
		
		
		/* ---------------------------------------------------------------------
			CONTROLLER - finds some controller based on ProcessDAO or controller name
		--------------------------------------------------------------------- */
		
		/**
		 * Search the controller based on the given name.
		 * @param name	Controller name.
		 * @return	The found controller instance.
		 */
		private function find ( name : String ) : Controller
		{
			var current : Controller;
			var found : Controller;
			
			for each ( current in processes )
				if ( current.clean_class_name == name )
				{
					found = current;
					break;
				}
			
			if ( ! ( found is Controller ) )
			{
				log.warn( "Process/Controller '"+ name +"' is not current running or doenst exist!" );
				return null;
			}
			
			return found;
		}
		
		
		
		/**
		 * Search the controller instance based on the given process dao, if the controller inst running, creates a new instance and return it.
		 * @param process	ProcessDAO to perform the controller search.
		 */
		private function controller ( process : ProcessDAO ) : Controller
		{
			// //trace ( "[Processes] controller( " + process.controller_path + " ); { " + processes.length + " }" );
			
			var cls : Class;
			var ctrl : Controller;
			
			for each ( ctrl in processes ) 
			{
				// //trace ( "\t checking.... a) '" + process.controller_path +"' == '"+ ctrl.class_path +"'");
				// //trace ( "\t------" );
				if ( ctrl.class_path == process.controller_path )
				{
					// //trace ( "\tFOUND!" );
					return ctrl;
				}
			}
			
			// //trace ( "\t !!! NOT FOUND !!!! " );
			
			cls = get_class( process.controller_path );
			ctrl = new cls();
			ctrl.boot( root );
			
			// //trace ( "@@ BEFORE : " + processes.length );
			
			// //trace ( "@@ --> processes.push( "+ ctrl +" )" );
			processes.push( ctrl );
			
			// //trace ( "@@ AFTER : " + processes.length );
			
			return ctrl;
		}
	}
}