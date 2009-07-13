package cocktail.lib.view.styles.values.enums 
{
	/**
	 * @author nybras | nybras@codeine.it
	 */
	public class PositionEnum 
	{
		public static function get position () : position
		{
			return new position();
		}
	}
}

class position 
{
	public const ABSOLUTE : String = "absolute";
	public const RELATIVE : String = "relative";
}