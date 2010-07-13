package cocktail.core.factory 
{
	import cocktail.core.Index;
	import cocktail.core.logger.msgs.FactoryMessages;
	import cocktail.lib.Controller;
	import cocktail.lib.Layout;
	import cocktail.lib.Model;
	import cocktail.lib.models.datasources.InlineDataSource;
	import cocktail.utils.StringUtil;

	import flash.utils.getDefinitionByName;

	/**
	 * This class will handle all mvc instantiations.
	 * 
	 * Controllers / models / layouts will have just 
	 * one instance per application.
	 * 
	 * PIMP: make a generic instantiator that will receive the "name", "sufix"
	 * and possible paths in order of priority
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

		public static const DATASOURCE: String = 'datasources';
		
		public static const VIEW_SUFIX : String = 'View';

		public static const LAYOUT_SUFIX : String = 'Layout';

		public static const MODEL_SUFIX : String = 'Model';

		public static const COONTROLLER_SUFIX : String = 'Controller';
		
		public static const DATASOURCE_SUFIX : String = 'DataSource';
		
		private var _controllers: Object;
		
		private var _models: Object;

		private var _layouts: Object;
		
		public function Factory() 
		{
			_controllers = {};
			_models = {};
			_layouts = {};
		}

		/**
		 * Returns a class reference according the given classpath.
		 * 
		 * @param classpath	Desired classpath.
		 * @return	The found class reference.
		 */
		public function evaluate( classpath : String ) : Class
		{
			try
			{
				return Class( getDefinitionByName( classpath ) );
			}
			catch( e: Error )
			{
				//user feedback was implemented in each method
				return null;
			}
			
			return null;
		}

		/**
		 * Evaluates classes for Model, View, Controller and Layout.
		 * 
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
		 * 
		 * Path priority:
		 * 	- app/controllers/{area}/{name}Controller
		 * 	- cocktail/lib/controllers/{name}Controller
		 * 	
		 * @param name	Controller name ( CamelCased ).
		 * @return	AppController as Controller
		 */
		public function controller( name : String ) : Controller
		{
			var klass: Class;
			var controller : Controller;
		
			// app/controllers/{area}/{name}Controller
			klass = _mvcl( CONTROLLERS, name + COONTROLLER_SUFIX );
				
			// cocktail/lib/controllers/{name}Controller
			if( !klass )
				klass = _mvcl( CONTROLLERS, name + COONTROLLER_SUFIX, true );
				
			if( !klass )
			{	
				// let the user know what happened
				log.notice( FactoryMessages.controller_not_found( name ) );
				klass = evaluate( _cocktail.app_id + ".AppController" );
			}
			
			
			if( _controllers.hasOwnProperty( name ) )
				return _controllers[ name ];
			else
			{
				controller = Controller( new ( klass )( ) ).boot( _cocktail );
				_controllers[ name ] = controller;
			}
			
			return controller;
		}

		/**
		 * Evaluates the given Model class by name and return it.
		 * 
		 * Path priority:
		 * 	- app/models/{area}/{name}Model
		 * 	- cocktail/lib/models/{name}Model
		 * 	
		 * @param name	Model name ( CamelCased ).
		 * @return	AppModel as Model
		 */
		public function model( name : String ) : Model
		{
			var klass: Class;
			var model: Model;
			
			name = StringUtil.toCamel( name );
			
			// app/models/{area}/{name}Model
			klass = _mvcl( MODELS, name + MODEL_SUFIX );
				
			// cocktail/lib/models/{name}Model
			if( !klass )
				klass = _mvcl( MODELS, name + MODEL_SUFIX, true ); 
			
			if( !klass )
			{
				// let the user know what happened
				log.notice( FactoryMessages.model_not_found( name ) );
				
				klass = evaluate( _cocktail.app_id + ".AppModel" );
			}
			
			
			if( _models.hasOwnProperty( name ) )
				return _models[ name ];
			else
			{
				model = Model( new ( klass )( ) ).boot( _cocktail );
				_models[ name ] = model;
			}
			
			return model;
		}

		/**
		 * Evaluates the given Layout class by name and return it.
		 * 
		 * Path priority:
		 * 	- app/layouts/{name}Layout
		 * 	- cocktail/lib/layouts/{name}Layout
		 * 	
		 * @param name	Layout name ( CamelCased ).
		 * @return	AppLayout as Layout
		 */
		public function layout( name : String ) : Layout
		{
			var klass: Class;
			var layout: Layout;
			
			name = StringUtil.toCamel( name );
			
			// app/layouts/{name}Layout
			klass = _mvcl( LAYOUTS, name + LAYOUT_SUFIX );
				
			// cocktail/lib/layouts/{name}Layout
			if( !klass )
				klass = _mvcl( LAYOUTS, name + LAYOUT_SUFIX, true );
			
			if( !klass )
			{
				// let the user know what happened
				log.notice( FactoryMessages.layout_not_found( name ) );
				
				klass = evaluate( _cocktail.app_id + ".AppLayout" );
			}
			
			if( _layouts.hasOwnProperty( name ) )
				return _layouts[ name ];
			else
			{
				layout = Layout( new ( klass )( ) ).boot( _cocktail );
				_layouts[ name ] = layout;
			}
			
			return layout;
		}

		/**
		 * Evaluates the given View class by name and return it.
		 * 
		 * Path priority:
		 * 	- app/views/{area}/{name}View
		 * 	- app/views/elements/{name}View
		 * 	- cocktail/lib/views/{name}View
		 * 	
		 * @param name	View name (CamelCased).
		 * @return	View class to be instantiated.
		 */
		public function view( area: String, name : String ) : Class
		{
			var klass: Class;
			
			// app/views/{area}/{name}View
			if( ( klass = _mvcl( VIEWS, area + '.' + name + VIEW_SUFIX ) ) )
				return klass;
			
			// app/views/elementst/{name}View
			if( ( klass = _mvcl( VIEWS, ELEMENTS + '.' + name + VIEW_SUFIX ) ) )
				return klass;
			
			// cocktail/lib/views/{name}View
			if( ( klass = _mvcl( VIEWS, name + VIEW_SUFIX, true ) ) )
				return klass;

			// let the user know what happened			
			log.notice( FactoryMessages.view_not_found( area + '.' + name ) );
			
			return evaluate( _cocktail.app_id + ".AppView" );
		}

		/**
		 * Evaluates the desired DataSource class based on the given type.
		 * 
		 * @param type	Datasource type to be evaluated.
		 */
		public function datasource( type : String ) : Class
		{
			var name: String;
			var klass: Class;
			
			name = StringUtil.toCamel( type ) + DATASOURCE_SUFIX;
			
			// app/models/datasources/{name}DataSource
			if( ( klass = _mvcl( MODELS + '.' + DATASOURCE , name ) ) )
				return klass;
				
			// cocktail/lib/models/datasources/{name}DataSource
			if( ( klass = _mvcl( MODELS + '.' + DATASOURCE , name, true ) ) )
				return klass;
			
			// let the user know what happened	
			log.notice( FactoryMessages.datasource_not_found( name ) );
			
			return InlineDataSource;
		}
	}
}