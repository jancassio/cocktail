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

package cocktail.core 
{
	import cocktail.Cocktail;
	import cocktail.core.config.Config;
	import cocktail.core.logger.Logger;
	import cocktail.core.router.Router;
	
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;	

	/**
	 * Index class is the base class for almost every class inside cocktail.
	 * @author nybras | nybras@codeine.it
	 */
	public class Index 
	{
		
		/* ---------------------------------------------------------------------
			ACCESS RESCRICTIONS
		--------------------------------------------------------------------- */
		
		protected namespace _restricted;
		protected var _authorized : Array;
		
		
		
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		protected var _cocktail : Cocktail;
		private var _log : Logger;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new Index instance.
		 * @param cocktail	Cocktail reference.
		 */
		public function Index( cocktail : Cocktail )
		{
			_cocktail = cocktail;
			_authorized = new Array();
			_log = new Logger( class_path );
		}
		
		
		
		/* ---------------------------------------------------------------------
			GETTERS
		--------------------------------------------------------------------- */
		
		/**
		 * Get the application config.
		 * @return	The application config.
		 */
		final public function get config() : Config
		{
			return _cocktail.config;
		}
		
		/**
		 * Get the application router.
		 * @return	The application router.
		 */
		final public function get router() : Router
		{
			return _cocktail.router;
		}
		
		/**
		 * Get the application routes.
		 * @return	The application routes.
		 */
		final public function get routes() : Router
		{
			return _cocktail.routes;
		}
		
		
		
		/* ---------------------------------------------------------------------
			FUNCTION & DEBUG UTILS
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a proxy function holding default params.
		 * @param method	Method to be handled.
		 * @param params	Default params to be passed to method, these params
		 * will be added in *first* place.
		 * @return	The proxy function with the given params.
		 */
		final public function proxy( method : Function, ...params ) : Function
		{
			return( function( ...innerParams ):void
			{
				method.apply( method.prototype, params.concat( innerParams ) );
			} );
		}
		
		
		
		/* ---------------------------------------------------------------------
			AUTH UTILS( restricted access control )
		--------------------------------------------------------------------- */
		
		/**
		 * Authenticates classes for restricted/protected access.
		 * @return	If auth suceed sucessfully returns the restricted namespace,
		 * otherwise return <code>null</code>.
		 */
		final public function auth( caller : Object ) : Namespace
		{
			var cls : Class;
			
			for each( cls in _authorized )
				if( caller is cls )
					return _restricted;
			
			return null;
		}
		
		
		
		/* ---------------------------------------------------------------------
			CLASS DETAILS
		--------------------------------------------------------------------- */
		
		/**
		 * Gets the class name.
		 * @return	The class name, without the package notation.
		 */
		final public function get class_name() : String {
			return class_path.split( "." ).pop();
		}
		
		/**
		 * Gets the class path.
		 * @return	The class path, with the package notation.
		 */
		final public function get class_path() : String {
			return getQualifiedClassName( this ).replace( "::", "." );
		}
		
		
		
		/* ---------------------------------------------------------------------
			UTILS
		--------------------------------------------------------------------- */
		
		/**
		 * Describes the given item as XML.
		 * @return	Item described to XML. 
		 */
		final public function describe( name : String ) : XML
		{
			var described : XML;
			
			try
			{
				described = describeType( this[ name ] );
			}
			catch( e : Error )
			{
				_log.warn( "Cannot describe item "+ name +"''." );
				_log.warn( e );
			}
			
			return described;
		}
		
		/**
		 * Check if some property/method/variabel is defined in the given scope.
		 * @param scope	Scope to evaluate.
		 * @param property	Property/Method/Variable to evaluate.
		 * @return	<code>true</code> 'if scope[ property ]' is defined,
		 * otherwise return <code>false</code>. 
		 */
		final public function defined( scope : *, property : String ) : Boolean
		{
			var result : Boolean;
			
			try
			{
				scope[ property ];
				result = true;
			}
			catch( e : Error ) 
			{
				if( e.errorID == 1006 )
					result = false;
			}
			
			return result;
		}
		
		/**
		 * Tries to execute some method, handling the possible error results.
		 * @param scope	Method scope.
		 * @param method	Method name.
		 * @param params	Method params
		 */
		final public function try_exec(
			scope : *,
			method : String,
			params : * = null
		) : void
		{
			if( defined( scope, method ) )
				scope[ method ].apply( scope,(
					params != null ? [].concat( params ) : []
				) );
		}
		
		
		
		/* ---------------------------------------------------------------------
			CASTING VALUES
		--------------------------------------------------------------------- */
		
		/**
		 * Cast the given value as <code>Number</code>.
		 * @param value	Value to be casted.
		 * @return	Value as <code>Number</code>.
		 */
		final protected function n( value : * ) : uint
		{
			return Number( value );
		}
		
		/**
		 * Cast the given value as <code>int</code>.
		 * @param value	Value to be casted.
		 * @return	Value as <code>int</code>.
		 */
		final protected function i( value : * ) : int
		{
			return int( value );
		}
		
		/**
		 * Cast the given value as <code>uint</code>.
		 * @param value	Value to be casted.
		 * @return	Value as <code>uint</code>.
		 */
		final protected function u( value : * ) : uint
		{
			return uint( value );
		}
		
		/**
		 * Cast the given value as <code>Boolean</code>.
		 * @param value	Value to be casted.
		 * @return	Value as <code>Boolean</code>.
		 */
		final protected function b( value : * ) : Boolean
		{
			return Boolean( value );
		}
	}
}