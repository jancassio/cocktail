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
	import cocktail.core.factory.Factory;
	import cocktail.core.request.Request;
	import cocktail.core.router.Route;
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
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIAZING
		-------------------------------------------------------------------  */
		
		/**
		 * Creates a new Processes instance.
		 * @param cocktail	Cocktail reference.
		 */
		public function Processes( cocktail : Cocktail )
		{
			super( cocktail);
			_controllers = {};
			router.listen.update( _route );
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
			log.debug( "@@ Request" );
			log.debug( "---------------" );
			log.debug( "uri => "+ bullet.request.uri );
			log.debug( "type => "+ bullet.request.type );
			log.debug( "data => "+ bullet.request.data );
			log.debug( "title => "+ bullet.request.title );
			
			log.debug( "@@ Route" );
			log.debug( "---------------" );
			log.debug( "route.locale => "+ bullet.request.route.locale );
			log.debug( "route.mask => "+ bullet.request.route.mask );
			log.debug( "route.target => "+ bullet.request.route.target );
			
			log.debug( "@@ API" );
			log.debug( "---------------" );
			log.debug( "route.api.controller => "+ bullet.request.route.api.controller );
			log.debug( "route.api.action => "+ bullet.request.route.api.action );
			log.debug( "route.api.params => "+ bullet.request.route.api.params );
			
			_run( bullet.request );
		}
		
		
		
		/* ---------------------------------------------------------------------
			RUNNING & DESTROYING
		--------------------------------------------------------------------- */
		
		/**
		 * Run process based on the given request.
		 * @param request	Request to run.
		 */
		private function _run( request : Request  ) : void
		{
			controller( request.route.api.controller ).run( request );
			
			request;
			// TODO: implement method
		}
		
		/**
		 * Destroy process based on the given request.
		 * @param request	Request to destroy.
		 */
		private function _destroy( request : Request ) : void
		{
			request;
			// TODO: implement method
		}
		
		
		
		/* ---------------------------------------------------------------------
			CONTROLLERS
		--------------------------------------------------------------------- */
		
		/**
		 * Instantiate the requested Controller, or just return it if it was
		 * already instatiated. In other words, its unique.
		 * @param name	Controller name (CamelCased)
		 */
		public function controller( name : String ) : Controller
		{
			var controller : Controller;
			
			if( _controllers[ name ] )
				controller = _controllers[ name ];
			else
				_controllers[ name ] = controller = new (
					_cocktail.factory.controller( name )
				)( _cocktail );
			
			return controller;
		}
	}
}