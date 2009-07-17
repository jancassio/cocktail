package cocktail.lib.view.styles.values.vos.border 
{

	/**
	 * @author hems | nybras@codeine.it
	 */
	public class BorderVo 
	{
		public var border : String;
		public var border_width : uint;
		public var border_style : uint;
		public var border_color : uint;
		
		public function BorderVo ( raw : String ) : void
		{
			var split : Array;
			
			split = raw.split( "  " );
			
			border = raw;
			border_width = split[ 0 ];
			border_style = split[ 1 ];
			border_color = split[ 2 ];
		}
	}
}