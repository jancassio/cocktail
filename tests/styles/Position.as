package styles
{
	import cocktail.lib.view.styles.Styles;
	import cocktail.lib.view.styles.gunz.StylesBullet;
	import cocktail.lib.view.styles.renders.PositionRender;
	import cocktail.lib.view.styles.renders.Render;
	
	import flash.display.Sprite;	

	/**
	 * @author nybras | nybras@codeine.it
	 */
	public class Position extends Sprite 
	{
		private var _ball : Sprite;
		private var _styles : Styles;
		private var _pos_render : PositionRender;
		
		public function Position()
		{
			_draw();
			_load();
		}

		private function _draw() : void
		{
			_ball = new Sprite();
			_ball.graphics.beginFill( 0, 1 );
			_ball.graphics.drawCircle( 0, 0, 50 );
		}

		private function _load() : void
		{
			_styles = new Styles ( "style-test.fss" );
			_styles.listen.complete( _plug );
		}
		
		private function _plug ( bullet : StylesBullet ) : void
		{
			bullet;
			
			_pos_render = new PositionRender();
			_pos_render.boot( _styles, _ball, "just-a-test" );
			_pos_render.render();
			
			_render();
		}
		
		private function _render () : void
		{
			addChild ( _ball );
		}
	}
}