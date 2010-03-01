package cocktail.lib.model.datasources 
{
	import cocktail.lib.Model;
	import cocktail.lib.model.datasources.gunz.InlineDataSourceBullet;
	import cocktail.lib.model.datasources.interfaces.IDataSource;
	import cocktail.utils.Timeout;

	public class HttpDataSource extends ADataSource implements IDataSource 
	{
		public function HttpDataSource( model : Model, scheme : XML = null )
		{
			super( model, scheme );
		}
		
		/* LOADING */
		override public function load() : void
		{
			new Timeout( _after_load, 1 );
		}
		
		private function _after_load() : void
		{
			gunz_load_complete.shoot( new InlineDataSourceBullet( ) );
			bind( );
		}
		
		override public function bind() : void
		{
		}
	}
}