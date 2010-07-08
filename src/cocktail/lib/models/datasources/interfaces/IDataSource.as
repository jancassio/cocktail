package cocktail.lib.models.datasources.interfaces 
{
	import cocktail.lib.models.datasources.ADataSource;

	public interface IDataSource
	{
		function load() : ADataSource;

		function parse() : void;

		function bind() : void;
	}
}