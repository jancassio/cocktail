package cocktail.lib.model.datasources.interfaces 
{

	public interface IDataSource
	{
		function load() : void;

		function parse() : void;

		function bind() : void;
	}
}