package cocktail.lib 
{
	import cocktail.Cocktail;
	import cocktail.core.Index;
	import cocktail.core.gunz.Gun;
	import cocktail.core.gunz.Gunz;

	/**
	 * @author nybras | me@nybras.com
	 */
	public class MVC extends Index 
	{
		/* BOOTING */
		override public function boot( cocktail : Cocktail ) : *
		{
			var s : *;
			
			s = super.boot( cocktail );
			
			_init_gunz( );
			
			return s;
		}

		/* INITIALIZING */
		public var gunz : Gunz; 
		public var gunz_boot : Gun; 
		public var gunz_complete : Gun; 

		private function _init_gunz() : void
		{
			gunz = new Gunz( this );
			gunz_boot = new Gun( gunz, this, "boot" );
			gunz_complete = new Gun( gunz, this, "complete" );
		}
	}
}