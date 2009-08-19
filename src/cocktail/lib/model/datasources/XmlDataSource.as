package cocktail.lib.model.datasources
{
	import cocktail.Cocktail;
	import cocktail.lib.model.datasources.interfaces.IDataSource;		

	public class XmlDataSource extends DataSource implements IDataSource
	{

		public function XmlDataSource( cocktail : Cocktail )
		{
			super( cocktail );
		}
	}
}