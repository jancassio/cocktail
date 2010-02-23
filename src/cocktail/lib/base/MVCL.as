package cocktail.lib.base 
{
	import cocktail.Cocktail;
	import cocktail.core.Index;
	import cocktail.core.gunz.Gun;

	/**
	 * @author nybras | me@nybras.com
	 */
	public class MVCL extends Index 
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

		/* BOOTING */
		override public function boot( cocktail : Cocktail ) : *
		{
			var s : *;
			
			s = super.boot( cocktail );
			
			_init_gunz( );
			
			return s;
		}
	}
}