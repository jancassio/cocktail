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
	import cocktail.core.config.Config;
	import cocktail.core.embedder.EmbedderTail;
	import cocktail.core.processes.Processes;
	import cocktail.core.router.Router;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;	
	
	/**
	 * Cocktail class is the framework first class to be initialized. It's
	 * itended to be instantiated by your application main entry class (or your
	 * document class, if you like), and so the fun starts. :-)
	 * @author nybras | nybras@codeine.it
	 */
	public class Cocktail
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _app : Sprite;
		private var _app_id : String;
		
		private var _embedder : EmbedderTail;
		private var _default_url : String; 
		
		private var _config : Config;
		private var _router : Router;
		private var _processes : Processes;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new Cocktail instance.
		 * @param app	The application reference (document_class:Sprite).
		 * @param app_id Application identifier (MUST be the the application
		 * folder name).
		 * @param embedder	Application embedder.
		 * @param default_url	Application default url.
		 */
		public function Cocktail(
			app : Sprite,
			app_id : String,
			embedder : EmbedderTail,
			default_url : String = null
		)
		{
			_app = app;
			_app_id = app_id;
			
			_embedder = embedder;
			_default_url = default_url;
			
			if( ! _app.stage )
				_app.addEventListener( Event.ADDED_TO_STAGE, _init );
			else
				_init ();
		}
		
		/**
		 * Initializes the cocktail.
		 * @param event	Event.ADDED_TO_STAGE.
		 */
		public function _init ( event : Event = null ) : void
		{
			if ( event != null )
				_app.removeEventListener( Event.ADDED_TO_STAGE , _init );
			
			_config = new Config( this, _app_id, _default_url );
			_router = new Router( this );
			_processes = new Processes( this );
		}
		
		
		
		/* ---------------------------------------------------------------------
			GENERAL GETTERS
		--------------------------------------------------------------------- */
		
		/**
		 * Get the reference for the app (document_class:Sprite) instance.
		 * @param	Reference to the app instance.
		 */
		public function get app () : Sprite
		{
			return _app;
		}
		
		/**
		 * Get the reference for the Config instance.
		 * @param	Reference to the Config instance.
		 */
		public function get config () : Config
		{
			return _config;
		}
		
		/**
		 * Get the reference for the Router instance.
		 * @param	Reference to the router instance.
		 */
		public function get router () : Router
		{
			return _router;
		}
		
		/**
		 * Get the reference for the Processes instance.
		 * @param	Reference to the processes instance.
		 */
		public function get processes () : Processes
		{
			return _processes;
		}
	}
}