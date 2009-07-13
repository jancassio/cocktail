package cocktail.lib.view.styles.values.vos.position 
{

	/**
	 * @author nybras | nybras@codeine.it
	 */
	public class SnapVO 
	{
		public var snap : String;
		public var snap_left : uint;
		public var snap_top : uint;
		public var snap_scale : uint;
		
		public function SnapVO ( raw : String ) : void
		{
			var split : Array;
			
			split = raw.split( "  " );
			
			snap = raw;
			snap_left = split[ 0 ];
			snap_top = split[ 1 ];
			snap_scale = split[ 2 ];
		}
	}
}