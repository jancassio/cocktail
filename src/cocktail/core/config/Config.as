package cocktail.core.config
{
	import cocktail.Cocktail;
	import cocktail.core.Index;

	import com.asual.swfaddress.SWFAddress;

	import flash.display.Stage;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Capabilities;

	/**
	 * Config class is the source holder for the application base config.
	 * @author nybras | nybras@codeine.it
	 * @author hems | hems@henriquematias.com
	 */
	public class Config extends Index
	{
		/* VARS */
		private var _raw : XML;

		private var _current_locale : String;

		private var _xml_loader : URLLoader;

		/* BOOTING */
		
		/**
		 * Creates a new Config instance.
		 * @param cocktail	Cocktail reference.
		 */
		override public function boot( cocktail : Cocktail ) : *
		{
			var s : *;
		
			s = super.boot( cocktail );
			
			_cocktail = cocktail;
			
			_load();
			
			return s;
		}

		private function _load(): void
		{
			/*
			PIMP: Replace with core loading || slave
			 */
			 
			_xml_loader = new URLLoader( );
			_xml_loader.addEventListener( Event.COMPLETE, _xml_loaded );
			_xml_loader.load( new URLRequest( _xml_path ) );			
		}
		
		/**
		 * Called by _xml_loader's complete event
		 * Keep the configuration file contents.
		 */
		private function _xml_loaded( event : Event ) : void 
		{
			_raw = new XML( String( _xml_loader.data ) );
			
			_init_stage();
			
			_init_router();
		}

		private function _init_stage(): void
		{
			var stage : Stage;
			
			stage = _cocktail.app.stage;
			stage.scaleMode = _movie( "scaleMode" );
			stage.align = _movie( "align" );
			stage.showDefaultContextMenu = ( _movie( "showMenu" ) == true );
		}
		
		private function _init_router(): void
		{
			var route : XML;
			
			for each( route in _raw..route )
				routes.map( route.@mask, route.@target );
			
			router.init( );
		}
		
		/* ENVIORNMENT */
		
		/**
		 * Gets the app id, use it to build the classpath's when dynamically
		 * instantiating classes.
		 * @return	The app id.
		 */
		public function get app_id() : String
		{
			return _cocktail.app_id;
		}

		/**
		 * Gets the current external url location.
		 * @return	The current external url location.
		 */
		public function get location() : String
		{
			return SWFAddress.getValue( );
		}

		/**
		 * Evaluates the path for the config file.
		 * @return	The path to the config file.
		 */
		private function get _xml_path() : String
		{
			return	( (	is_in_browser ? "" : "." ) + "./cocktail/config/config.xml" + "?v=" + Math.random( )
					);
		}

		/**
		 * Evaluates the document cache control for the given environment,
		 * if no environment is given, the default is used.
		 * @param environment	Environment name, if no environment name is
		 * given the default is used.
		 * @return	<code>true</code> if cache must be used, otherwise
		 * <code>false</code> if cache must not be used.
		 */
		public function cache( environment : String = null ) : Boolean
		{
			environment = ( environment || _raw..paths.@default );
			return( _raw..cache.@[ environment ] == "true" );
		}

		/**
		 * Evaluates the document root path for given environment, if no
		 * environment is given, the default is used.
		 * @param environment	Environment name, if no environment name is
		 * given the default is used.
		 * @return	The path for document root.
		 */
		public function root( environment : String = null ) : String
		{
			environment = ( environment || _raw..paths.@default );
			return _raw..paths.path.( @name == environment ).@url;
		}

		/**
		 * Checks the player type.
		 * @return <code>true</code> if movie is inside a browser,
		 * <code>false</code> otherwise.
		 */
		public function get is_in_browser() : Boolean
		{
			return( "PlugInActiveX".indexOf( Capabilities.playerType ) != -1 );
		}

		/**
		 * Get the application default URI.
		 * @return The application default URI.
		 */
		public function get default_uri() : String
		{
			return _cocktail.default_uri;
		}

		/**
		 * Evaluates the required path, based on the given extension.
		 * @param extension	File extension you want to evaluate the path.
		 */
		public function path( extension : String ) : String
		{
			return	root( ) + _raw..path.( attribute( "ext" ) == extension ).@folder;
		}

		/**
		 * Evaluates the required gateway based on the given name.
		 * @param name	Gateway name you want to evaluate. If null, gets the
		 * default gateway.
		 * @return	The url for the required gatway.
		 */
		public function gateway( name : String = null ) : String
		{
			if( name == null ) name = _raw..gateways.@default;
			return _raw..gateway.( attribute( "name" ) == name ).@url;
		}

		/* LOCALE */
		
		/**
		 * Returns an array with all available locales.
		 * @return	The locales array.
		 */
		public function get locales( ) : Array
		{
			var locales : Array;
			var locale : XML;
			
			locales = new Array( );
			for each( locale in _raw..languages.* )
				locales.push( locale.localName( ) );
			
			return locales;
		}

		/**
		 * Returns the default locale.
		 * @return	Default locale.
		 */
		public function get default_locale( ) : String
		{
			return _raw..languages.@default;
		}

		/**
		 * Get the current locale.
		 * @return	The locales array.
		 */
		public function get current_locale( ) : String
		{
			return _current_locale;
		}

		/**
		 * Set the current locale.
		 * @return	The locales array.
		 */
		public function set current_locale( locale : String ) : void
		{
			_current_locale = locale;
		}

		/* MOVIE / STAGE */
		
		/**
		 * Get the gien property in xml, inside the movie config block.
		 * @return	The found property value.
		 */
		private function _movie( property : String ) : *
		{
			return _raw..movie.@[ property ];
		}

		/**
		 * Get the default movie width.
		 * @return	The default movie width.
		 */
		public function get width_movie() : uint
		{
			return _movie( "width" );
		}

		/**
		 * Get the default movie height.
		 * @return	The default movie height.
		 */
		public function get height_movie() : uint
		{
			return _movie( "height" );
		}

		/**
		 * Get the current stage width.
		 * @return	The current stage width.
		 */
		public function get width_stage() : uint
		{
			return _cocktail.app.stage.stageWidth;
		}

		/**
		 * Get the current stage height.
		 * @return	The current stage width.
		 */
		public function get height_stage() : uint
		{
			return _cocktail.app.stage.stageHeight;
		}
	}
}