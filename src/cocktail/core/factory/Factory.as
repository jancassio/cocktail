package cocktail.core.factory 
{
	import cocktail.Cocktail;

	import flash.utils.Dictionary;	

	/**
	 * @author hems | hems@codeine.it
	 */
	public class Factory 
	{

		private var _uniques: Dictionary;
		public var app: Cocktail;

		/**
		 * @param app owner of the fabric
		 */
		public function Factor( cocktail: Cocktail )
		{
			app = cocktail;
			_uniques = new Dictionary( );
		}

		
		
		/* unique references */
		
		
		
		/**
		 * Return a unique controller
		 * @param process	ProcessDAO to get the controller search.
		 */
		public function controller( clean_class_name: String ): Controller
		{
			var cls: Class;
			var ctrl: Controller;
			var path: String;

			path = config.appId + ".controllers." + clean_class_name + "Controller";
					
			if( defined( _uniques, path ) )
				cls = _uniques[ path ];
			else
			{
				cls = get_class( path );
				ctrl = new cls( );
				_uniques[ path ] = ctrl;
			}
			
		
			return ctrl;
		}

		/**
		 * Return a unique model
		 * @param process	ProcessDAO to get the controller search.
		 */
		public function model( clean_class_name: String ): Model
		{
			var cls: Class;
			var model: Model;
			var path: String;
			
			path = config.appId + ".models." + clean_class_name + "Model";
			
			if( defined( _uniques, path ) )
				cls = _uniques[ path ];
			else
			{
				cls = get_class( path );
				model = new cls( );
				_uniques[ path ] = cls;
			}
			
		
			return model;
		}

		/* instant new instances */

		public function layout( clean_class_name: String ): Layout
		{
			var path: String;
			path = config.appId + ".layouts." + clean_class_name + "Layout";
			
			return new ( get_class( path ) )( );
		}
	}
}