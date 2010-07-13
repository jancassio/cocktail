package cocktail.core 
{
	import cocktail.Cocktail;
	import cocktail.core.config.Config;
	import cocktail.core.factory.Factory;
	import cocktail.core.logger.Logger;
	import cocktail.core.router.Router;
	import cocktail.core.router.RoutesTail;
	import cocktail.utils.ObjectUtil;

	/**
	 * Index class is the base class for almost every class inside cocktail.
	 * @author nybras | nybras@codeine.it
	 */
	public class Index 
	{
		/* VARS */
		
		
		protected var _cocktail : Cocktail;

		public var log : Logger;


		/* STATIC */


		public static function drop_logger( 
			kocktail: Cocktail, //flex compiler understands "undefined property bind in package cocktail."
			classpath: String 
		): Logger
		{
			var log:Logger;
			
			log = new Logger( classpath );
			
			kocktail.bind.plug( "log-level", log, "level" );
			kocktail.bind.plug( "log-detail", log, "detail" );
						
			return log;
		}


		/* INITIALIZING */


		/**
		 * Boots the Index base class.
		 * 
		 * @param cocktail	Cocktail reference.
		 * 
		 * @return	Self reference for reuse.
		 */
		public function boot( cocktail : Cocktail ) : *
		{
			_cocktail = cocktail;
			
			log = drop_logger( _cocktail, classpath );
			
			return this;
		}


		/* API */
		
		
		/**
		 * Creates a proxy function holding default params.
		 * 
		 * @param method	Method to be handled.
		 * 
		 * @param params	Default params to be passed to method, these params
		 * will be added in *first* place.
		 * 
		 * @return	The proxy function with the given params.
		 */
		final public function proxy( method : Function, ...params ) : Function
		{
			return( function( ...innerParams ):void
			{
				method.apply( method.prototype, params.concat( innerParams ) );
			} );
		}

		/**
		 * Check if some property/method/variable is defined in the given scope.
		 * 
		 * @see	ObjectUtil::is_defined
		 * 
		 * @param property	Property/Method/Variable to evaluate.
		 * 
		 * @param scope	Scope to evaluate, if null use "this"
		 * 
		 * @return	<code>true</code> 'if obj[ property ]' is defined,
		 * otherwise return <code>false</code>. 
		 */
		final public function is_defined( 
			property : String, 
			obj : * = null 
		) : Boolean
		{
			obj = ( obj == null ) ? this : obj; 
			
			return ObjectUtil.is_defined( obj, property );
		}

		/**
		 * @see ObjectUtil::exec
		 */
		final public function exec(
			scope : *,
			method : String,
			params : * = null
		) : *
		{
			return ObjectUtil.exec( method, scope, params );
		}


		/* CLASS DETAILS */


		/**
		 * Gets the classname.
		 * 
		 * @return	The class name, without the package notation.
		 */
		final public function get classname() : String 
		{
			return ObjectUtil.classname( this );
		}

		/**
		 * Gets the classpath.
		 * @return	The class path, with the package notation.
		 */
		final public function get classpath() : String 
		{
			return ObjectUtil.classpath( this );
		}


		/* CASTING VALUES */


		/**
		 * Cast the given value as <code>Number</code>.
		 * 
		 * @param value	Value to be casted.
		 * 
		 * @return	Value as <code>Number</code>.
		 */
		final protected function n( value : * ) : uint
		{
			return Number( value );
		}

		/**
		 * Cast the given value as <code>int</code>.
		 * 
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


		/* ALIASES */


		/**
		 * @return !isNaN
		 */
		final public function isN( number : Number ) : Boolean
		{
			return !isNaN( number );
		}
		
		/**
		 * Get the application config.
		 * 
		 * @return	The application config.
		 */
		final public function get config() : Config
		{
			return _cocktail.config;
		}

		/**
		 * Get the application router.
		 * 
		 * @return	The application router.
		 */
		final public function get router() : Router
		{
			return _cocktail.router;
		}

		/**
		 * Get the application routes.
		 * 
		 * @return	The application routes.
		 */
		final public function get routes() : RoutesTail
		{
			return _cocktail.routes;
		}
		
		public function get cocktail() : Cocktail
		{
			return _cocktail;
		}

		public function get factory() : Factory
		{
			return _cocktail.factory;
		}
		
		public function get f(): Factory
		{
			return _cocktail.factory;
		}
	}
}