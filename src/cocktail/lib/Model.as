package cocktail.lib 
{
	import cocktail.Cocktail;
	import cocktail.core.Index;
	import cocktail.core.request.Request;
	import cocktail.lib.gunz.ModelTrigger;	

	public class Model extends Index
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _trigger : ModelTrigger;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * 
		 */
		public function Model( cocktail : Cocktail )
		{
			super( cocktail);
			_trigger = new ModelTrigger( this );
		}

		
		
		/* ---------------------------------------------------------------------
			BULLET/TRIGGER IMPLEMENTATION( listen/unlisten )
		--------------------------------------------------------------------- */
		
		/**
		 * Trigger reference.
		 * @return	The <code>RouterTrigger</code> reference.
		 */
		public function get trigger() : ModelTrigger
		{
			return _trigger;
		}
		
		/**
		 * Start listening.
		 * @return	The <code>UserTrigger</code> reference.
		 */
		public function get listen() : ModelTrigger
		{
			return ModelTrigger( _trigger.listen );
		}
		
		/**
		 * Stop listening.
		 * @return	The <code>UserTrigger</code> reference.
		 */
		public function get unlisten() : ModelTrigger
		{
			return ModelTrigger( _trigger.unlisten );
		}
		
		
		
		/* ---------------------------------------------------------------------
			LOAD
		--------------------------------------------------------------------- */
		
		/**
		 * TODO: write docs
		 */
		public function load( request : Request ) : Model
		{
			request;
			return this;
		}
	}
}