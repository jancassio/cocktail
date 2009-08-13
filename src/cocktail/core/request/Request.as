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
	import cocktail.core.Index;
	import cocktail.core.router.Route;	

	/**
	 * Handle all possible kind of requests.
	 * @author nybras | nybras@codeine.it
	 */
	public class Request extends Index
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _type : String;
		
		private var _uri : String;
		private var _route : Route;
		private var _data : String;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * TODO: write docs
		 */
		public function Request( cocktail : Cocktail, type : String, uri : String, data : * ) : void
		{
			super( cocktail );
			this.type = type;
			this.uri = uri;
			this.data = data;
		}
		
		
		
		/* ---------------------------------------------------------------------
			GETTERS / SETTERS
		--------------------------------------------------------------------- */
		
		public function get uri() : String
		{
			return _uri;
		}
		
		public function set uri( uri : String ) : void
		{
			_uri = uri;
			_route = new Route( _cocktail, uri );
		}
		
		
		
		public function get type() : String
		{
			return _type;
		}
		
		public function set type(type : String) : void
		{
			_type = type;
		}
		
		
		
		public function get data() : String
		{
			return _data;
		}
		
		public function set data(data : String) : void
		{
			_data = data;
		}
		
		
		
		public function get route() : Route
		{
			return _route;
		}
	}
}
