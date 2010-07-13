package cocktail.utils 
{
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author hems @ henriquematias.com
	 */
	public class ObjectUtil 
	{
		public static function classpath( obj: * ): String
		{
			return getQualifiedClassName( obj ).replace( "::", "." );
		}

		public static function classname(obj : *) : String 
		{
			return ObjectUtil.classpath( obj ).split( "." ).pop( );
		}
		
		/**
		 * Describes the given property as XML.
		 * @return	Item described to XML. 
		 */
		public static function describe( obj: Object, name : String ) : XML
		{
			var described : XML;
			
			try
			{
				described = describeType( obj[ name ] );
			}
			catch( e : Error )
			{
				return null;
			}
			
			return described;
		}

		public static function is_defined(
			scope : *, 
			property : String
		) : Boolean 
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
		 * Tries to execute some method, omitting the possible error results.
		 * 
		 * @param scope	Method scope.
		 * @param method	Method name.
		 * @param params	Method params
		 */
		public static function exec(
			scope : *,
			method : String,
			params : * = null
		) : *
		{
			if( is_defined( method, scope ) )
				return Function( scope[ method ] ).apply( scope, (
					params != null ? [][ 'concat' ]( params ) : []
				) );
		}
	}
}
