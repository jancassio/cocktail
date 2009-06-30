package  
{
	import cocktail.lib.view.styles.Styles;
	import cocktail.lib.view.styles.gunz.StylesBullet;
	import cocktail.lib.view.styles.renders.PositionRender;
	import cocktail.lib.view.styles.renders.Render;
	
	import flash.display.Sprite;	

	/**
	 * @author nybras | nybras@codeine.it
	 */
	public class StylesTest extends Sprite 
	{
		private var _styles : Styles;
		private var _pos_render : PositionRender;
		
		public function StylesTest()
		{
			load_style();
		}
		
		private function load_style() : void
		{
			_styles = new Styles ( "style-test.fss");
			_styles.listen.complete( _boot_render );
		}
		
		private function _boot_render ( bullet : StylesBullet ) : void
		{
			bullet;
			_pos_render = new PositionRender();
			_pos_render.boot( this, _styles.get( "just-a-test" ) );
		}
	}
}