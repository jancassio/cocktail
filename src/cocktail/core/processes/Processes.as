/*	****************************************************************************
		Cocktail ActionScript Full Stack Framework. Copyright(C) 2009 Codeine.
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
	import cocktail.core.request.Request;
	import cocktail.core.router.gunz.RouterBullet;	

	/**
	 * Manage all processes.
	 * @author nybras | nybras@codeine.it
	 */
	public class Processes extends Index 
	{
		/* ---------------------------------------------------------------------
			VARS
		-------------------------------------------------------------------  */
		
		private var _controllers : Array;
		
		
		
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
			_controllers = [];
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
			bullet;
			// TODO: implement method
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
	}
}