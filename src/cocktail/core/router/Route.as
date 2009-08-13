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

	/**
	 * Stores URIs and resolve it's route.
	 * @author nybras | nybras@codeine.it
	 */
	public class Route extends Index 
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _mask : String;
		private var _target : String;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new MapVO instance.
		 * @param cocktail	Cocktail reference..
		 * @param uri	Request URI.
		 */
		public function Route( cocktail : Cocktail, uri : String )
		{
			super( cocktail );
			_resolve( uri );
		}
		
		
		
		/* ---------------------------------------------------------------------
			RESOLVE
		--------------------------------------------------------------------- */
		
		/**
		 * Resolves the route for the given URI.
		 * @param uri	URI to resolve.
		 */
		private function _resolve( uri : String ) : void
		{
			// TODO: Resolve routes here and set mask / target props.
		}
		
		
		
		/* ---------------------------------------------------------------------
			GETTERS
		--------------------------------------------------------------------- */
		
		/**
		 * Returns the route mask.
		 * @return	Route mask.
		 */
		public function get mask() : String
		{
			return _mask;
		}
		
		/**
		 * Returns the route target.
		 * @return	Route target.
		 */
		public function get target() : String
		{
			return _target;
		}
	}
}