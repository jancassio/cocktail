package cocktail.lib.model.datasources 
{
	import cocktail.Cocktail;
	import cocktail.lib.model.datasources.DataSource;
	import cocktail.lib.model.datasources.interfaces.IDataSource;	

	public class AmfDataSource extends DataSource implements IDataSource
	{
		public function AmfDataSource( cocktail : Cocktail )
		{
			super( cocktail );
		}
	}
}