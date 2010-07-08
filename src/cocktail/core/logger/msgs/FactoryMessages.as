package cocktail.core.logger.msgs 
{

	/**
	 * @author hems | henrique@cocktail.as
	 */
	public class FactoryMessages 
	{
		public static function datasource_not_found( type: String ): String
		{
			return "DataSource ( " + type + " ) not found. Returning Inline";	
		}
	}
}
