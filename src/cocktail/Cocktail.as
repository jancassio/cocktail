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

package cocktail 
{
	import cocktail.core.Config;
	import cocktail.core.EmbederTail;
	import cocktail.core.Index;
	import cocktail.core.Processes;
	import cocktail.core.Task;
	import cocktail.lib.Controller;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;	

	/**
	 * Cocktail class is the framework first class to be initialized. Its itended
	 * to be instantiated by your application main entry class (or your document
	 * class, if you like), and so the fun starts. :-)
	 * 
	 * @author nybras | nybras@codeine.it
	 * @see Index
	 * @see Router
	 */
	public class Cocktail extends Index
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		restricted var task : Task = new Task();
		
		private var _app_id : String;
		
		public var app : Sprite;
		public var sprite : Sprite;
		public var stage : Stage;
		public var root : DisplayObject;

		public var processes : Processes;
		
		private var _config : Config;
		
		private var _defaultUrl : String; 
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new Cocktail instance.
		 * @param app	The application reference.
		 * @param appId	Application identifier (MUST be the the application folder name).
		 * @param defaultUrl	Application default url.
		 * @param logLevel	Application default log level (default=5).
		 * 		<br/># 0=disable
		 * 		<br/># 1=fatal
		 * 		<br/># 2=fatal,error
		 * 		<br/># 3=fatal,error,debug
		 * 		<br/># 4=fatal,error,debug,warn
		 * 		<br/># 5=fatal,error,debug,warn,notice
		 * 		<br/># 6=fatal,error,debug,warn,notice,info
		 * @param logDetail	Application default log detail (default=1).
		 * 		<br/># 0=Doesnt add any extra prefix besides the log level.
		 * 		<br/># 1=Adds a prefix to all log calls, with the 'ClassName'
		 * 		<br/># 2=Adds a prefix to all log calls, with the 'packace.folderX.folderY.ClassName'.
		 */
		public function Cocktail( app : Sprite, embeder : EmbederTail, appId : String, defaultUrl : String, logLevel : uint = 5, logDetail : uint = 1 )
		{
			log.level ( logLevel );
			log.detail ( logDetail );
			log.info ( "Initializing cocktail with default url: " + defaultUrl );
			
			authorized = new Array( Processes, Controller );
			
			this.app = app;
			
			_defaultUrl = defaultUrl;
			_app_id = appId;
			
			sprite = new Sprite();
			
			if ( ! app.stage )
				app.addEventListener( Event.ADDED_TO_STAGE , boot );
			else
				boot ();
			
			//removing FDT warning
			embeder;
		}
		
		/**
		 * Boot the cocktail.
		 * @param event	Event.ADDED_TO_STAGE.
		 */
		public function boot ( event : Event = null ) : void
		{
			if ( event != null )
				app.removeEventListener( Event.ADDED_TO_STAGE , boot );
			
			stage = app.stage;
			root = app.root;
			
			app.addChild( this.sprite );
			
			_config = new Config( this , _app_id , _defaultUrl );
			_config.listen( this.init );
			
			processes = new Processes( this );
		}
		
		
		/**
		 * Listen Config for Event.INIT.
		 * @param event	Event.
		 */
		private function init ( event : Event ) : void
		{
			cacheConfig( _config );
			processes.init();
		}
		
		
		
		/* ---------------------------------------------------------------------
			ROUTING APPLICATION
		--------------------------------------------------------------------- */
		
		/**
		 * Redirects the application to the given url.
		 * @param url	Target location to redirect the application to.
		 * @param silentMode	If <code>true</code>, reflects the url in the address bar, otherwise <code>false</code> keeps the adress bar as it is.
		 */
		final public function redirect( url : String, silentMode : Boolean = false, freeze : Boolean = false ) : void
		{
			log.info ( "Redirecting to: "+ url );
			this.processes.run( url, silentMode, freeze );
		}
		
		/**
		 * Reboot the current view ( destroy all and render again )
		 */
		public function reboot () : void
		{
			processes.reboot();
		}
		
	}
}