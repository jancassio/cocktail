package cocktail.lib.model.datasources 
{
	import cocktail.core.request.Request;
	import cocktail.core.slave.gunz.AmfSlaveBullet;
	import cocktail.core.slave.slaves.AmfSlave;
	import cocktail.lib.Model;
	import cocktail.lib.model.datasources.gunz.InlineDataSourceBullet;
	import cocktail.lib.model.datasources.interfaces.IDataSource;
	import cocktail.utils.StringUtil;

	public class AmfDataSource extends ADataSource implements IDataSource 
	{
		/* VARS */
		private var _slave : AmfSlave;

		private var _current_call : AmfCall;

		private var _current_result : *;

		private var _calls : Array;

		public var  params : Array;

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
			_slave.gunz_complete.add( _load_requests );
			
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
				_current_result = bullet.result.data;
				bind( );
			}
			
			if( !_calls.length )
			{
				_after_load( );
				return;
			}
			
			_current_call = _calls.shift( );
			_slave.load( _current_call.name, _current_call.params );
		}

		private function _after_load() : void
		{
			gunz_load_complete.shoot( new InlineDataSourceBullet( ) );
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
			var query_exp : String;
			var bind_exps : Array;
			
			for each ( var node : XML in _current_call.binds )
			{
				name = node.localName( );
				value = node.text( );
				
				bind_exps = StringUtil.enclosure( value, "{", "}" );
				for each ( query_exp in bind_exps )
				{
					if( query_exp == "{RAW}" )
						result = _current_result;
					else
						result = _query( StringUtil.innerb( query_exp ) );
					
					value = value.replace( query_exp, result );
				}
				
				_model.bind.s( node.localName( ), value );
			}
		}

		/* QUERING */
		private function _query( q : String ) : String
		{
			var steps : Array;
			var data : *;
			
			if ( q == "RAW" )
				return _current_result;
			
			steps = q.split( "." );
			data = _current_result;
			
			while ( steps.length ) try 
			{
				data = data[ steps.shift( ) ];
			} catch ( e : Error ) 
			{
				log.fatal( e.message );
			}
			
			return data;
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
		params = [].concat( raw.@params.split( "|" ) );
		binds = raw.children( );
	}
}