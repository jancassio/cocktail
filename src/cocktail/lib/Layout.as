package cocktail.lib 
{
	import cocktail.Cocktail;
	import cocktail.core.gunz.Gun;
	import cocktail.core.request.Request;

	public class Layout extends View
	{
		/* ===== GUNZ ======================================================= */
		public var gunz_scheme_loaded : Gun; 

		private function _init_gunz() : void
		{
			gunz_scheme_loaded = new Gun( gunz, this, "shcheme_loaded" );
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
		
		/**
		 * TODO: write docs
		 */
		public function load( request : Request ) : Layout
		{
			request;
			return this;
		}
	}
}