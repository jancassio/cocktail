package cocktail.core.factory {
	import cocktail.lib.view.assets.AAsset;
	import cocktail.core.Index;
	import cocktail.utils.StringUtil;

	import flash.utils.getDefinitionByName;

	/**
	 * Factory class.
	 * @author hems | hems@codeine.it
	 * @author nybras | nybras@codeine.it
	 */
	public class Factory extends Index
	{
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
		private function _mvcl( folder : String, classname : String ) : Class
		{
			var klass : Class;
			var path : String;
			
			path = _cocktail.app_id + "." + folder + "." + classname;
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
				return _mvcl( "controllers", name + "Controller" );
			} catch( e : Error )
			{
				log.warn( _m( name, "Controller" ) );
			}
			return evaluate( "cocktail.lib.Controller" );
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
				return _mvcl( "models", name + "Model" );
			} catch( e : Error )
			{
				log.warn( _m( name, "Model" ) );
			}
			return evaluate( "cocktail.lib.Model" );
		}

		/**
		 * Evaluates the given Layout class by name and return it.
		 * @param name	Layout name (CamelCased).
		 * @return	Layout class to be instantiated.
		 */
		public function layout( name : String ) : Class
		{
			try
			{
				return _mvcl( "layouts", name + "Layout" );
			} catch( e : Error )
			{
				log.warn( _m( name, "Layout" ) );
			}
			return evaluate( "cocktail.lib.Layout" );
		}

		/**
		 * Evaluates the given View class by name and return it.
		 * @param name	View name (CamelCased).
		 * @return	View class to be instantiated.
		 */
		public function view( name : String ) : Class
		{
			try
			{
				return _mvcl( "views", name + "View" );
			} catch( e : Error )
			{
				log.warn( _m( name, "View" ) );
			}
			return evaluate( "cocktail.lib.View" );
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

		public function asset( node : * ) : Class 
		{
			var path : String;
			
			path = "cocktail.lib.view.assets.";
			path += StringUtil.ucasef( '' );
			path += "DataSource";
			
			return evaluate( path );
		}
	}
}