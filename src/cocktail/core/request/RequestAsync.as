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

package cocktail.core.request 
{
	import cocktail.Cocktail;
	import cocktail.core.request.Request;
	import cocktail.core.request.gunz.RequestAsyncTrigger;	

	/**
	 * Handles all async requests.
	 * @author nybras | nybras@codeine.it
	 */
	public class RequestAsync extends Request 
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _trigger : RequestAsyncTrigger;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * TODO: write docs
		 */
		public function RequestAsync(
			uri : String,
			data : *
		)
		{
			super( Request.POST, uri, data );
		}
		
		
		/* ---------------------------------------------------------------------
			BOOTING
		--------------------------------------------------------------------- */
		
		/**
		 * Boots the Index base class.
		 * @param cocktail	Cocktail reference.
		 */
		override public function boot( cocktail : Cocktail ) : *
		{
			var s : *;
			
			s = super.boot( cocktail );
			_trigger = new RequestAsyncTrigger( this );
			return s;
		}
		
		
		
		/* ---------------------------------------------------------------------
			BULLET/TRIGGER IMPLEMENTATION( listen/unlisten )
		--------------------------------------------------------------------- */
		
		/**
		 * Trigger refernce.
		 * @return	RouterTrigger reference.
		 */
		public function get trigger() : RequestAsyncTrigger
		{
			return _trigger;
		}
		
		
		
		/**
		 * Start listening.
		 * @return	The <code>RequestAsyncTrigger</code> reference.
		 */
		public function get listen() : RequestAsyncTrigger
		{
			return RequestAsyncTrigger( _trigger.listen );
		}
		
		/**
		 * Stop listening.
		 * @return	The <code>RequestAsyncTrigger</code> reference.
		 */
		public function get unlisten() : RequestAsyncTrigger
		{
			return RequestAsyncTrigger( _trigger.unlisten );
		}
	}
}
