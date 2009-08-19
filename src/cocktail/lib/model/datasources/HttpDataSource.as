package cocktail.lib.model.datasources 
{
	import cocktail.Cocktail;
	import cocktail.lib.model.datasources.DataSource;
	import cocktail.lib.model.datasources.interfaces.IDataSource;	

	public class HttpDataSource extends DataSource implements IDataSource
	{

		public function HttpDataSource( cocktail : Cocktail )
		{
			super( cocktail );
		}
	}
}