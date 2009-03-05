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

package cocktail.lib {
	import cocktail.core.Index;	import cocktail.core.Task;	import cocktail.core.connectors.RequestConnector;	import cocktail.core.connectors.request.RequestEvent;	import cocktail.core.connectors.request.RequestKeeper;	import cocktail.core.data.bind.Bind;	import cocktail.core.data.dao.ProcessDAO;	import cocktail.core.data.dao.model.ModelActionDAO;	import cocktail.core.data.so.SO;	import cocktail.lib.Controller;	import cocktail.lib.model.datasources.interfaces.IDataSource;	import cocktail.utils.ArrayUtil;	import cocktail.utils.StringUtil;		import flash.events.Event;		/**
	 * Main cocktail Model class.
	 * 
	 * This is the base class for every single Model you have in your application.
	 * 
	 * @author nybras | nybras@codeine.it
	 * @see Index
	 * @see Cocktail
	 * @see Controller
	 * @see Model
	 */
	public class Model extends Index
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _queue : RequestConnector;
		private var _queueing : Boolean;
		
		private var buffer_ds : Array;
		
		protected var ctrl : Controller;
		
		protected var current_process : ProcessDAO;
		protected var active_process : Array;
		protected var dead_process : ProcessDAO;
		
		protected var bind : Bind;
		protected var task : Task;
		protected var request : RequestConnector;
		
		public var structure : XML;
		
		protected var so : SO;
		protected var actions : Array;
		
		public var cached : Boolean;
		public var booted : Boolean;
		
		
				/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new Model instance.
		 */
		public function Model (){}
		
		
		
		/**
		 * Run the Model according the cocktail strict flow.
		 * @param ctrl	Area controller.
		 */
		internal function boot ( ctrl : Controller ) : void
		{
			so = new SO ( class_path );
			
			this.ctrl = ctrl;
			task = ctrl.task;
			bind = ctrl.bind;
			request = ctrl.request;
			
			active_process = new Array();
			actions = new Array( );
			
			url( xmlPath ).listen( cache );
		}
		
		
		
		/* ---------------------------------------------------------------------
			ACTION's RUN & DESTROY
		--------------------------------------------------------------------- */
		
		/**
		 * Run the given action.
		 * @param dao	The action ( in ProcessDAO format ) to be runned.
		 */
		internal function run ( dao : ProcessDAO ) : void
		{
			active_process.push( current_process = dao );
			task.done( class_path +"/run" );
		}
		
		/**
		 * Destroy the given action.
		 * @param dao	The action ( in ProcessDAO format ) to be destroyed.
		 */
		internal function destroy ( dao : ProcessDAO ) : void
		{
			ArrayUtil.del( active_process , ( dead_process = dao ) );
			task.done( class_path +"/destroy" );
			$destroy();
		}
		
		
		
		/* ---------------------------------------------------------------------
			URL REQUESTS
		--------------------------------------------------------------------- */
		
		/**
		 * Open or close a queue and return it.
		 * @param opening	if <code>true</code> open a new queue, otherwise <code>false</code> close the opened queue.
		 * @return	The opened or closed queue.
		 */
		protected function queue ( opening : Boolean ) : RequestConnector
		{
			if ( _queueing = opening ) {
				_queue = new RequestConnector( );
			}
			
			return _queue;
		}

		/**
		 * Request the given url through the queue (if openen) or directly (if closed).
		 * 
		 * @param url	The url adress to be requested.
		 * @param autoLoad	If <code>true</code>, loading process starts automatically.
		 */
		protected function url ( url : String, autoLoad : Boolean = true ) : RequestKeeper
		{
			if ( this._queueing ) {
				return this._queue.load( url, autoLoad );
			} else {
				return new RequestConnector().load(url, autoLoad);
			}
		}
		
		
		
		/* ---------------------------------------------------------------------
			NOMENCLATURE HANDLERs
		--------------------------------------------------------------------- */
		
		protected function get clean_class_name () : String
		{
			return class_name.replace( "Model", "" );
		}
		
		
		
		/* ---------------------------------------------------------------------
			ACTION & DATASOURCE HANDLERs
		--------------------------------------------------------------------- */
		
		/**
		 * Returns the found action, based on the given name. If no action is found, fires a FATAL message.
		 * @param name	Action name you want to search for.
		 */
		public function action ( name : String = null ) : ModelActionDAO
		{
			var action : ModelActionDAO;
			var output : ModelActionDAO;
			
			name = ( name || current_process.action );
			
			for each ( action in actions )
				if ( action.name == name )
					output = action;
			
			return output;
			
			log.fatal( "Action '"+ name +"' not found in : "+ xmlPath );
		}
		
		/**
		 * Return all datasources for the given action.
		 * @param action	Datasources parent action. If <code>null</code>, uses the current action.
		 */
		public function datasources ( action : String = null ) : Array
		{
			var actionDao : ModelActionDAO;
			
			action = ( action || current_process.action );
			
			for each ( actionDao in actions )
				if ( actionDao.name == action )
					return  actionDao.datasources;
			
			log.warn( "Action '"+ action +"' not found in : "+ xmlPath );
			
			return null;
		}
		
		/**
		 * Return the datasource according the given id, and action name.
		 * @param id	Datasource id, to search.
		 * @param action Datasource parent action. If <code>null</code>, uses the current action.
		 */
		public function datasource ( id : String, action : String = null ) : IDataSource
		{
			var datasource : IDataSource;
			
			action = ( action || current_process.action );
			
			for each ( datasource in datasources( action ) )
				if ( datasource.id == id && datasource.locale == config.currentLocale )
					return  datasource;
			
			log.fatal( "Datasource '"+ id +"' not found in : "+ xmlPath );
			
			return null;
		}
		
		 
		
		/* ---------------------------------------------------------------------
			XML MODEL CACHING & INSTANTIATION
		--------------------------------------------------------------------- */
		
		/**
		 * Evaluates the path for the xml file.
		 * @return	The path to the xml file.
		 */
		public function get xmlPath () : String
		{
			return ( config.path( ".xml" ) + "models/" + clean_class_name.toLowerCase( ) ) + ".xml";
		}

		
		
		/**
		 * Caches the xml file, parsing all items.
		 * @param event	Request Event.
		 */
		private function cache ( event : RequestEvent ) : void
		{
			log.info( "cache();" );
			
			booted = true;
			structure = new XML( event.iLoadableFile.getData( ) );
			
			if ( validate() )
			{
				task.done( class_path + "/boot" );
				cached = true;
			}
		}
		
		/**
		 * Validates the layout structure.
		 */
		private function validate () : Boolean
		{
			// TODO - validate layout structure ( duplicated ids etc )
			return true;
		}
		
		/**
		 * Caches the model actions.
		 * @param source	The pre processed source to be cached.
		 */
		public function cache_action ( source : XML ) : void
		{
			log.info( "cache_actions();" );
			
			var actionDao : ModelActionDAO;
			
			ArrayUtil.del( actions, source.@name, "name" );
			actions.push( actionDao = new ModelActionDAO( source.@name ) );
			cache_datasources( actionDao.datasources , source.children( ) );
		}
		
		/**
		 * Cache datasources.
		 * @param buffer	Buffer to cache into.	
		 * @param doc	Document node to cached.	
		 */
		private function cache_datasources ( buffer : Array, doc : XMLList ) : void
		{
			log.info( "cache_datasources();" );
			
			var node : XML;
			var datasourceClass : Class;
			var datasourceType : String;
			var datasource : IDataSource;
			
			for each ( node in doc )
			{
								datasourceType = StringUtil.ucasef( node.@type );
				datasourceClass = get_class( "cocktail.lib.model.datasources." + datasourceType + "DataSource" );
				
				datasource = new datasourceClass();
				datasource.boot( this , bind, node, request );
				
				buffer.push( datasource );
			}
		}
		
		
		
		/* ---------------------------------------------------------------------
			INIT SEQUENCE EXECUTION
		--------------------------------------------------------------------- */
		
		/**
		 * 
		 */
		internal final function $before_init () : void
		{
			log.info( "$before_init();");
			try { this[ "before_init" ](); } catch ( e : Error ) {};
			$after_init();
		}
		
		/**
		 * 
		 */
		internal final function $init () : void
		{
			$before_init();
		}
		
		/**
		 * 
		 */
		internal final function $after_init () : void
		{
			log.info( "$after_init();");			task.done( class_path +"/$after_init" );
			try { this[ "after_init" ](); } catch ( e : Error ) {};
		}
		
		
		
		/* ---------------------------------------------------------------------
			LOAD SEQUENCE EXECUTION
		--------------------------------------------------------------------- */
			
		/**
		 * 
		 */
		internal final function $before_load () : void
		{
			log.info( "$before_load();" );
			buffer_ds = new Array();
			
			try { this[ "before_load" ](); } catch ( e : Error ) { /* log.warn(e.message); */ }			
		}
		
		/**
		 * 
		 */
		internal final function $load () : void
		{
			var ds : IDataSource;
			
			$before_load();
			
			if ( ! datasources() || ! datasources().length )
				$after_load();
			else
			{
				for each ( ds in datasources() )
					if ( ds.locale == config.currentLocale || ds.locale == "*" )
						buffer_ds.push( ds );
				
				load_datasources();
			}
		}		
		/**
		 * 
		 */
		private function load_datasources () : void
		{
			buffer_ds.shift().load().listen( $datasource_loaded );
		}
		
		/**
		 * 
		 */		private function $datasource_loaded ( event : Event ) : void
		{
			if ( ! buffer_ds.length )
				$after_load();
			else 
				load_datasources();
		}
								/**
		 * 
		 */
		internal final function $after_load () : void
		{
			log.info( "$after_load();");
			try { this[ "after_load" ](); } catch ( e : Error ) {};
			task.done( class_path +"/$after_load" );
		}
		
		
		
		/* ---------------------------------------------------------------------
			DESTROY SEQUENCE EXECUTION
		--------------------------------------------------------------------- */
		
		internal function $before_destroy () : void
		{
			log.info( "$before_destroy();" );
			
			try {
				this[ "before_destroy" ](); 
			} catch ( e1 : Error ) {};
		}
		
		internal function $destroy () : void
		{
			log.info( "$destroy();" );
			
			$before_destroy();
			
			// TODO - implement method
			
			$after_destroy();
		}
		
		internal function $after_destroy () : void
		{
			log.info( "$after_destroy();" );
		}
	}
}