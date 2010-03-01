package codeine.views.main 
{
	import cocktail.core.request.Request;

	import codeine.AppView;

	/**
	 * @author hems | dev@henriquematias.com
	 */
	public class AnotherOneView extends AppView
	{
		override public function after_render(request : Request) : void 
		{
			super.after_render( request );
			
			sprite.graphics.beginFill( 0xccff00 );
			sprite.graphics.drawRect( 0, 0, 500, 500 );
			sprite.graphics.endFill();
		}
	}
}