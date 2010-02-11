package cocktail.core.gunz 
{

	/**
	 * @author nybras | me@nybras.com
	 */
	public class GunzGroup 
	{
		private var _fired : int;
		private var _items : Array;

		public var gunz : Gunz;
		public var gunz_complete : Gun;

		
		public function GunzGroup()
		{
			gunz = new Gunz( this );
			gunz_complete = new Gun( gunz, this, "complete" );
			_items = [];
		}

		public function add( gun : Gun ) : GunzGroup
		{
			gun.add( _fire );
			_items.push( gun );
			return this;
		}

		private function _fire( ...bullet ) : void
		{
			if( ++_fired == _items.length )
				gunz_complete.pull( );
		}
	}
}