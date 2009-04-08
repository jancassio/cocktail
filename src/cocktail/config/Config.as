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

package cocktail.config 
{
	import cocktail.Cocktail;
	import cocktail.core.Index;
	import cocktail.core.connectors.RequestConnector;
	import cocktail.core.connectors.request.RequestEvent;
	import cocktail.utils.Timeout;
	
	import swfaddress.SWFAddress;
	import swfaddress.SWFAddressEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.Capabilities;	

	/**
	 * Config class is the source holder for the application base config.	 * @author nybras | nybras@codeine.it	 */	public class Config extends Index
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _cocktail : Cocktail;
		
		private var _currentLocale : String;
		private var _defaultUrl : String;
		private var _appId : String;
		
		private var xml : XML;
		private var request : RequestConnector;
		private var dispatcher : EventDispatcher;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new Config instance.
		 * 
		 * @param _cocktail	Cocktail reference.
		 * @param appId	Application identifier (MUST be the the application folder name).
		 * @param defaultUrl	Application default url.
		 */
		public function Config ( _cocktail : Cocktail, appId: String, defaultUrl : String )
		{
			this._cocktail = _cocktail;
			this._cocktail.stage.stage.addEventListener( Event.RESIZE , onStageResize );
			
			dispatcher = new EventDispatcher();
			
			_defaultUrl = defaultUrl;
			_appId = appId;
			
			request = new RequestConnector();
			request.load( configPath, true ).listen( init );
			
			if ( pluginMode )
			{
				new Timeout( function() : void {
					SWFAddress.addEventListener( SWFAddressEvent.CHANGE, address_change );
				}, 5000 ).exec();
			}
		}
		
		/**
		 * Keep the configuration file contents.
		 * @param event	Request Event.
		 */
		private function init ( event : RequestEvent ) : void 
		{
			xml = new XML ( event.iLoadableFile.getData() );
			
			_cocktail.stage.scaleMode = movie ( "scaleMode" );
			_cocktail.stage.align = movie ( "align" );;
			_cocktail.stage.showDefaultContextMenu = ( movie ( "showMenu" ) == true );
			
			dispatcher.dispatchEvent( new Event ( Event.INIT ) );
		}
		
		/**
		 * Listens for url changes.
		 * @param event	SWFAdressEvent.
		 */
		public function address_change ( event : SWFAddressEvent ) : void
		{
			dispatcher.dispatchEvent( new Event( Event.CHANGE ) );
		}

		
		
		/* ---------------------------------------------------------------------
			ENVIORNMENT
		--------------------------------------------------------------------- */
		
		/**
		 * Gets the app id, use it to build the classpath's when dynamically instantiating classes.
		 * @return	The app id.
		 */
		public function get appId () : String
		{
			return _appId;
		}
		
		/**
		 * Gets the current external url location.
		 * @return	The current external url location.
		 */
		public function get location () : String
		{
			return SWFAddress.getValue();
		}
		
		/**
		 * Evaluates the path for the config file.
		 * @return	The path to the config file.
		 */
		private function get configPath () : String
		{
			return ( ( pluginMode ? "./" : "../" ) + "cocktail/config/config.fxml" );
		}
		
		/**
		 * Evaluates the document cache control for the given environment, if no environment is given, the default is used.
		 * @param environment	Environment name, if no environment name is given the default is used.
		 * @return	<code>true</code> if cache must be used, otherwise <code>false</code> if cache must not be used.
		 */
		public function cache ( environment : String = null ) : Boolean
		{
			environment = ( environment || xml..paths.@default );
			return ( xml..cache.@[ environment ] == "true" );
		}
		
		/**
		 * Evaluates the document root path for given environment, if no environment is given, the default is used.
		 * @param environment	Environment name, if no environment name is given the default is used.
		 * @return	The path for document root.
		 */
		public function root ( environment : String = null ) : String
		{
			environment = ( environment || xml..paths.@default );
			return xml..paths.path.( @name == environment ).@url;
		}
		
		/**
		 * Checks the player type.
		 * @return <code>true</code> if movie is inside a browser, <code>false</code> otherwise.
		 */
		public function get pluginMode () : Boolean
		{
			return ( "PlugInActiveX".indexOf( Capabilities.playerType ) != -1 );
		}
		
		/**
		 * Get the application default url.
		 * @return The application default url.
		 */
		public function get defaultUrl () : String
		{
			return _defaultUrl;
		}
		
		/**
		 * Evaluates the required path, based on the given extension.
		 * @param extension	File extension you want to evaluate the path.
		 */
		public function path ( extension : String ) : String
		{
			return root() + xml..path.( attribute( "ext" ) == extension ).@folder;
		}
		
		/**
		 * Evaluates the required gateway based on the given name.
		 * @param name	Gateway name you want to evaluate. If null, gets the default gateway.
		 * @return	The url for the required gatway.
		 */
		public function gateway ( name : String = null ) : String
		{
			if ( name == null ) name = xml..gateways.@default;
			return xml..gateway.( attribute( "name" ) == name ).@url;
		}
		
		
		
		/* ---------------------------------------------------------------------
			LOCALE
		--------------------------------------------------------------------- */
		
		/**
		 * Returns an array with all available locales.
		 * @return	The locales array.
		 */
		public function get locales ( ) : Array
		{
			var locales : Array;
			var locale : XML;
			
			locales = new Array();
			for each ( locale in xml..languages.* )
				locales.push( locale.localName() );
			
			return locales;
		}
		
		/**
		 * Returns the default locale.
		 * @return	Default locale.
		 */
		public function get defaultLocale ( ) : String
		{
			return xml..languages.@default;
		}
		
		/**
		 * Get the current locale.
		 * @return	The locales array.
		 */
		public function get current_locale ( ) : String
		{
			return _currentLocale;
		}
		
		/**
		 * Set the current locale.
		 * @return	The locales array.
		 */
		public function set current_locale ( locale : String ) : void
		{
			_currentLocale = locale;
		}
		
		
		
		/* ---------------------------------------------------------------------
			MOVIE / STAGE
		--------------------------------------------------------------------- */
		
		/*
		 * Listens Event.RESIZE on main stage.
		 */
		private function onStageResize ( event : Event ) : void
		{
			dispatcher.dispatchEvent( new Event( Event.RESIZE ) );
		}
		
		/**
		 * Get the gien property in xml, inside the movie config block.
		 * @return	The found property value.
		 */
		public function movie ( property : String ) : *
		{
			return xml..movie.@[ property ];
		}
		
		/**
		 * Get the default movie width.
		 * @return	The default movie width.
		 */
		public function get widthMovie () : uint
		{
			return movie ( "width" );
		}
		
		/**
		 * Get the default movie height.
		 * @return	The default movie height.
		 */
		public function get heightMovie () : uint
		{
			return movie ( "height" );
		}
		
		/**
		 * Get the current stage width.
		 * @return	The current stage width.
		 */
		public function get widthStage () : uint
		{
			return _cocktail.stage.stageWidth;
		}

		/**
		 * Get the current stage height.
		 * @return	The current stage width.
		 */
		public function get heightStage () : uint
		{
			return _cocktail.stage.stageHeight;
		}
		
		/**
		 * Calculates the difference between the original movie width and the current stage width.
		 * @return	The difference between movie and stage ( widthMovie - widthStage ).
		 */
		public function get widthShift () : Number
		{
			return ( ( widthMovie - widthStage ) / 2 );
		}
		
		/**
		 * Calculates the difference between the original movie height and the current stage height.
		 * @return	The difference between movie and stage ( widthMovie - widthStage ).
		 */
		public function get heightShift () : Number
		{
			return ( ( heightMovie - heightStage ) / 2 );
		}
		
		
		
		/* ---------------------------------------------------------------------
			LISTENER SHORTCUTS
		--------------------------------------------------------------------- */
		
		/**
		 * Start listening for SWFAddress URL changes.
		 * @param change	Change listener.
		 */
		public function listen_addressbar ( change : Function ) : void
		{
			dispatcher.addEventListener( Event.CHANGE , change );
		}
		
		/**
		 * Stop listening for SWFAddress URL changes.
		 * @param change	Change listener.
		 */
		public function unlisten_addressbar ( change : Function ) : void
		{
			dispatcher.removeEventListener( Event.CHANGE, change );
		}
		
		
		
		/**
		 * Start listening events.
		 * @param init	Init function listener.
		 * @param resize	resize fucntion listener.
		 */
		public function listen ( init : Function = null, resize : Function = null ) : void
		{
			if ( init != null ) dispatcher.addEventListener( Event.INIT , init );
			if ( resize != null ) dispatcher.addEventListener( Event.RESIZE , resize );
		}
		
		/**
		 * Stop listening events.
		 * @param init	Init function listener.
		 * @param resize	resize fucntion listener.
		 */
		public function unlisten ( init : Function = null, resize : Function = null ) : void
		{
			if ( init != null ) dispatcher.removeEventListener( Event.INIT , init );
			if ( resize != null ) dispatcher.removeEventListener( Event.RESIZE , resize );
		}  
	}}