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

package cocktail.core.processes 
{
	import cocktail.Cocktail;
	import cocktail.core.Index;
	import cocktail.core.router.gunz.RouterBullet;
	import cocktail.lib.Controller;

	/**
	 * Manage all processes.
	 * @author nybras | nybras@codeine.it
	 */
	public class Processes extends Index 
	{
		/* ---------------------------------------------------------------------
		VARS
		-------------------------------------------------------------------  */

		private var _controllers : Object;

		private var _current_process : Process;
		private var _last_routed_process : Process;

		private var _pending_processes : Array;
		private var _running_processes : Array;
		private var _iddle_processes : Array;
		private var _dead_processes : Array;

		private var _current_processes : Processes;

		
		
		/* ---------------------------------------------------------------------
		BOOTING
		-------------------------------------------------------------------  */
		
		/**
		 * Creates a new Processes instance.
		 * @param cocktail	Cocktail reference.
		 */
		override public function boot( cocktail : Cocktail ) : *
		{
			var s : *;
		
			s = super.boot( cocktail );
			_controllers = {};
			router.update.add( _route );
			return s;
		}

		
		
		/* ---------------------------------------------------------------------
		RESTARTING APPLICATION
		-------------------------------------------------------------------  */
		
		/**
		 * Reboots the application.
		 */
		public function reboot() : void
		{
			// TODO: implement method
		}

		
		
		/* ---------------------------------------------------------------------
		ROUTING ADDRESS BAR CALLS
		--------------------------------------------------------------------- */
		
		/**
		 * Route the application according the Router.UPDATE trigger.
		 * @param bullet	RouterBullet.
		 */
		private function _route( bullet : RouterBullet ) : void
		{
			// log.debug( "@@ Request" );
			// log.debug( "---------------" );
			// log.debug( "uri => "+ bullet.request.uri );
			// log.debug( "type => "+ bullet.request.type );
			// log.debug( "data => "+ bullet.request.data );
			// log.debug( "title => "+ bullet.request.title );
			// 
			// log.debug( "@@ Route" );
			// log.debug( "---------------" );
			// log.debug( "route.locale => "+ bullet.request.route.locale );
			// log.debug( "route.mask => "+ bullet.request.route.mask );
			// log.debug( "route.target => "+ bullet.request.route.target );
			// 
			// log.debug( "@@ API" );
			// log.debug( "---------------" );
			// log.debug( "route.api.controller => "+ bullet.request.route.api.controller );
			// log.debug( "route.api.action => "+ bullet.request.route.api.action );
			// log.debug( "route.api.params => "+ bullet.request.route.api.params );

			_last_routed_process = new Process( this, bullet.request );
			
			_filter( );
			_destroy( );
		}

		
		
		
		/* ---------------------------------------------------------------------
		RUNNING & DESTROYING
		--------------------------------------------------------------------- */
		
		/**
		 * Destroy all dead processes.
		 */
		private function _destroy() : void
		{
			var process : Process;
			
			if( !_dead_processes.length )
			{
				log.info( "All process was destroyed!" );
				_run( );
				return;
			}
			
			log.info( "Destroying process..." );
			process = _dead_processes.shift( );
			process.destroy( ).listen.destroyed( _destroy ).once( );
		}

		private function _run() : void
		{
			var process : Process;
			
			if( !_pending_processes.length )
			{
				trace( "All process was ran!" );
				return;
			}
			
			log.info( "Running process..." );
			_iddle_processes.push( _current_process );
			_current_process = _pending_processes.shift( );
			
			_running_processes.push( _current_process );
			_current_process.run( ).listen.ran( _run ).once( );
		}

		
		
		/* ---------------------------------------------------------------------
		FILTERING
		--------------------------------------------------------------------- */

		private function _filter() : void
		{
			_filter_deads( );
			_filter_survivors( );
			_filter_pendings( );
			
			// _current_process
		}

		private function _filter_deads() : void
		{
			// TODO: implement method
			
			// _current_process
			_dead_processes = [];
		}

		private function _filter_pendings() : void
		{
			// TODO: implement method
			
			// _current_process
			_pending_processes = [];
		}

		private function _filter_survivors() : void
		{
			// TODO: implement method
			
			// _current_process
			_running_processes = [];
		}

		
		
		
		/* ---------------------------------------------------------------------
		CONTROLLERS
		--------------------------------------------------------------------- */
		
		/**
		 * Instantiate the requested Controller, or just return it if it was
		 * already instatiated. In other words, its unique.
		 * @param name	Controller name (CamelCased)
		 */
		internal function _controller( name : String ) : Controller
		{
			var controller : Controller;
			
			if( _controllers[ name ] )
				controller = _controllers[ name ];
			else
				_controllers[ name ] = ( controller = new (
					_cocktail.factory.controller( name )
				)( ) ).boot( _cocktail );
			
			return controller;
		}
	}
}