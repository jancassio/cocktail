package codeine.views.main 
{
	import cocktail.core.request.Request;

	import codeine.AppView;

	/**
	 * @author hems | dev@henriquematias.com
	 */
	public class MyAwesOneView extends AppView 
	{
		public function MyAwesOneView()
		{
		}

		override public function after_render(request : Request) : void 
		{
			super.after_render( request );
			
			log.info( "Running..." );
			sprite.graphics.beginFill( 0xFF000000 );
			sprite.graphics.drawCircle( 50, 50, 50 );
			sprite.graphics.endFill();
		}
	}
}
