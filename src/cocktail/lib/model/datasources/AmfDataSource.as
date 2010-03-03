package cocktail.lib.model.datasources 
{
	import cocktail.core.request.Request;
	import cocktail.core.slave.slaves.AmfSlave;
	import cocktail.lib.Model;
	import cocktail.lib.model.datasources.gunz.InlineDataSourceBullet;
	import cocktail.lib.model.datasources.interfaces.IDataSource;

	public class AmfDataSource extends ADataSource implements IDataSource 
	{
		/* VARS */
		private var _slave : AmfSlave;

		private var _requests : Array;

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
			_slave.gunz_complete.add( _after_load );
			
			_requests = [];
			for each( var method : XML in _scheme.children( ) )
				_requests.push( new AmfRequest( method ) );
			
			_load_requests( );
			
			return this;
		}

		private function _load_requests() : void
		{
			var request : AmfRequest;
			
			if( !_requests.length )
			{
				_after_load( );
				return;
			}
			
			request = _requests.shift( );
			
		}

		private function _after_load() : void
		{
			gunz_load_complete.shoot( new InlineDataSourceBullet( ) );
			bind( );
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

internal class AmfRequest
{
	public var name : String;

	public var params : Array;

	public var binds : XMLList;

	public function AmfRequest( raw : XML )
	{
		name = raw.localName( );
		params = [].concat( raw.@params.split( "|" ) );
		binds = raw.children( );
	}
}