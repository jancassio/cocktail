package cocktail.lib.cocktail.tweaks 
{	import cocktail.Cocktail;
	import cocktail.core.Task;
	import cocktail.core.data.dao.ProcessDAO;
	import cocktail.core.status.Status;
	import cocktail.lib.cocktail.tweaks.Tweaks;	

	/**
	 * Controller tweaks.	 * @author nybras | nybras@codeine.it	 */	public class ControllerTweaks extends Tweaks 
	{
		public var root : Cocktail;
		
		protected var _status : String;
		protected var _task : Task;
		protected var _dependences : Array;
		
		
				/* ---------------------------------------------------------------------
			USES HANDLERS
		--------------------------------------------------------------------- */
		
		/**
		 * Specify the area dependences.
		 * @param url	The dependence url in string format
		 * 		(AreaName/action/param1/param2/praram...n).
		 * @param wait	if <code>true</code> waits for the previous
		 * <code>after_render</code> to continue, otherwise <code>false</code>,
		 * just goes on. 
		 */
		final protected function uses ( url : String, wait : Boolean ) : void
		{
			_dependences.push( new ProcessDAO( url , wait, false ) );
		}
		
		
		
		/* ---------------------------------------------------------------------
			NAVIGATION & LOCALE HANDLERs
		--------------------------------------------------------------------- */
		
		/**
		 * Redirects the application to the given url.
		 * @param url	Target location to redirect the application to.
		 * @param silentMode	If <code>true</code>, reflects the url in the
		 * address bar, otherwise <code>false</code> keeps the adress bar as it
		 * is.
		 */
		final public function redirect(
			url : String,
			silentMode : Boolean = false,
			freeze : Boolean = false
		) : void
		{
			root.redirect( url, silentMode, freeze );
		}
		
		/**
		 * Change the current locale string for I18n.
		 * @param locale	The string locale to use.
		 */
		final public function switchLocale ( locale : String ) : void
		{
			if ( config.current_locale == locale )
				return;
				
			config.current_locale = locale;
			root.reboot();
		}
		
		
		
		/* ---------------------------------------------------------------------
			NOMENCLATURE HANDLERs
		--------------------------------------------------------------------- */
		
		/**
		 * Returns the controller name without the prefix "Controller".
		 * @return	The controller name.
		 */
		public final function get clean_class_name () : String
		{
			return class_name.replace( "Controller", "" );
		}
		
		
		
		/* ---------------------------------------------------------------------
			DEPENDENCE CONTROL
		--------------------------------------------------------------------- */
		
		/**
		 * Collects all dependencies.
		 */
		public function dependences ( action : String ) : Array
		{
			_dependences = new Array();
			
			if ( defined ( this, action +"_uses" ) )
				this[ action +"_uses" ]();
			else
				log.info( "No dependencies for: "+ class_path +"/"+ action );
				
			return _dependences;
		}
		
		
		/* ---------------------------------------------------------------------
			STATUS MODIFIERS
		--------------------------------------------------------------------- */
		
		/**
		 * Mark controller execution status as <code>initializing</code>
		 */
		protected function _initializing () : void
		{
			_status = Status.INITIALIZING;
		}
		
		/**
		 * Mark controller execution status as <code>loading</code>
		 */
		protected function _loading () : void
		{
			_status = Status.LOADING;
		}
		
		/**
		 * Mark controller execution status as <code>rendering</code>
		 */
		protected function _rendering () : void
		{
			_status = Status.RENDERING;
			
			if ( defined ( this, "render_start" ) )
				this[ "render_start" ]();
		}
		
		/**
		 * Mark controller execution status as <code>render_done</code>
		 */
		protected function _render_done () : void
		{
			_status = Status.RENDER_DONE;
			_task.done( class_path + "/render_done" );
			
			if ( defined ( this, "render_done" ) )
				this[ "render_done" ]();
		}
		
		/**
		 * Mark controller execution status as <code>destroying</code>
		 */
		protected function _destroying () : void
		{
			_status = Status.DESTROYING;
		}
		
		/**
		 * Mark controller execution status as <code>destroy_done</code>
		 */
		protected function _destroy_done () : void
		{
			_status = Status.DESTROY_DONE;
			_task.done( class_path + "/destroy_done" );
		}
	}}