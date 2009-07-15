package cocktail.lib.view.styles.values.enums 
{
	/**
	 * @author nybras | nybras@codeine.it
	 */
	public class PositionEnum 
	{
		public static function get position () : Position
		{
			return new Position();
		}
	}
}

class Position 
{
	public const ABSOLUTE : String = "absolute";
	public const RELATIVE : String = "relative";
}