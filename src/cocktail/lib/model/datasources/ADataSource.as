package cocktail.lib.model.datasources 
{
	import cocktail.Cocktail;
	import cocktail.core.Index;
	import cocktail.core.gunz.Gun;

	import flash.events.Event;

	public class ADataSource extends Index
	{
		/* GUNZ */
		public var gunz_load_start : Gun; 
		public var gunz_load_progress : Gun; 
		public var gunz_load_complete : Gun; 

		private function _init_gunz() : void
		{
			gunz_load_start = new Gun( gunz, this, "load_start" );
			gunz_load_progress = new Gun( gunz, this, "load_progress" );
			gunz_load_complete = new Gun( gunz, this, "load_complete" );
		}

		/* VARS */
		
		public var raw : *;
		
		
		
		/* BOOTING */
		override public function boot( cocktail : Cocktail ) : *
		{
			var s : *;
			
			s = super.boot( cocktail );
			_init_gunz( );
						return s;
		}

		public function ADataSource()
		{
		}

		public function load() : ADataSource
		{
			_after_load;
			return this;
		}

		private function _after_load() : void
		{
			// ...
		}
		
//		/**
//		 * Loads the data source.
//		 */
//		public function load() : IDataSource
//		{
////			raw = info.children();
////			return this;
//		}
//		
//		
//		
//		/* ---------------------------------------------------------------------
//			CACHING & PLUGGING
//		--------------------------------------------------------------------- */
//		
//		/**
//		 * Caches the loaded data into the <code>raw</code> property.
//		 */
//		private function load_complete ( event : RequestEvent = null ) : void
//		{
//			plug();
//			dispatch( Event.COMPLETE );
//		}
	}
}