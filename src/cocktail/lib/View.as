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
	import cocktail.core.Index;	import cocktail.core.Task;	import cocktail.core.connectors.MotionConnector;	import cocktail.core.connectors.RequestConnector;	import cocktail.core.connectors.request.RequestEvent;	import cocktail.core.data.bind.Bind;	import cocktail.core.data.dao.ProcessDAO;	import cocktail.core.data.ds.Tree;	import cocktail.core.status.Status;	import cocktail.lib.Controller;	import cocktail.lib.Layout;	import cocktail.lib.cocktail.tweaks.ViewTweaks;	import cocktail.lib.view.styles.Style;	import cocktail.utils.Timeout;		import flash.display.DisplayObject;	import flash.display.Loader;	import flash.display.Sprite;	import flash.events.Event;	
	/**	 * Main cocktail View class. This is the base class for every single View
	 * you have in your application.
	 * @author nybras | nybras@codeine.it
	 * @see Index
	 * @see Cocktail
	 * @see Controller
	 * @see Model
	 */
	public class View extends ViewTweaks
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
				private var _parent : View;
		private var _prev : View;
		private var _next : View;
				private var _childs : Tree;
		
		protected var _status : String;
		
		protected var _task : Task;
		protected var _bind : Bind;
		
		protected var _controller : Controller;
		protected var _layout : Layout;
		protected var _sprite : Sprite;
		protected var _style : Style;
		
		protected var _holder : DisplayObject;		protected var _loader : Loader;		protected var _request : RequestConnector;		
		public var motion : MotionConnector; 				
				/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
				/**
		 * Initializing the view.
		 * @param ctrl	Area controller.
		 * @param forceLayout	Forces the layout loading process.
		 */
		internal function init ( controller : Controller, layout : Layout, fxml_node : XML ) : void
		{			_parse_properties( fxml_node );
			
			_childs = new Tree();
			_sprite = new Sprite ();
			
			_controller = controller;			_layout = layout;			
//			_task = controller._task;//			_bind = controller._bind;
//			_request = controller._request;
			
			_layout.addChild( this );
						motion = new MotionConnector ( _sprite );
			
			config.listen( null, onStageResize );
		}
								/* ---------------------------------------------------------------------			STATUS MODIFIERS		--------------------------------------------------------------------- */				/**		 * Mark controller execution status as <code>initializing</code>		 */		private function _initializing () : void		{			_status = Status.INITIALIZING;		}				/**		 * Mark controller execution status as <code>loading</code>		 */		private function _loading () : void		{			_status = Status.LOADING;		}				/**		 * Mark controller execution status as <code>rendering</code>		 */		private function _rendering () : void		{			_status = Status.RENDERING;		}		/**		 * Mark controller execution status as <code>render_done</code>		 */		private function _render_done () : void		{			_status = Status.RENDER_DONE;		}				/**		 * Mark controller execution status as <code>destroying</code>		 */		private function _destroying () : void		{			_status = Status.DESTROYING;		}				/**		 * Mark controller execution status as <code>destroy_done</code>		 */		private function _destroy_done () : void		{			_status = Status.DESTROY_DONE;		}								/* ---------------------------------------------------------------------			STAGE BEHAVIORS		--------------------------------------------------------------------- */				/**		 * Listens for Event.RESIZE @ stage, and try to refresh the view.			 * @param event	Event.RESIZE.		 */		private function onStageResize ( event : Event = null ) : void		{			try { this[ "realign" ](); } catch ( e : Error ) {};		}				
				/* ---------------------------------------------------------------------
			UP & NEXT shortcuts
		--------------------------------------------------------------------- */
		
		/**
		 * Sets the view parent.
		 * @param parent	The view parent's view. :)
		 */
		public function set up ( target : View ) : void 
		{
			_parent = target;
		}
		/**
		 * Gets the view parent.
		 * @return	The view parent's view.
		 */
		public function get up () : View
		{
			return _parent;
		}
						/**
		 * Sets the view parent.
		 * @param parent	The view parent's view. :)
		 */
		public function set prev ( target : View ) : void 
		{
			_prev = target;
		}
		/**
		 * Gets the view parent.
		 * @return	The view parent's view.
		 */
		public function get prev () : View
		{
			return _prev;
		}
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
			_controller.redirect( url , silentMode, freeze );
		}
		
		/**		 * Change the current locale string for I18n.		 * @param locale	The string locale to use.		 */
		final public function switchLocale ( locale : String ) : void
		{			_controller.switchLocale( locale );
		}		
		
		
		/**
		 * Adds a child to the stack.
		 * @param child	The child to be added.
		 */
		public function addChild ( child : View ) : View
		{
//			//			child.up = this;//			child.prev = ( head ? null : ( ( target.length ? childs[ target.length - 1 ] : null ) ) );//			child.current_process = current_process;//			//			if ( head )//			{//				if ( target.length )
//					target[ 0 ].prev = child;//				//				target.unshift( child );//			}	//			else//				target.push( child );//			//			child.boot( _controller );//			//			if ( _status == Status.RENDER_DONE || _status == Status.RENDERING )////				child._load();
//				child._render();			
			return child;		}
		
		/**
		 * 
		 */
		public function removeChild ( view : View ) : void
		{
			// 
		}
		
		
				/**
		 * Search for the child based on the given id.
		 * @param id	The view id to search for.
		 * @return	The found child or null if no child is found.
		 */
		public function child ( id : String ) : View
		{
			var found : View;
			
			id;
			// TODO - code it
			
			return found;
		}
		
		/**
		 * Returns all current childs.
		 * @return	An array with all childs.
		 */
		public function childs () : Array
		{
			var output : Array;			
			// TODO - code it						return output;
		}
								/**
		 * Instantiates all needed views/assets.
		 * @param items	Items to be instantiated. (default=action.items)
		 */
		private function instantiate ( items : Array = null ) : void
		{
//			var action : LayoutActionDAO;
//			var item : LayoutItemDAO;
//			var name : String;
//			
//			var cocktail_elements : String;
//			var app_elements : String;
//			var app_area : String;
//			
//			var instance : Class;
//			var view : View;
//			
//			cocktail_elements = "cocktail.lib.view.elements.$Element";
//			app_elements = config.appId +".views.elements.$Element";
//			app_area = config.appId +".views." + current_process.area_name + ".$View";
//			
//			if ( items == null ) {
//				action = $action( current_process.action );
//				if ( action == null ) {
//					return;
//				}
//				items = action.items;
//			}
//			
//			for each ( item in items )//			{//				switch ( item.category )//				{//					case "module":
//						if ( StringUtil.outerb ( item.classname ) == "[]" )//							instance = get_class( StringUtil.innerb( item.classname ));//						else//							if ( !item.shared )//								instance = get_class( app_area.replace( "$" , item.classname ) );//							else//								instance = get_class( app_elements.replace( "$" , item.classname ) );//					break;
//					
//					default:
//						// text|img|swf|button|div|
//						name = StringUtil.ucasef( item.category );//						try {
//							instance = get_class( app_elements.replace( "$" , name ) );
//						} catch ( e1 : Error ) {
//							instance = get_class( cocktail_elements.replace( "$" , name ) );
//						}
//						break;
//				}
//				
//				view = new instance();
//				//				view.info = item;
//				view.styles = styles;
//				
//				addChild( view );//				
//				view.run( current_process );
//				
//				if ( item.childs.length )
//					view.instantiate( item.childs );
//			}
		}
		
		
				/* ---------------------------------------------------------------------
			INIT SEQUENCE EXECUTION
		--------------------------------------------------------------------- */
		
		/**
		 * TODO - add documentation
		 */
		internal final function _before_init () : void
		{
			log.info( "_before_init();" );
			try { this[ "before_init" ](); } catch ( e : Error ) {};		}
		
		/**		 * TODO - add documentation
		 */
		internal final function _init () : void
		{			_initializing();			
			var item : View;
			
			for each ( item in childs() )				item._init();			
			_before_init( );
			_after_init( );
		}
		/**
		 * TODO - add documentation
		 */
		internal final function _after_init () : void
		{
			log.info( "_after_init();" );
			try { this[ "after_init" ](); } catch ( e : Error ) {};
			_task.done( class_path + "/_after_init" );
		}
								/* ---------------------------------------------------------------------
			LOAD SEQUENCE EXECUTION
		--------------------------------------------------------------------- */
		
		/**
		 * TODO - add documentation
		 */
		internal final function _before_load () : void
		{
			log.info( "_before_load();" );						try { this[ "before_load" ](); } catch ( e : Error ) {};
		}
				/**
		 * 
		 */
		internal final function _load () : void
		{
			var item : View;
						_loading();
			
			for each ( item in childs() )
				item._load();
			
			_before_load();
		}
		
		/**
		 * TODO - add documentation
		 */
		internal final function _after_load ( event : RequestEvent ) : void
		{
			log.info( "_after_load();" );
			
			if ( event != null ) {
				_holder = event.iLoadableFile.getData( "flash.display.Loader" ).contentLoaderInfo.content;
				_loader = event.iLoadableFile.loadManagerObject as Loader;
			}
						
			_task.done( class_path + "/_after_load" );
			try { this[ "after_load" ](); } catch ( e : Error ) {};
		}
								/* ---------------------------------------------------------------------
			RENDER SEQUENCE EXECUTION
		--------------------------------------------------------------------- */
		
		/**
		 * 
		 */
		internal final function _before_render (  ) : void
		{
			log.info( "_before_render();" );			//			try { style().apply( this ); } catch ( e1 : Error ) {}
			try { this[ "before_render" ](); } catch ( e2 : Error ) {};		}
				/**
		 * 
		 */
		internal final function _render () : void
		{			var item : View;						_rendering();
						for each ( item in childs() )				item._render( );
						_before_render( );
			
//			if ( _holder && ! ( this is AssetElement ) )//				_sprite.addChildAt( _holder, 0 );
			
			new Timeout( _after_render, 200 ).exec();
		}
				/**
		 * 
		 */
		internal final function _after_render () : void
		{			log.info( "_after_render();" );
			_task.done( class_path + "/_after_render" );
			
			try {
				this[ "after_render" ]( ); 
			} catch ( e : Error ) {};
		}
		
		
		
		/* ---------------------------------------------------------------------
			DESTROY SEQUENCE EXECUTION
		--------------------------------------------------------------------- */
		
		/**
		 * 
		 */
		private function _before_destroy ( dao : ProcessDAO ) : void
		{
			log.info( "_before_destroy();" );
			
			try {				this[ "before_destroy" ]( dao ); 
			} catch ( e1 : Error ) {
				// TODO - check technique to auto destroy
				//destroy_done();
			};
		}
		
		/**
		 * 
		 */
		protected function _destroy ( dao : ProcessDAO ) : void
		{
			log.info( "_destroy();" );						_destroying();			//			var item : View;			//			for each ( item in childs() ) {//				item._destroy( dao );//			}			
			this._before_destroy( dao );
		}
		
		/**
		 * 
		 */
		private function _after_destroy () : void
		{
//			var destroyed : ProcessDAO;
//			var child : View;
//			
//			log.info( "_after_destroy();" );
//			
//			if ( dead_processes.length )
//			{
//				destroyed = dead_processes.pop();
//				ArrayUtil.del( dead_processes , destroyed.action, "action" );
//				ArrayUtil.del( active_processes , destroyed.action, "action" );
//				
//				for each ( child in _childs[ destroyed.action ] )//					_sprite.removeChild( child._sprite );//				
//				_childs[ destroyed.action ] = null;//				delete _childs[ destroyed.action ];
//			}
//			
//			if ( ! active_processes.length )
//			{//				if ( _loader is Loader )
//					_loader.unload();
//				
//				if ( up == null )
//				{
//					_controller.stage.removeChild( _sprite );//					_runned = false;
//				}
//			}
		}
	}
}