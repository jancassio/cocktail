package cocktail.lib.models.datasources 
{
	import cocktail.core.request.Request;
	import cocktail.core.slave.gunz.AmfSlaveBullet;
	import cocktail.core.slave.slaves.AmfSlave;
	import cocktail.lib.Model;
	import cocktail.lib.models.datasources.gunz.InlineDataSourceBullet;
	import cocktail.lib.models.datasources.interfaces.IDataSource;
	import cocktail.utils.StringUtil;

	public class AmfDataSource extends JsonDataSource implements IDataSource 
	{
		/* VARS */
		private var _slave : AmfSlave;

		private var _current_call : AmfCall;

		private var _calls : Array;

		public var  params : Array;

		/* INITIALIZING */
		public function AmfDataSource(
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
			_slave = new AmfSlave( config.gateway( ), src );
			_slave.on_complete.add( _load_requests );
			
			_calls = [];
			for each( var method : XML in _scheme.children( ) )
				_calls.push( new AmfCall( method ) );
			
			_load_requests( );
			
			return this;
		}

		private function _load_requests( bullet : AmfSlaveBullet = null ) : void
		{
			
			if( bullet != null )
			{
				_result = bullet.result.data;
				bind( );
			}
			
			if( !_calls.length )
			{
				gunz_load_complete.shoot( new InlineDataSourceBullet( ) );
				return;
			}
			
			_current_call = _calls.shift( );
			_slave.load( _current_call.name, _current_call.params );
		}

		override public function parse() : void
		{
			id = _scheme.@id;
			inject = _scheme.@inject;
			locale = _scheme.@locale;
			src = _scheme.@src;
		}

		override public function bind() : void
		{
			var name : String;
			var value : String;
			var result : String;
			var bind_query : String;
			var bind_queries : Array;
			
			for each ( var node : XML in _current_call.binds )
			{
				name = node.localName( );
				value = node.text( );
				
				bind_queries = StringUtil.enclosure( value, "{", "}" );
				for each ( bind_query in bind_queries )
				{
					if( bind_query == "{RAW}" )
						result = _result;
					else
						result = _query( StringUtil.innerb( bind_query ) );
					
					value = value.replace( bind_query, result );
				}
				
				_model.bind.s( node.localName( ), value );
			}
		}
	}
}

internal class AmfCall
{
	public var name : String;

	public var params : Array;

	public var binds : XMLList;

	public function AmfCall( raw : XML )
	{
		name = raw.localName( );
		params = [].concat( String( raw.@params ).split( "|" ) );
		binds = raw.children( );
	}
}