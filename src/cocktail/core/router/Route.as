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
	import cocktail.utils.ArrayUtil;	

	/**
	 * Stores URI and resolve it's route.
	 * @author nybras | nybras@codeine.it
	 */
	public class Route extends Index 
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _api : API;
		private var _mask : String;
		private var _target : String;
		private var _locale : String;
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new Route instance.
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
			_locale = _get_locale( uri );
			_mask = routes.wrap( _purge_locale( uri ) );
			_target = routes.unwrap( _purge_locale( uri ) );
			_api = new API( _target );
		}
		
		
		
		/**
		 * Extracts the locale from the given URI.
		 * @return	The extracted locale.
		 */
		private function _get_locale( uri : String ) : String
		{
			var locale : String;
			
			locale = uri.split( "/" ).shift();
			
			// If URI hasn't a locale string prefix, then the current
			// or default locale is used.
			if ( !ArrayUtil.has( config.locales, locale )  )
				locale = ( config.current_locale || config.default_locale );
			
			return locale;
		}
		
		/**
		 * Extracts the locale from the given URI.
		 * @param uri	The URI without the locale prefix.
		 */
		private function _purge_locale( uri : String ) : String
		{
			return ArrayUtil.del( uri.split( "/" ), _locale ).join( "/" );
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
		
		/**
		 * Returns the route locale.
		 * @return	Route locale.
		 */
		public function get locale() : String
		{
			return _locale;
		}
		
		/**
		 * Returns the route API.
		 * @return	Route API.
		 */
		public function get api() : API
		{
			return _api;
		}
	}
}

import cocktail.utils.StringUtil;

/**
 * Route API - stores system execution infos (controller, action, params).
 * @author nybras | nybras@codeine.it 
 */
internal class API
{
	public var controller : String;
	public var action : String;
	public var params : *;
	
	public function API( uri : String )
	{
		var parts : Array;
		
		parts = uri.split( "/" );
		
		controller = StringUtil.cap( parts[ 0 ] );
		action = parts[ 1 ];
		params = [].concat( parts.slice( 2 ) );
	}
}