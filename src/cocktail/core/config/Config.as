/*	****************************************************************************
		Cocktail ActionScript Full Stack Framework. Copyright (C) 2009 Codeine.
	****************************************************************************
   
		This library is free software; you can redistribute it and/or modify
	it under the terms of the GNU Lesser General Public License as published
	by the Free Software Foundation; either version 2.1 of the License, or
	(at your option) any later version.
		
		This library is distributed in the hope that it will be useful, but
	WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
	or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public
	License for more details.

		You should have received a copy of the GNU Lesser General Public License
	along with this library; if not, write to the Free Software Foundation,
	Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

	-------------------------
		Codeine
		http://codeine.it
		contact@codeine.it
	-------------------------
	
*******************************************************************************/

package cocktail.core.config
{
	import cocktail.Cocktail;
	import cocktail.core.Index;
	
	import swfaddress.SWFAddress;
	
	import flash.display.Stage;
	import flash.system.Capabilities;	
	
	/**
	 * Config class is the source holder for the application base config.
	 * @author nybras | nybras@codeine.it
	 */
	public class Config extends Index
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _cocktail : Cocktail;
		private var _raw : XML;
		
		private var _current_locale : String;
		private var _default_url : String;
		private var _app_id : String;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new Config instance.
		 * 
		 * @param cocktail	Cocktail reference.
		 * @param app_id	Application identifier(MUST be the the application
		 * folder name).
		 * @param default_url	Application default url.
		 */
		public function Config(
			cocktail : Cocktail,
			app_id: String,
			default_url : String
		)
		{
			_cocktail = cocktail;
			_default_url = default_url;
			_app_id = app_id;
			
			/*
		 		TODO: IMPLEMENT ALL THE LOADING PROCESS W/ GUNZ, calling "_init)
		 			  method to initialize everything.
		 				
		 			  ie.: load( _config_path ).listen( _init );
		 	*/
		}
		
		
		
		/* ---------------------------------------------------------------------
			LOADING
		--------------------------------------------------------------------- */
		
		/**
		 * Keep the configuration file contents.
		 * @param TODO: write documentation
		 */
		private function _init( ...probably_an_event ) : void 
		{
			var stage : Stage;
			
			_raw = new XML( /* TODO: get the loaded xml raw */ );
			
			stage = _cocktail.app.stage;
			stage.scaleMode = _movie( "scaleMode" );
			stage.align = _movie( "align" );;
			stage.showDefaultContextMenu =( _movie( "showMenu" ) == true );
		}
		
		
		
		/* ---------------------------------------------------------------------
			ENVIORNMENT
		--------------------------------------------------------------------- */
		
		/**
		 * Gets the app id, use it to build the classpath's when dynamically
		 * instantiating classes.
		 * @return	The app id.
		 */
		public function get app_id() : String
		{
			return _app_id;
		}
		
		/**
		 * Gets the current external url location.
		 * @return	The current external url location.
		 */
		public function get location() : String
		{
			return SWFAddress.getValue();
		}
		
		/**
		 * Evaluates the path for the config file.
		 * @return	The path to the config file.
		 */
		private function get _config_path() : String
		{
			return	(( plugin ? "./" : "../" )
					+ "cocktail/config/config.fxml" );
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
			environment =( environment || _raw..paths.@default );
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
			environment =( environment || _raw..paths.@default );
			return _raw..paths.path.( @name == environment ).@url;
		}
		
		/**
		 * Checks the player type.
		 * @return <code>true</code> if movie is inside a browser,
		 * <code>false</code> otherwise.
		 */
		public function get plugin() : Boolean
		{
			return( "PlugInActiveX".indexOf( Capabilities.playerType ) != -1 );
		}
		
		/**
		 * Get the application default url.
		 * @return The application default url.
		 */
		public function get default_url() : String
		{
			return _default_url;
		}
		
		/**
		 * Evaluates the required path, based on the given extension.
		 * @param extension	File extension you want to evaluate the path.
		 */
		public function path( extension : String ) : String
		{
			return	root() +
					_raw..path.( attribute( "ext" ) == extension ).@folder;
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
		
		
		
		/* ---------------------------------------------------------------------
			LOCALE
		--------------------------------------------------------------------- */
		
		/**
		 * Returns an array with all available locales.
		 * @return	The locales array.
		 */
		public function get locales( ) : Array
		{
			var locales : Array;
			var locale : XML;
			
			locales = new Array();
			for each( locale in _raw..languages.* )
				locales.push( locale.localName() );
			
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
		
		
		
		/* ---------------------------------------------------------------------
			MOVIE / STAGE
		--------------------------------------------------------------------- */
		
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