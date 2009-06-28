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

package cocktail.lib.cocktail.tweaks 
{
	import cocktail.core.connectors.RequestConnector;
	import cocktail.core.connectors.request.RequestKeeper;
	import cocktail.lib.cocktail.fxml.FxmlTag;	

	/**
	 * Some tweaks for MVC classes.
	 * @author nybras | nybras@codeine.it
	 */
	public class Tweaks extends FxmlTag 
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _queue : RequestConnector;
		private var _queueing : Boolean;
		
		
		
		/* ---------------------------------------------------------------------
			URL REQUESTS
		--------------------------------------------------------------------- */
		
		/**
		 * Open or close a queue and return it.
		 * @param opening	if <code>true</code> open a new queue, otherwise
		 * <code>false</code> close the opened queue.
		 * @return	The opened or closed queue.
		 */
		protected function queue ( opening : Boolean ) : RequestConnector
		{
			if ( _queueing = opening ) {
				_queue = new RequestConnector( );
			}
			
			return _queue;
		}
		
		/**
		 * Request the given url through the queue (if openen) or directly (if
		 * closed).
		 * 
		 * @param url	The url adress to be requested.
		 * @param autoLoad	If <code>true</code>, loading process starts
		 * automatically.
		 */
		protected function url ( url : String, autoLoad : Boolean = true ) : RequestKeeper
		{
			if ( this._queueing )
				return this._queue.load( url, autoLoad );
			else
				return new RequestConnector().load( url, autoLoad );
		}
	}
}
