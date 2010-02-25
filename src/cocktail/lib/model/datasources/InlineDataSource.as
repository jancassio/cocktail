package cocktail.lib.model.datasources 
{
	import cocktail.lib.model.datasources.gunz.InlineDataSourceBullet;
	import cocktail.lib.model.datasources.interfaces.IDataSource;
	import cocktail.utils.Timeout;

	public class InlineDataSource extends ADataSource implements IDataSource 
	{
		public function InlineDataSource( info : XML )
		{
			super( info );
			new Timeout( _after_load, 1 );
			raw = _scheme.children().toString();
		}
		
		private function _after_load( ...etc ) : void
		{
			gunz_load_complete.shoot( new InlineDataSourceBullet() );
			
		}
	}
}