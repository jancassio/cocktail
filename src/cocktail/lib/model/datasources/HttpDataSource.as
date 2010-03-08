package cocktail.lib.model.datasources 
{
	import cocktail.core.request.Request;
	import cocktail.core.slave.gunz.TextSlaveBullet;
	import cocktail.core.slave.slaves.TextSlave;
	import cocktail.lib.Model;
	import cocktail.lib.model.datasources.gunz.InlineDataSourceBullet;
	import cocktail.lib.model.datasources.interfaces.IDataSource;
	import cocktail.utils.StringUtil;

	public class HttpDataSource extends InlineDataSource implements IDataSource 
	{
		/* VARS */
		private var _slave : TextSlave;

		private var _result : *;

		/* 	INITIALIZING */
		public function HttpDataSource(
			model : Model,
			request : Request,
			scheme : XML = null
		)
		{
			super( model, request, scheme );
		}

		/* LOADING */
		override public function load() : ADataSource
		{
			_slave = new TextSlave( );
			_slave.gunz_complete.add( _after_load ).once( );
			_slave.load( src );
			return this;
		}

		protected function _after_load( bullet : TextSlaveBullet ) : void
		{
			_result = bullet.data;
			bind( );
			gunz_load_complete.shoot( new InlineDataSourceBullet( ) );
		}

		/* PARSING */
		override public function parse() : void
		{
			super.parse( );
			src = _scheme.@src;
		}

		/* BINDING */
		override public function bind() : void
		{
			var name : String;
			var value : String;
			var result : String;
			var bind_query : String;
			var bind_queries : Array;
			
			for each ( var node : XML in _binds )
			{
				name = node.localName( );
				value = node.text( );
				
				bind_queries = StringUtil.enclosure( value, "{", "}" );
				for each ( bind_query in bind_queries )
				{
					result = _result;
					value = value.replace( bind_query, result );
				}
				
				_model.bind.s( node.localName( ), value );
			}
		}
	}
}