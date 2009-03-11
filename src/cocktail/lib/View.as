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
	import cocktail.core.Index;	import cocktail.core.Task;	import cocktail.core.connectors.MotionConnector;	import cocktail.core.connectors.RequestConnector;	import cocktail.core.connectors.request.RequestEvent;	import cocktail.core.connectors.request.RequestKeeper;	import cocktail.core.data.bind.Bind;	import cocktail.core.data.dao.ProcessDAO;	import cocktail.core.data.dao.layout.LayoutActionDAO;	import cocktail.core.data.dao.layout.LayoutItemDAO;	import cocktail.core.data.dao.style.StyleDAO;	import cocktail.core.status.Status;	import cocktail.lib.Controller;	import cocktail.utils.ArrayUtil;	import cocktail.utils.StringUtil;	import cocktail.utils.Timeout;		import flash.display.DisplayObject;	import flash.display.Loader;	import flash.display.Sprite;	import flash.events.Event;		/**	 * Main cocktail View class.	 * 
	 * This is the base class for every single View you have in your application.
	 * 
	 * @author nybras | nybras@codeine.it
	 * @see Index
	 * @see Cocktail
	 * @see Controller
	 * @see Model
	 */
	public class View extends Index
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
				private var _up : View;
		private var _prev : View;
				private var _queue : RequestConnector;
		private var _queueing : Boolean;
				private var _childs : Object;
		
		private var task : Task;
		protected var bind : Bind;
		
		private var _runned : Boolean;
		
		public var info : LayoutItemDAO;
				public var preloader : PreloaderElementTail;		public var use_preloader : Boolean;				public var current_process : ProcessDAO;
		public var dead_processes : Array;
		public var active_processes : Array;
		
		public var holder : DisplayObject;
		public var loader : Loader;		
		public var sprite : Sprite = new Sprite( );
		public var ctrl : Controller;
				public var structure : XML;		
		protected var styles : Array;
		protected var actions : Array;
				protected var request : RequestConnector;
		protected var loadSchema : Boolean;
				public const motion : MotionConnector = new MotionConnector( sprite ); 
				public var cached : Boolean;		public var booted : Boolean;
				protected var status : String;		
				
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new View instance.
		 */
		public function View ()		{			use_preloader = true;		}
				/**
		 * Boot the View according the cocktail strict flow.
		 * @param ctrl	Area controller.
		 * @param forceLayout	Forces the layout loading process.
		 */
		internal function boot ( ctrl : Controller, loadSchema : Boolean = false ) : void
		{			_childs = new Object();
			active_processes = new Array ();
			dead_processes = new Array ();
			
			styles = ( styles ? styles : new Array( ) );
			actions = new Array( );
			
			this.ctrl = ctrl;			this.loadSchema = loadSchema;
			
			task = ctrl.task;			bind = ctrl.bind;
			request = ctrl.request;
						if ( up == null ) {				ctrl.stage.addChild( sprite );
			} else {
				up.sprite.addChild( sprite );
			}
			
			if ( loadSchema )				url( xmlPath ).listen( cache );						config.listen( null, onStageResize );
		}
								/* ---------------------------------------------------------------------			STATUS MODIFIERS		--------------------------------------------------------------------- */				/**		 * Mark controller execution status as <code>initializing</code>		 */		private function $initializing () : void		{			status = Status.INITIALIZING;		}				/**		 * Mark controller execution status as <code>loading</code>		 */		private function $loading () : void		{			status = Status.LOADING;		}				/**		 * Mark controller execution status as <code>rendering</code>		 */		private function $rendering () : void		{			status = Status.RENDERING;		}		/**		 * Mark controller execution status as <code>render_done</code>		 */		private function $render_done () : void		{			status = Status.RENDER_DONE;		}				/**		 * Mark controller execution status as <code>destroying</code>		 */		private function $destroying () : void		{			status = Status.DESTROYING;		}				/**		 * Mark controller execution status as <code>destroy_done</code>		 */		private function $destroy_done () : void		{			status = Status.DESTROY_DONE;		}								/* ---------------------------------------------------------------------			STAGE BEHAVIORS		--------------------------------------------------------------------- */				/**		 * Listens for Event.RESIZE @ stage, and try to refresh the view.			 * @param event	Event.RESIZE.		 */		private function onStageResize ( event : Event = null ) : void		{			try { this[ "realign" ](); } catch ( e : Error ) {};		}		
		
		
		/* ---------------------------------------------------------------------
			FACTORY		--------------------------------------------------------------------- */				/**		 * Creates a new View based on the given xml node.		 * @param node	View xml representation.		 * @return	The given xml structure as a View.		 */		public function create ( node : XML ) : View		{			var view : View;			var viewName : String;			var viewClass : Class;						var daoName : String;			var daoClass : Class;			var daoItem : LayoutItemDAO;						var cocktail_elements : String;			var app_elements : String;			var app_area : String;						cocktail_elements = "cocktail.lib.view.elements.$Element";			app_elements = config.appId +".views.elements.$Element";			app_area = config.appId +".views." + current_process.area_name + ".$View";						daoName = node.localName() as String;							if ( daoName == "module" )				daoName = "Item";			else				daoName = StringUtil.ucasef( daoName );						daoClass = get_class( "cocktail.core.data.dao.layout.Layout" + daoName + "DAO" );						daoItem = new daoClass();			daoItem.boot ( this, bind, node );									switch ( daoItem.category )			{				case "module":					if ( StringUtil.outerb ( daoItem.classname ) == "[]" )							viewClass = get_class( StringUtil.innerb( daoItem.classname ));						else							if ( ! daoItem.shared )								viewClass = get_class( app_area.replace( "$" , daoItem.classname ) );							else								viewClass = get_class( app_elements.replace( "$" , daoItem.classname ) );				break;								default: 					// text|img|swf|button|div|					viewName = StringUtil.ucasef( daoItem.category );					try {						viewClass = get_class( app_elements.replace( "$" , viewName ) );					} catch ( e1 : Error ) {						viewClass = get_class( cocktail_elements.replace( "$" , viewName ) );					}				break;			}						view = new viewClass ();			view.info = daoItem;			view.styles = styles;						view.info.plugBinds();						return view;		}						
		/* ---------------------------------------------------------------------
			ACTION's RUN & DESTROY
		--------------------------------------------------------------------- */
		
		/**
		 * Run the given action.
		 * @param dao	The action ( in ProcessDAO format ) to be runned.
		 */
		internal function run ( dao : ProcessDAO ) : void
		{			if ( ! _runned )
			{
				_runned = true; 
				if ( up == null ) {
					ctrl.stage.addChild( sprite );
				} else {
					up.sprite.addChild( sprite );
				}
			}
			
			active_processes.push( current_process = dao );			task.done( class_path + "/run" );
		}
		
		/**
		 * Destroy the given action.
		 * @param dao	The action ( in ProcessDATxtO format ) to be destroyed.		 */
		public function destroy ( dao : ProcessDAO ) : void		{			var item : View;
			
			dead_processes.push ( dao );
			
			for each ( item in childs( dao.action ) ) {
				item.destroy( dao );
			}
			
			$destroy( dao );
		}
				
				/* ---------------------------------------------------------------------
			UP & NEXT shortcuts
		--------------------------------------------------------------------- */
		
		/**
		 * Sets the view parent.
		 * @param parent	The view parent's view. :)
		 */
		public function set up ( target : View ) : void 
		{
			this._up = target;
		}
		/**
		 * Gets the view parent.
		 * @return	The view parent's view.
		 */
		public function get up () : View
		{
			return this._up;
		}
						/**
		 * Sets the view parent.
		 * @param parent	The view parent's view. :)
		 */
		public function set prev ( target : View ) : void 
		{
			this._prev = target;
		}
		/**
		 * Gets the view parent.
		 * @return	The view parent's view.
		 */
		public function get prev () : View
		{
			return this._prev;
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
			if ( this._queueing = opening ) {
				this._queue = new RequestConnector( );
			}
			
			return this._queue;
		}
				/**
		 * Request the given url through the queue (if openen) or directly (if closed).
		 * 
		 * @param url	The url adress to be requested.
		 * @param autoLoad	If <code>true</code>, loading process starts automatically.
		 */
		protected function url ( url : String, autoLoad : Boolean = true ) : RequestKeeper
		{			if ( this._queueing )				return this._queue.load( url, autoLoad );
			else
				return new RequestConnector().load( url, autoLoad );		}
								/* ---------------------------------------------------------------------
			NAVIGATION & LOCALE HANDLERS
		--------------------------------------------------------------------- */
		
		/**
		 * Redirects the application to the given url.
		 * @param url	Target location to redirect the application to.
		 * @param silentMode	If <code>true</code>, reflects the url in the address bar, otherwise <code>false</code> keeps the adress bar as it is.
		 */
		final public function redirect ( url : String, silentMode : Boolean = false, freeze : Boolean = false ) : void
		{
			this.ctrl.redirect( url , silentMode, freeze );
		}
		
		/**		 * Change the current locale string for I18n.		 * @param locale	The string locale to use.		 */
		final public function switchLocale ( locale : String ) : void
		{			this.ctrl.switchLocale( locale );
		}								/* ---------------------------------------------------------------------
			NOMENCLATURE HANDLERs
		--------------------------------------------------------------------- */
		
		/**
		 * Cleans up the class name, removing the "View" sufix.
		 * @return	The class name without the "View" sufix.
		 */
		final public function get clean_class_name () : String
		{
			return class_name.replace( "View" , "" );
		}
						/* ---------------------------------------------------------------------
			LAYOUT handlers ( actions, childs, styles )
		--------------------------------------------------------------------- */
		
		/**
		 * Search for the style based on the given id.
		 * @param id	The style id to search for.
		 * @return	The found style or null if no style is found
		 */
		private function $action ( name : String ) : LayoutActionDAO
		{
			for each ( var item : LayoutActionDAO in actions )
				if ( item.name == name )					return item;
			
			return null;
		}
		
		/**
		 * Adds a child to the stack.
		 * @param child	The child to be added.
		 * @param head	If <code>true</code> adds the childs before all current childs, otherwise <code>true</code> adds the child after all current childs. 
		 * @param action	Action to add the child to, if no action is given the child is added to the current action stack.
		 */
		public function addChild ( child : View, head : Boolean = false, action : String = null ) : View
		{
			var target : Array;						action = ( action || current_process.action );						try {				_childs[ action ].length;			}			catch ( e : Error )			{				_childs[ action ] = [];			}						target = _childs[ action ];						child.up = this;			child.prev = ( head ? null : ( ( target.length ? target[ target.length - 1 ] : null ) ) );			child.current_process = current_process;						if ( head )			{				if ( target.length )
					target[ 0 ].prev = child;								target.unshift( child );			}				else				target.push( child );						child.boot( ctrl );						if ( status == Status.RENDER_DONE || status == Status.RENDERING )//				child.$load();
				child.$render();						return child;		}
		
		/**
		 * 
		 */
		public function removeChild ( view : View ) : void
		{
			// 
		}
		
		
				/**
		 * Search for the style based on the given id.
		 * @param id	The style id to search for.
		 * @return	The found style or null if no style is found
		 */
		public function style ( id : String = null ) : StyleDAO
		{
			var instance : Class;			var tmpStyle : StyleDAO;
			var app_styles : String;
			var cocktail_styles : String;
						if ( !id && !info )				return new StyleDAO();						id = ( id || info.style || info.id );			
			for each ( tmpStyle in styles )
				if ( tmpStyle.id == id )					return tmpStyle;						app_styles = config.appId +".core.data.dao.style.Style$DAO";
			cocktail_styles = "cocktail.core.data.dao.style.Style$DAO";
						switch ( info.category )
			{
				case "module":
					try {
						instance = get_class( app_styles.replace( "$", "" ) );
					} catch ( e1 : Error ) {						instance = get_class( cocktail_styles.replace( "$", "" ) );					}				break;				
				default:					try {
						instance = get_class( app_styles.replace( "$" , StringUtil.ucasef( info.category ) ) );
					} catch ( e2 : Error ) {
						instance = get_class( cocktail_styles.replace( "$", StringUtil.ucasef( info.category ) ) );					}				break;
			}						tmpStyle = new instance ();			
			return tmpStyle;
		}
				/**
		 * Search for the child based on the given id.
		 * @param id	The view id to search for.
		 * @return	The found child or null if no child is found.
		 */
		public function child ( id : String ) : View
		{
			var ids : Array;
			var item : View;
			var scope : View;
			var found : View;
			
			ids = [].concat( id.split( "." ) );			scope = this;
			found = null;
						while ( ids.length )			{
				id = ids.shift();
				for each ( item in scope.childs() )					if ( item.info.id == id )					{
						if ( ids.length )							scope = item;						else							found = item;						
						break;
					}
			}
						if ( found == null )				log.warn( "The child '"+ id +"' was not found." );//				log.fatal( "The child '"+ id +"' was not found." );			
			return found;
		}
		
		/**
		 * Returns all childs to the given action or all childs of all actions.
		 * @param action	Action to get the childs from, if no action is given, all childs is returned.
		 * @return	An array with the found childs.
		 */
		public function childs ( action : String = null ) : Array
		{
			var single : Array;			var all : Array;			var _action : String;			var output : Array;						if ( action != null )			{				for ( _action in _childs )					if ( _action == action )					{						output = _childs[ _action ];						break;						}									if( ! ( output is Array ) )					log.notice( "The action '" + action + "' was not found." );			}			else			{				all = new Array();				for each ( single in _childs )					all = all.concat( single );								output = all;								}						return output;
		}
								/* ---------------------------------------------------------------------
			LAYOUT CACHING
		--------------------------------------------------------------------- */
		
		/**
		 * Evaluates the path for the xml file.
		 * @return	The path to the xml file.
		 */
		public function get xmlPath () : String
		{
			return ( config.path( ".xml" ) + "views/" + clean_class_name.toLowerCase( ) + ".xml" );
		}
								/**
		 * Caches the xml file, parsing all items.
		 * @param event	Request Event.
		 */
		private function cache ( event : RequestEvent ) : void
		{
			log.info( "cache();" );			
			booted = true;			structure = new XML( event.iLoadableFile.getData( ) );						if ( validate() )			{
				cache_styles();				cached = true;
				task.done( class_path +"/boot" );
			}		}				/**		 * Validates the layout structure.		 */		private function validate () : Boolean		{			// TODO - validate layout structure ( duplicated ids etc )						return true; // OR throw new Error( ... )		}				/**
		 * Caches the layout styles and merge it with the parent styles. 
		 */
		private function cache_styles () : void
		{
			log.info( "cacheStyles();" );
			
			var style : XML;
			var daoClass : Class;
			var daoName : String;
			
			var app_styles : String;
			var cocktail_styles : String;
			
			app_styles = config.appId +".core.data.dao.style.Style$DAO";
			cocktail_styles = "cocktail.core.data.dao.style.Style$DAO";
			
			for each ( style in structure..styles.children( ) )			{
				daoName = style.localName( ) as String;				
				if ( daoName == "style" || daoName == "module" )
					daoName = "";
				else
					daoName = StringUtil.ucasef( daoName );
				
				try {
					daoClass = get_class( app_styles.replace( "$", daoName ) );
				} catch ( e1 : Error ) {
					daoClass =  get_class( cocktail_styles.replace( "$", daoName ) );
				}				
				styles.push( new daoClass( style ) ) ;
			}
		}
				/**		 * Caches the given layout action.		 * @param source	The pre processed source to be cached.		 */		public function cache_action ( source : XML ) : void		{			log.info( "cache_action();" );						var actionDao : LayoutActionDAO;						ArrayUtil.del( actions, source.@name, "name" );			actions.push( actionDao = new LayoutActionDAO( source.@name ) );			cache_action_item( actionDao.items , source.children() );		}				/**
		 * Cache action item, recursively.
		 * @param buffer	Buffer to cache into.	
		 * @param doc	Document node to cached.	
		 */
		private function cache_action_item ( buffer : Array, doc : XMLList ) : void
		{
			log.info( "cacheActionItem();" );
			
			var item : XML;
			var daoClass : Class;
			var daoName : String;
			var itemDAO : LayoutItemDAO;
			
			for each ( item in doc ) {
				daoName = item.localName( ) as String;
				
				if ( daoName == "module" )
					daoName = "Item";
				else
					daoName = StringUtil.ucasef ( daoName );
				
				daoClass = get_class( "cocktail.core.data.dao.layout.Layout" + daoName + "DAO" );								itemDAO = new daoClass();				itemDAO.boot ( this, bind, item );				
				buffer.push( itemDAO );								// TODO - check a better implementation for the 2th if's condition				if ( item.length() && daoName != "Txt" && daoName != "Option"  && daoName != "Radiobutton" )					cache_action_item( itemDAO.childs , item.children( ) );
			}
		}
								/**
		 * Instantiates all needed views/assets.
		 * @param items	Items to be instantiated. (default=action.items)
		 */
		private function instantiate ( items : Array = null ) : void
		{
			var action : LayoutActionDAO;
			var item : LayoutItemDAO;
			var name : String;
			
			var cocktail_elements : String;
			var app_elements : String;
			var app_area : String;
			
			var instance : Class;
			var view : View;
			
			cocktail_elements = "cocktail.lib.view.elements.$Element";
			app_elements = config.appId +".views.elements.$Element";
			app_area = config.appId +".views." + current_process.area_name + ".$View";
			
			if ( items == null ) {
				action = $action( current_process.action );
				if ( action == null ) {
					return;
				}
				items = action.items;
			}
			
			for each ( item in items )			{				switch ( item.category )				{					case "module":
						if ( StringUtil.outerb ( item.classname ) == "[]" )							instance = get_class( StringUtil.innerb( item.classname ));						else							if ( !item.shared )								instance = get_class( app_area.replace( "$" , item.classname ) );							else								instance = get_class( app_elements.replace( "$" , item.classname ) );					break;
					
					default:
						// text|img|swf|button|div|
						name = StringUtil.ucasef( item.category );						try {
							instance = get_class( app_elements.replace( "$" , name ) );
						} catch ( e1 : Error ) {
							instance = get_class( cocktail_elements.replace( "$" , name ) );
						}
						break;
				}
				
				view = new instance();
								view.info = item;
				view.styles = styles;
				
				addChild( view );				
				view.run( current_process );
				
				if ( item.childs.length )
					view.instantiate( item.childs );
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
			log.info( "$before_init();" );						try { 
				this[ "before_init" ]( ); 
			} catch ( e : Error ) {
			};
		}
				/**
		 * 
		 */
		internal final function $init () : void
		{			$initializing();			
			var item : View;
			
			for each ( item in childs( current_process.action ) )					item.$init( );			
			this.$before_init( );
			this.$after_init( );
		}
		/**
		 * 
		 */
		internal final function $after_init () : void
		{
			log.info( "$after_init();" );
			try { 
				this[ "after_init" ]( ); 
			} catch ( e : Error ) {
			};
			task.done( class_path + "/$after_init" );
		}
								/* ---------------------------------------------------------------------
			LOAD SEQUENCE EXECUTION
		--------------------------------------------------------------------- */
		
		/**
		 * 
		 */
		internal final function $before_load () : void
		{
			log.info( "$before_load();" );						if ( loadSchema )				instantiate ();						if ( info != null )				info.plugBinds();			try { 
				this[ "before_load" ]( ); 
			} catch ( e : Error ) {};
		}
				/**
		 * 
		 */
		internal final function $load () : void
		{
			var item : View;
			var pathCategory : String;
			var filepath : String;
						$loading();
			$before_load( );
			
			for each ( item in childs( current_process.action ) )
				item.$load( );
			
			try {
				info.src.length;
			} catch ( e : Error ) {
				if ( ! childs().length ) {
					$after_load( );
				}
				return;
			}
						if ( StringUtil.outerb( info.src ) == "[]" )				filepath = StringUtil.innerb( info.src );			else			{				pathCategory = info.category;
				pathCategory = ( pathCategory == "btn" ? "swf" : pathCategory );
				pathCategory = ( pathCategory == "module" ? "swf" : pathCategory );
				
				if (info.category.toLowerCase( ) == "font") {
					filepath = config.path( "." + info.category ) + "fonts/";
				} else if ( !info.shared ) {
					filepath = config.path( "." + pathCategory ) + current_process.area_name + "/";
				} else {
					filepath = config.path( "." + pathCategory ) + "elements/";
				}				
				filepath += info.src;			}
						request.load( filepath , false ).listen( $after_load, null );
		}
		
						/**
		 * 
		 */
		internal final function $after_load ( event : RequestEvent = null ) : void
		{
			log.info( "$after_load();" );
			
			if ( event != null ) {
				holder = event.iLoadableFile.getData( "flash.display.Loader" ).contentLoaderInfo.content;
				loader = event.iLoadableFile.loadManagerObject as Loader;
			}
						
			task.done( class_path + "/$after_load" );
			try {
				this[ "after_load" ]( ); 
			} catch ( e : Error ) {};
		}
								/* ---------------------------------------------------------------------
			STYLEABLE TARGET
		--------------------------------------------------------------------- */				/**		 * Returns the target in wich the styles will be applied.		 * @return	The styleable target.		 */		public function get styleable_target () : DisplayObject		{			return sprite;		}								/* ---------------------------------------------------------------------
			RENDER SEQUENCE EXECUTION
		--------------------------------------------------------------------- */
		
		/**
		 * Invoked by subclasses, informing that the render process has finished.
		 * @param params	Just to avoid compile erros, so you can use the fucntion as some listener without getting an error. 
		 */
		public final function render_done (...params) : void
		{			$render_done();
			task.done( class_path +"/render_done" );
		}
		
		/**
		 * 
		 */
		internal final function $before_render (  ) : void
		{
			log.info( "$before_render();" );						try { style().apply( this ); } catch ( e1 : Error ) {}
			try { this[ "before_render" ](); } catch ( e2 : Error ) {};		}
				/**
		 * 
		 */
		internal final function $render () : void
		{			var item : View;						$rendering();
						for each ( item in childs( current_process.action ) )				item.$render( );
						this.$before_render( );
			
			if ( holder && ! ( this is AssetElement ) )				sprite.addChildAt( holder, 0 );
			
			new Timeout( $after_render, 200 ).exec();
		}
				/**
		 * 
		 */
		internal final function $after_render () : void
		{			log.info( "$after_render();" );
			task.done( class_path + "/$after_render" );
			
			try {
				this[ "after_render" ]( ); 
			} catch ( e : Error ) {};
		}
		
		
		
		/* ---------------------------------------------------------------------
			DESTROY SEQUENCE EXECUTION
		--------------------------------------------------------------------- */
		
		/**
		 * Invoked by subclasses, informing that the render process has finished.
		 * @param params	Just to avoid compile erros, so you can use the fucntion as some listener without getting an error.
		 */
		public final function destroy_done (...params) : void
		{			$destroy_done();						if ( params[ 0 ] !== true )				$after_destroy();			
			if ( up == null )
				task.done( class_path +"/destroy_done" );
		}
		
		/**
		 * 
		 */
		internal function $before_destroy ( dao : ProcessDAO ) : void
		{
			log.info( "$before_destroy();" );
			
			try {				this[ "before_destroy" ]( dao ); 
			} catch ( e1 : Error ) {
				// TODO - check technique to auto destroy
				//destroy_done();
			};
		}
		
		/**
		 * 
		 */
		internal function $destroy ( dao : ProcessDAO ) : void
		{
			log.info( "$destroy();" );						$destroying();			//			var item : View;			//			for each ( item in childs() ) {//				item.$destroy( dao );//			}			
			this.$before_destroy( dao );
		}
		
		/**
		 * 
		 */
		internal function $after_destroy () : void
		{
			var destroyed : ProcessDAO;
			var child : View;
			
			log.info( "$after_destroy();" );
			
			if ( dead_processes.length )
			{
				destroyed = dead_processes.pop();
				ArrayUtil.del( dead_processes , destroyed.action, "action" );
				ArrayUtil.del( active_processes , destroyed.action, "action" );
				
				for each ( child in _childs[ destroyed.action ] )					sprite.removeChild( child.sprite );				
				_childs[ destroyed.action ] = null;				delete _childs[ destroyed.action ];
			}
			
			if ( ! active_processes.length )
			{				if ( loader is Loader )
					loader.unload();
				
				if ( up == null )
				{
					ctrl.stage.removeChild( sprite );					_runned = false;
				}
			}
		}
	}
}