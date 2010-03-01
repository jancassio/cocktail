package cocktail.lib.model.datasources
{
	import cocktail.lib.Model;
	import cocktail.lib.model.datasources.gunz.InlineDataSourceBullet;
	import cocktail.lib.model.datasources.interfaces.IDataSource;

	public class XmlDataSource extends ADataSource implements IDataSource
	{
		/* VARS */
//		private var _slave : TextSlave;
		
		/* INITIALIZING */
		public function XmlDataSource( model : Model, scheme : XML = null )
		{
			super( model, scheme );
		}

		/* LOADING */
		override public function load() : void
		{
//			_slave = new TextSlave(uri, auto_load)
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