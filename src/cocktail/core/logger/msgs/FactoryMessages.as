package cocktail.core.logger.msgs 
{

	/**
	 * @author hems | henrique@cocktail.as
	 */
	public class FactoryMessages 
	{
		public static function datasource_not_found( type: String ): String
		{
			return "DataSource ( " + type + " ) not found. Using InlineDataSource";	
		}

		public static function view_not_found( path : String ) : * 
		{
			return "View ( " + path + " ) not found. Returning AppView";	
		}

		public static function layout_not_found( name : String ) : * 
		{
			return "Layout ( " + name + " ) not found. Returning AppLayout";	
		}

		public static function model_not_found(name : String) : * 
		{
			return "Model ( " + name + " ) not found. Returning AppModel";	
		}

		public static function controller_not_found(name : String) : * 
		{
			return "Controller ( " + name + " ) not found. Returning AppController";	
		}

		public static function evaluated_to_null( classpath : String) : String 
		{
			return "Class ( " + classpath + " ) not found ";
		}
	}
}
