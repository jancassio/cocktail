package cocktail.lib {
	import cocktail.lib.view.assets.AAsset;
	import cocktail.Cocktail;
	import cocktail.core.gunz.Gun;
	import cocktail.core.gunz.GunzGroup;
	import cocktail.core.process.Process;
	import cocktail.core.request.Request;
	import cocktail.core.slave.gunz.ASlaveBullet;
	import cocktail.core.slave.slaves.TextSlave;
	import cocktail.lib.gunz.LayoutBullet;
	import cocktail.lib.model.datasources.ADataSource;

	public class Layout extends View {
		/* GUNZ */
		public var gunz_render_complete : Gun;

		private function _init_gunz() : void {
			gunz_render_complete = new Gun(gunz, this, "render_complete");
		}

		/* INITIALIZING */
		
		/**
		 * 
		 */
		override public function boot( cocktail : Cocktail ) : * {
			var s : *;
		
			s = super.boot(cocktail);
			_init_gunz();
			
			return s;
		}

		/* LOAD */

		public function before_load( request : Request ) : Boolean {
			return true;
		}

		/**
		 * TODO: write docs
		 */
		public function load( request : Request ) : Boolean {
			log.info("Running...");
			
			if( !before_load( request ) ) return false;

			var i : int;
			var group : GunzGroup;
			var assets : Array;
			var asset : AAsset;
			
			if( ( assets = _parse_assets(request) ).length ) {
				group = new GunzGroup();
				do {
					asset = assets[ i ];
					group.add(asset.gunz_load_complete);
					asset.load();
				} while( i++ < assets.length );
			}
			
			return true;
		}
		
		/**
		 * Parses all necessary Datasources for given Process.
		 * @param process	Running process.
		 * @return	An array with all Datasources, properly instantiated. 
		 */
		private function _parse_assets( process : Request ) : Array {
			log.info("Running...");
			var i : int;
			var assets : Array;
			var node : XML;
			var action : String;
			var inject : String;
			var xml_nodes : XMLList;
			
			action = process.route.api.action;
			
			xml_nodes = _scheme[ "action" ].( @id == action || @id == "*" );
			
			if( !xml_nodes || !xml_nodes.children().length() ) return [];
			
			do {
				node = xml_nodes[ i ];
				assets.push( _instantiate_asset(node) );
			} while( i++ > _scheme.length() );
			
			return assets;
		}

		/**
		 * Instantiate the DataSource based on the given xml node.
		 * @param node	XML Scheme representation of the Datasource to be
		 * instantiated.
		 */
		private function _instantiate_asset( node : XML ) : AAsset
		{
			log.info( "Running..." );
			var ds : AAsset;
			
			ds = new ( _cocktail.factory.asset( node.@type ) )( );
			ds.boot( _cocktail );
			
			return ds;
		}
		
		/* LOADING, VALIDATING AND PARSING SCHEME */
		
		/**
		 * Load model scheme.
		 * @param process	Running process.
		 */
		public function load_scheme( process : Request ) : Layout {
			process;
			log.info("Running...");
			gunz_scheme_load_complete.shoot(new LayoutBullet());
			load_uri(_xml_path).gunz_complete.add(_after_load_scheme);
			return this;
		}

		/**
		 * Parsing model xml scheme.
		 * @param bullet	SlaveBullet.
		 */
		public function _after_load_scheme( bullet : ASlaveBullet ) : void {
			log.info("Running...");
			
			_scheme = new XML(TextSlave(bullet.owner).data);
			if( !_is_scheme_valid )
				log.fatal("The scheme in this file has errors." + _xml_path);
			else
				gunz_scheme_load_complete.shoot(new LayoutBullet());
		}

		/**
		 * Checks if the scheme is valid.
		 * @return	If shceme is valid, returns <code>true</code> otherwise
		 * return <code>false</code>.
		 */
		private function get _is_scheme_valid() : Boolean {
			log.info("Running...");
			// TODO: scheme needs to be validated against any inconsistence or
			//  problem cause that may exists
			return true;
		}

		public function render( process : Process ) : void {
			process;
		}

		/* GETTERS */

		/**
		 * Evaluates the path for the xml file.
		 * @return	The path to the xml file.
		 */
		private function get _xml_path() : String {
			log.info("Running...");
			var path : String;
			
			path = config.path(".xml") + "models/";
			path += classname.toLowerCase().replace("model", "") + ".xml";
			
			return path;
		}
	}
}