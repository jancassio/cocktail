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

package cocktail.core.router 
{
	import cocktail.Cocktail;
	import cocktail.core.Index;
	import cocktail.core.gunz.Trigger;
	import cocktail.core.request.Request;
	import cocktail.core.request.RequestAsync;
	import cocktail.core.router.gunz.RouterBullet;
	import cocktail.core.router.gunz.RouterTrigger;
	
	import swfaddress.SWFAddress;
	import swfaddress.SWFAddressEvent;	

	/**
	 * Handles all routing operations.
	 * @author nybras | nybras@codeine.it
	 */
	public class Router extends Index
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _trigger : RouterTrigger;
		
		private var _initialized : Boolean;
		private var _history : Array;
		private var _index : Number;
		
		
		
		/* ---------------------------------------------------------------------
			BOOTING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new Router instance.
		 * @param cocktail	Cocktail reference.
		 */
		override public function boot( cocktail : Cocktail ) : *
		{
			var s : *;
			
			s = super.boot( cocktail ).s;
			
			_trigger = new RouterTrigger( this );
			
			_history = new Array();
			_index = -1;
			
			return s;
		}
		
		
		/**
		 * Initializes the router, listening for SWFAddress.
		 */
		public function init() : void
		{
			if( _initialized )
				return;
			
			_initialized = true;
			
			if( config.plugin )
				SWFAddress.addEventListener(
					SWFAddressEvent.CHANGE, _addressbar_change
				);
		}
		
		
		/* ---------------------------------------------------------------------
			BULLET/TRIGGER IMPLEMENTATION( listen/unlisten )
		--------------------------------------------------------------------- */
		
		/**
		 * Trigger reference.
		 * @return	The <code>RouterTrigger</code> reference.
		 */
		public function get trigger() : RouterTrigger
		{
			return _trigger;
		}
		
		
		
		/**
		 * Start listening.
		 * @return	The <code>UserTrigger</code> reference.
		 */
		public function get listen() : RouterTrigger
		{
			return RouterTrigger( _trigger.listen );
		}
		
		/**
		 * Stop listening.
		 * @return	The <code>UserTrigger</code> reference.
		 */
		public function get unlisten() : RouterTrigger
		{
			return RouterTrigger( _trigger.unlisten );
		}
		
		
		
		
		/* ---------------------------------------------------------------------
			HISTORY HANDLERS
		--------------------------------------------------------------------- */
		
		/**
		 * Check if theres external pages enough to perform a "back" operation.
		 * @return <code>true</code> if yes, <code>false</code> otherwise.
		 */
		public function get has_back() : Boolean
		{
			return( index > 0 );
		}

		/**
		 * Check it theres external pages enough to perform a "forward"
		 * operation.
		 * * @return <code>true</code> if yes, <code>false</code> otherwise.
		 */
		public function get has_forward() : Boolean
		{
			return( index < history.length );
		}
		
		
		
		/**
		 * Go forward one page.
		 */
		public function forward() : void
		{
			_index++;
			SWFAddress.forward();
		}
		
		/**
		 * Go back one page.
		 */
		public function prev() : void
		{
			_index--;
			SWFAddress.back();
		}
		
		
		
		/**
		 * Gets the history.
		 * @return	The history array.
		 */
		public function get history() : Array
		{
			return _history;
		}
		
		/**
		 * Gets the current history index.
		 * @return	The current history index.
		 */
		public function get index() : Number
		{
			return _index;
		}
		
		
		
		/* ---------------------------------------------------------------------
			REQUEST HANDLERS
		--------------------------------------------------------------------- */
		
		/**
		 * Redirects the application to the given request.
		 * @param request	Request to redirect the application to. 
		 */
		public function get( uri : String ) : void
		{
			var request : Request;
			
			request = new Request( Request.GET, uri ).boot( _cocktail ).s;
			history.push( request );
			_index++;
			
			if( config.plugin )
			{
				if( request.route.mask != SWFAddress.getValue() )
					SWFAddress.setValue( request.route.mask );
			}
			else
				trigger.pull( new RouterBullet( 
					RouterTrigger.UPDATE, request
				));
		}
		
		/*
		 * TODO: write docs
		 */
		public function post( uri : String, data : * ) : RequestAsync
		{
			// TODO: implement method
			return new RequestAsync( uri, data ).boot( _cocktail ).s;
		}
		
		
		
		/* ---------------------------------------------------------------------
			LOCATION HANDLERS
		--------------------------------------------------------------------- */
		
		/**
		 * Gets the current external url location.
		 * @return	The current external url location.
		 */
		public function get location() : String
		{
			return SWFAddress.getValue();
		}
		
		/**
		 * Listen the browser url changes( SWFAddress ).
		 * @param event	SWFAddressEvent.
		 */
		private function _addressbar_change( event : SWFAddressEvent ) : void 
		{
			_trigger.pull( new RouterBullet(
				RouterTrigger.UPDATE,
				new Request(
					Request.GET,
					(event.value == "/" ? config.default_uri : event.value )
				).boot( _cocktail ).s
			));
		}
	}
}