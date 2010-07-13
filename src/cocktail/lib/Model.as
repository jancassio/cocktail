package cocktail.lib 
{
	import cocktail.core.gunz.GunzGroup;
	import cocktail.core.request.Request;
	import cocktail.core.slave.gunz.ASlaveBullet;
	import cocktail.core.slave.slaves.TextSlave;
	import cocktail.lib.gunz.ModelBullet;
	import cocktail.lib.models.datasources.ADataSource;
	import cocktail.utils.StringUtil;

	/**
	 * This class will load the respective xml and it datasources. 
	 * 
	 * @author nybras	me@nybras.com
	 * @author hems	hems@henriquematias.com
	 */
	public class Model extends MV
	{
		/**
		 * @param request	Running request.
		 */
		public function load_xml( request : Request ) : Model
		{
			request;
			log.info( "Running..." );
			
			on_xml_load_start.shoot( new ModelBullet( ) );
			
			load_uri( _xml_path ).on_complete.add( _after_load_scheme ).once();
			
			return this;
		}

		/**
		 * Parsing model xml scheme.
		 * @param bullet	SlaveBullet.
		 */
		public function _after_load_scheme( bullet : ASlaveBullet ) : void
		{
			log.info( "Running..." );
			
			_xml = new XML( TextSlave( bullet.owner ).data );
			
			if( !_is_scheme_valid )
				log.fatal( "The scheme in this file has errors." + _xml_path );
			else
				on_xml_load_complete.shoot( new ModelBullet( ) );
		}

		/**
		 * Checks if the scheme is valid.
		 * @return	If shceme is valid, returns <code>true</code> otherwise
		 * return <code>false</code>.
		 */
		private function get _is_scheme_valid() : Boolean
		{
			log.info( "Running..." );
			// TODO: check for some reserved word, or things like that
			return true;
		}

		/* LOADING DATA */
		
		/**
		 * Filtering load action, if returns false, no load will occur
		 */
		public function before_load( ...n /* request : Request */ ) : Boolean
		{
			log.info( "Running..." );
			return true;
		}

		/**
		 * Load all datasources needed for the request.
		 * 
		 * @param request	Running request.
		 */
		public function load( request : Request ) : Boolean
		{
			var i : int;
			var group : GunzGroup;
			var ds_list : Array;
			var ds : ADataSource;
			
			if( !before_load( request ) ) return false;
			
			log.info( "Running..." );
			
			_is_loading = true;
			
			if( ( ds_list = _parse_datasources( request ) ).length )
			{
				group = new GunzGroup( );
				group.gunz_complete.add( _after_load );
				
				do
				{
					ds = ds_list[ i ];
					group.add( ds.gunz_load_complete );
					ds.load( );
				} while( ++i < ds_list.length );
			}
			else
			{
				_after_load();
			}
			
			return true;
		}

		/**
		 * Private handler to after_load
		 */
		private function _after_load( ...n /* bullet : Bullet */ ) : void
		{
			log.info( "Running..." );
			
			_is_loading = false; 
			
			after_load( );
			on_load_complete.shoot( new ModelBullet( ) );
		}

		/**
		 * Called after load all request datasources
		 */
		public function after_load() : void
		{
			log.info( "Running..." );
		}

		/**
		 * Parses all necessary Datasources for given request.
		 * @param request	Running request.
		 * @return	An array with all Datasources, properly instantiated. 
		 */
		private function _parse_datasources( request : Request ) : Array
		{
			log.info( "Running..." );
			
			var i : int;
			var ds : Array;
			var node : XML;
			var action : String;
			var inject : String;
			
			ds = []; 
			action = request.route.api.action;
			
			do
			{
				node   = _xml.children( )[ i ];
				inject = ( node.@inject + "," );
				
				if( inject == "*," || inject.indexOf( action + "," ) > 0 )
					ds.push( _instantiate_datasource( node, request ) );
			} while( ++i < _xml.children( ).length( ) );
			
			return ds;
		}

		/**
		 * Instantiate the DataSource based on the given xml node.
		 * @param node	XML Scheme representation of the Datasource to be
		 * instantiated.
		 */
		private function _instantiate_datasource(
			scheme : XML,
			request : Request
		) : ADataSource
		{
			log.info( "Running..." );
			
			var ds : ADataSource;
			var ds_class : Class;
			var name : String;
			
			name = scheme.localName( );
			
			/**
			 * ATT: If not found, Inline is used.
			 * @see Factory::datasource for details
			 */ 
			ds_class = _cocktail.factory.datasource( name );
			ds = new ( ds_class )( this, request, scheme );
			ds.boot( _cocktail );
			
			return ds;
		}

		/* GETTERS */

		/**
		 * Evaluates the path for the xml file.
		 * @return	The path to the xml file.
		 */
		private function get _xml_path() : String
		{
			return "models/" + StringUtil.toUnderscore( name ) + ".xml";
		}
	}
}
