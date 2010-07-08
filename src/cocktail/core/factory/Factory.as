package cocktail.core.factory 
{
	import cocktail.core.Index;
	import cocktail.utils.StringUtil;

	import flash.utils.getDefinitionByName;

	/**
	 * This class will handle all mvc instantiations.
	 * 
	 * Controllers and models will have just one instance per application.
	 * 
	 * @author hems | hems@codeine.it
	 * @author nybras | nybras@codeine.it
	 */
	public class Factory extends Index
	{
		
		public static const LIB : String = "cocktail.lib";
		
		public static const VIEWS : String = "views";

		public static const ELEMENTS: String = "elements"; 
		
		public static const LAYOUTS : String = "layouts";

		public static const MODELS : String = "models";

		public static const CONTROLLERS : String = "controllers";

		public static const VIEW_SUFIX : String = 'View';

		public static const LAYOUT_SUFIX : String = 'Layout';

		public static const MODEL_SUFIX : String = 'Model';

		public static const COONTROLLER_SUFIX : String = 'Controller';
		
		public function Factory() 
		{
		}

		/* ERROR MESSAGE TEMPLATE */
		
		/**
		 * Formats an customized prefrix error message based on given name.
		 * @param name	Class name not found.
		 * @param kind	Base class name.
		 */
		private function _m( name : String, base : String ) : String
		{
			var message : String;
			
			message = "Class '" + ( name ? name + base : "null" );
			message += "' was not found, so the default " + base + " was used.";
			
			return message;
		}

		/* CLASS EVALUATOR */
		
		/**
		 * Returns a class reference according the given classpath.
		 * @param classpath	Desired classpath.
		 * @return	The found class reference.
		 */
		public function evaluate( classpath : String ) : Class
		{
			return Class( getDefinitionByName( classpath ) );
		}

		/**
		 * Evaluates classes for Model, View, Controller and Layout.
		 * @param folder	Class folder name.
		 * @param classname	Class name.
		 */
		private function _mvcl( 
			folder : String, 
			classname : String,
			in_lib: Boolean = false ) : Class
		{
			var klass : Class;
			var path : String;
			
			path = in_lib ? LIB : _cocktail.app_id; 
			path = path + "." + folder + "." + classname;
			
			return evaluate( path );
		}

		/**
		 * Evaluates the given Controller class by name and return it.
		 * @param name	Controller name (CamelCased).
		 * @return	Controller class to be instantiated.
		 */
		public function controller( name : String ) : Class
		{
			
			try
			{
				return _mvcl( CONTROLLERS, name + COONTROLLER_SUFIX );
			} catch( e : Error )
			{
				log.warn( _m( name, COONTROLLER_SUFIX ) );
			}
			
			return evaluate( _cocktail.app_id + ".AppController" );
		}

		/**
		 * Evaluates the given Model class by name and return it.
		 * @param name	Model name (CamelCased).
		 * @return	Model class to be instantiated.
		 */
		public function model( name : String ) : Class
		{
			try
			{
				return _mvcl( MODELS, name + MODEL_SUFIX );
			} catch( e : Error )
			{
				log.warn( _m( name, MODEL_SUFIX ) );
			}
			
			return evaluate( _cocktail.app_id + ".AppModel" );
		}

		/**
		 * Evaluates the given Layout class by name and return it.
		 * 
		 * @param name	Layout name (CamelCased).
		 * @return	Layout class to be instantiated.
		 */
		public function layout( name : String ) : Class
		{
			try
			{
				return _mvcl( LAYOUTS, name + LAYOUT_SUFIX );
			} catch( e : Error )
			{
				log.warn( _m( name, LAYOUT_SUFIX ) );
			}
			
			return evaluate( _cocktail.app_id + ".AppLayout" );
		}

		/**
		 * Evaluates the given View class by name and return it.
		 * 
		 * Path priority:
		 * 	- app/views/{area}/
		 * 	- app/views/elements/
		 * 	- cocktail/lib/views/
		 * 	
		 * @param name	View name (CamelCased).
		 * @return	View class to be instantiated.
		 */
		public function view( area: String, name : String ) : Class
		{
			try
			{
				return _mvcl( VIEWS, area + '.' + name + VIEW_SUFIX );
			} catch( e : Error )
			{
				log.warn( _m( name, VIEW_SUFIX ) );
			}
			
			try
			{
				return _mvcl( VIEWS, ELEMENTS + '.' + name + VIEW_SUFIX );
			} catch( e : Error )
			{
				log.warn( _m( name, VIEW_SUFIX ) );
			}
			
			try
			{
				return _mvcl( VIEWS, name + VIEW_SUFIX, true );
			} catch( e : Error )
			{
				log.warn( _m( name, VIEW_SUFIX ) );
			}
			
			return evaluate( _cocktail.app_id + ".AppView" );
		}

		/**
		 * Evaluates the desired DataSource class based on the given type.
		 * @param type	Datasource type to be evaluated.
		 */
		public function datasource( type : String ) : Class
		{
			var path : String;
			
			path = "cocktail.lib.model.datasources.";
			path += StringUtil.ucasef( type );
			path += "DataSource";
			
			return evaluate( path );
		}
	}
}