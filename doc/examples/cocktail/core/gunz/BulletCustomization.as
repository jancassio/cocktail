/**
 * @exampleText Example for creating a custom bullet with some properties.
 */
 
import cocktail.core.gunz.Bullet;

public class CustomBullet extends Bullet
{
	public var property_1 : String;
	public var property_2 : Number;
	public var property_3 : Array;

	public function CustomBullet( 
								property_1 : String,
								property_2 : Number,
								property_3 : Array
								) : void
	{
		super( );
		
		this.property_1 = property_1;
		this.property_2 = property_2;
		this.property_3 = property_3;
	}
}