package cocktail.lib.models.datasources 
{
	import cocktail.core.request.Request;
	import cocktail.core.slave.gunz.TextSlaveBullet;
	import cocktail.lib.Model;
	import cocktail.lib.models.datasources.gunz.InlineDataSourceBullet;
	import cocktail.lib.models.datasources.interfaces.IDataSource;
	import cocktail.utils.StringUtil;

	import com.adobe.serialization.json.JSON;

	public class JsonDataSource extends XmlDataSource implements IDataSource 
	{
		/* INITIALIZING */
		public function JsonDataSource(
			model : Model,
			request : Request,
			scheme : XML = null
		)
		{
			super( model, request, scheme );
		}

		/* LOADING */
		override protected function _after_load( bullet : TextSlaveBullet ) : void
		{
			_result = JSON.decode( bullet.data );
			bind( );
			gunz_load_complete.shoot( new InlineDataSourceBullet( ) );
		}

		/* PARSING */
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
					if( bind_query == "{RAW}" )
						result = _result;
					else
						result = _query( StringUtil.innerb( bind_query ) );
					
					value = value.replace( bind_query, result );
				}
				
				_model.bind.s( node.localName( ), value );
			}
		}

		/* QUERING */
		override protected function _query( q : String ) : String
		{
			var steps : Array;
			var data : *;
			
			if ( q == "RAW" )
				return _result;
			
			q = q.replace( "[", "." ).replace( "].", "." ).replace( "]", "" );
			steps = q.split( "." );
			data = _result;
			
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