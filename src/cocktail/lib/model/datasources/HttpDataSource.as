package cocktail.lib.model.datasources 
{
	import cocktail.core.request.Request;
	import cocktail.core.slave.gunz.TextSlaveBullet;
	import cocktail.core.slave.slaves.TextSlave;
	import cocktail.lib.Model;
	import cocktail.lib.model.datasources.gunz.InlineDataSourceBullet;
	import cocktail.lib.model.datasources.interfaces.IDataSource;
	import cocktail.utils.StringUtil;

	public class HttpDataSource extends ADataSource implements IDataSource 
	{
		private var _slave : TextSlave;
		private var _result : *;

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
			_slave.gunz_complete.add( _after_load );
			_slave.load( src );
			return this;
		}

		private function _after_load( bullet : TextSlaveBullet ) : void
		{
			_result = bullet.data;
			bind( );
			gunz_load_complete.shoot( new InlineDataSourceBullet( ) );
		}

		override public function parse() : void
		{
			id = _scheme.@id;
			inject = _scheme.@inject;
			locale = _scheme.@locale;
			src = _scheme.@src;
			_binds = _scheme.children();
		}

		override public function bind() : void
		{
			var name : String;
			var value : String;
			var result : String;
			var query_exp : String;
			var bind_exps : Array;
			
			for each ( var node : XML in _binds )
			{
				name = node.localName( );
				value = node.text( );
				
				bind_exps = StringUtil.enclosure( value, "{", "}" );
				for each ( query_exp in bind_exps )
				{
					result = _result;
					value = value.replace( query_exp, result );
				}
				
				_model.bind.s( node.localName( ), value );
			}
		}
	}
}