package cocktail.lib.view.styles.values.vos.position 
{

	/**
	 * @author nybras | nybras@codeine.it
	 */
	public class SnapVO 
	{
		public var snap : String = "0 0 0";
		public var left : Number;
		public var top : Number;
		public var scale : Number;
		
		public function SnapVO ( raw : String ) : void
		{
			var split : Array;
			
			if ( raw != null )
				snap = raw;
			
			split = snap.split( "  " );
			
			left = split[ 0 ];
			top = split[ 1 ];
			scale = split[ 2 ];
		}
	}
}