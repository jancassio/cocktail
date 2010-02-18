package cocktail.core.gunz 
{

	/**
	 * @author nybras | me@nybras.com
	 */
	public class Gunz
	{
		/* ===== VARS ======================================================= */
		internal var _owner : *;
		internal var _gunz : Array;

		/* ===== INITIALIZING =============================================== */
		public function Gunz( owner : * )
		{
			_owner = owner;
			_gunz = [];
		}

		/* ===== KEEP / RM_ALL / DESTROY ==================================== */
		internal function _keep( gun : Gun ) : void
		{
			_gunz.push( gun );
		}

		public final function rm_all( type : String = null ) : void
		{
			for each( var gun : Gun in _gunz )
				if( type == null || type == gun._type )
					gun.rm_all( );
		}

		public final function destroy() : void
		{
			for each( var gun : Gun in _gunz )
				gun.destroy( );
		}
	}
}