package cocktail.core.gunz 
{

	/**
	 * Keeps a list of guns in order to offer <code>rm_all"</code>
	 * functionality, as well a recursive <code>destroy</code> method.
	 * @author nybras | me@nybras.com
	 */
	public class Gunz
	{
		/* VARS */
		
		/** Keeps the owner. */
		internal var _owner : *;
		/** Keeps the guns list. */
		internal var _gunz : Array;

		/* INITIALIZING */
		
		/**
		 * Create a Gunz to store Gun's. You can have as many Gun's as you need, 
		 * they are added by the <code>_keep()</code> method.
		 * @param owner A reference to the class that will listen the Gun shots
		 */
		public function Gunz( owner : * )
		{
			_owner = owner;
			_gunz = [];
		}

		/* KEEPING, REMOVING AND DESTROYING GUNS */
		
		/**
		 * Add a Gun to this store, this method is called from the 
		 * Gun's contructor.
		 * @param gun	The Gun.
		 */
		internal function _keep( gun : Gun ) : void
		{
			_gunz.push( gun );
		}

		/**
		 * Removes all listeners from all guns.
		 * @param type	If informed, remove all listeners for the given Gun
		 * types. IF <code>null</code>, removes all listeners for all Gun types.
		 */
		public final function rm_all( type : String = null ) : void
		{
			var i : int;
			var gun : Gun;
			
			if( _gunz.length ) do
			{
				gun = _gunz[ i ];
				
				if( type == null || type == gun._type )
					gun.rm_all( );
					
			} while( ++i < _gunz.length );
		}

		/**
		 * Destroys the Gunz and all Gun in the list, unlisten everything and
		 * do some garbage collection.
		 */
		public final function destroy() : void
		{
			var i : int;
			
			if( _gunz.length ) do
			{
				Gun( _gunz[ i ] ).destroy( );
			} while( ++i < _gunz.length );
			
			_owner = null;
			_gunz = null;
		}
	}
}