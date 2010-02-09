package cocktail.lib {
	import cocktail.Cocktail;
	import cocktail.core.Index;
	import cocktail.core.processes.Process;
	import cocktail.lib.gunz.LayoutTrigger;

	public class Layout extends Index
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _trigger : LayoutTrigger;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * 
		 */
		override public function boot( cocktail : Cocktail ) : *
		{
			var s : *;
		
			s = super.boot( cocktail);
			_trigger = new LayoutTrigger( this );
			return s;
		}

		
		
		/* ---------------------------------------------------------------------
			BULLET/TRIGGER IMPLEMENTATION( listen/unlisten )
		--------------------------------------------------------------------- */
		
		/**
		 * Trigger reference.
		 * @return	The <code>RouterTrigger</code> reference.
		 */
		public function get trigger() : LayoutTrigger
		{
			return _trigger;
		}
		
		/**
		 * Start listening.
		 * @return	The <code>UserTrigger</code> reference.
		 */
		public function get listen() : LayoutTrigger
		{
			return LayoutTrigger( _trigger.listen );
		}
		
		/**
		 * Stop listening.
		 * @return	The <code>UserTrigger</code> reference.
		 */
		public function get unlisten() : LayoutTrigger
		{
			return LayoutTrigger( _trigger.unlisten );
		}
		
		
		
		/* ---------------------------------------------------------------------
			LOAD
		--------------------------------------------------------------------- */
		
		/**
		 * TODO: write docs
		 */
		public function load( process : Process ) : Layout
		{
			process;
			return this;
		}
	}
}