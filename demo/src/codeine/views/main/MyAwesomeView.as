package codeine.views.main 
{
	import cocktail.core.request.Request;

	import codeine.AppView;

	/**
	 * @author hems | dev@henriquematias.com
	 */
	public class MyAwesomeView extends AppView 
	{
		public function MyAwesomeView()
		{
		}

		override public function after_render(request : Request) : void 
		{
			super.after_render( request );
			
			log.info( "Running..." );
			
			sprite.graphics.beginFill( 0xFF0000 );
			sprite.graphics.drawCircle( 0, 0, 50 );
			sprite.graphics.endFill();
			
			cocktail.app.addChild( sprite );
		}
	}
}
