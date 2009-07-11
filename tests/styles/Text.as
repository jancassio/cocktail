package styles 
{
	import cocktail.lib.view.styles.Styles;
	import cocktail.lib.view.styles.gunz.StylesBullet;
	import cocktail.lib.view.styles.renders.Render;
	import cocktail.lib.view.styles.renders.TextRender;
	
	import flash.display.Sprite;
	import flash.text.TextField;		

	/**
	 * @author nybras | nybras@codeine.it
	 */
	public class Text extends Sprite 
	{
		private var _field : TextField;
		private var _styles : Styles;
		private var _render : TextRender;

		public function Text()
		{
			_draw();
			_load();
		}

		private function _draw() : void
		{
			_field = new TextField();
		}

		private function _load() : void
		{
			_styles = new Styles ( "style-test.fss" );
			_styles.listen.complete( _plug );
		}
		
		private function _plug ( bullet : StylesBullet ) : void
		{
			bullet;
			
			_render = new TextRender();
			_render.boot( _styles, _field, "body" );
			_field.htmlText = "<h1>COCKTAIL</h1>";
			_render.render();
			
			
			render();
		}
		
		private function render () : void
		{
			addChild ( _field );
		}
	}
}