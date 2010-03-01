package cocktail.lib.model.datasources 
{
	import cocktail.lib.Model;
	import cocktail.lib.model.datasources.gunz.InlineDataSourceBullet;
	import cocktail.lib.model.datasources.interfaces.IDataSource;
	import cocktail.utils.Timeout;

	public class InlineDataSource extends ADataSource implements IDataSource 
	{
		/* INITIALIZING */
		public function InlineDataSource( model : Model, scheme : XML = null )
		{
			super( model, scheme );
			_raw = _scheme.children( ).toString( );
		}

		/* LOADING */
		override public function load() : void
		{
			new Timeout( _after_load, 1 );
		}

		private function _after_load() : void
		{
			gunz_load_complete.shoot( new InlineDataSourceBullet( ) );
			parse( );
			bind( );
		}

		/* PARSE */
		override public function parse() : void
		{
			id = _scheme.@id;
			inject = _scheme.@inject;
			locale = _scheme.@locale;
			src = _scheme.@src;
			
			_binds = _scheme.children( );
		}

		/* BINDING */
		override public function bind() : void
		{
			for each ( var node : XML in _binds )
				_model.bind.s( node.localName( ), node.text( ) );
		}
	}
}