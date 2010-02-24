package cocktail.lib 
{
	import cocktail.Cocktail;
	import cocktail.core.gunz.Gun;
	import cocktail.core.process.Process;
	import cocktail.core.request.Request;
	import cocktail.lib.gunz.LayoutBullet;

	public class Layout extends View
	{
		/* GUNZ */
		public var gunz_render_complete : Gun;

		private function _init_gunz() : void
		{
			gunz_render_complete = new Gun( gunz, this, "render_complete" );
		}

		/* INITIALIZING */
		
		/**
		 * 
		 */
		override public function boot( cocktail : Cocktail ) : *
		{
			var s : *;
		
			s = super.boot( cocktail );
			_init_gunz( );
			
			return s;
		}

		/* LOAD */
		
		public function before_load( request: Request ): Boolean
		{
			return true;
		}
		
		/**
		 * TODO: write docs
		 */
		public function load( request : Request ) : Layout
		{
			request;
			return this;
		}

		/**
		 * TODO: write docs
		 */
		public function load_scheme( request : Request ) : Layout
		{
			request;
			
			// TODO: remove this call and implement in the right time!
			gunz_scheme_load_complete.shoot( new LayoutBullet() );
			
			return this;
		}

		public function render( process : Process ) : void 
		{
			process;
		}
	}
}