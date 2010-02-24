package cocktail.lib.model.datasources.interfaces 
{
	import cocktail.lib.model.datasources.ADataSource;

	public interface IDataSource
	{
		function load() : ADataSource;
	}
}