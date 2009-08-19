package cocktail.lib.model.datasources 
{
	import cocktail.Cocktail;
	import cocktail.lib.model.datasources.DataSource;
	import cocktail.lib.model.datasources.interfaces.IDataSource;	

	public class InlineDataSource extends DataSource implements IDataSource
	{

		public function InlineDataSource( cocktail : Cocktail )
		{
			super( cocktail );
		}
	}
}