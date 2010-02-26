package cocktail.lib.model.datasources 
{
	import cocktail.lib.Model;
	import cocktail.lib.model.datasources.gunz.InlineDataSourceBullet;
	import cocktail.lib.model.datasources.interfaces.IDataSource;
	import cocktail.utils.Timeout;

	public class AmfDataSource extends ADataSource implements IDataSource 
	{
		public function AmfDataSource( model : Model, scheme : XML = null )
		{
			super( model, scheme );
		}
		
		/* LOADING */
		override public function load() : ADataSource
		{
			new Timeout( _after_load, 1 );
			return this;
		}
		
		private function _after_load() : void
		{
			gunz_load_complete.shoot( new InlineDataSourceBullet( ) );
			bind( );
		}
		
		public function bind() : void
		{
//			var node : XML;
//			var result : *;
//			var name : String;
//			var value : String;
//			var bind_exp : String;
//			
//			for each ( node in _binds )
//			{
//				value = node.toString( );
//				name = node.localName( ) as String;
//				
//				for each ( bind_exp in StringUtil.enclosure( value, "{", "}" ) )
//				{
//					result = _query( StringUtil.innerb( bind_exp ) );
//					value = value.replace( bind_exp, result );
//				}
//				
//				_model.bind.s( name, value );
//			}
//			
//			for each ( var node : XML in _binds )
//				_model.bind.s( node.localName( ), node.toString( ) );
		}
	}
}