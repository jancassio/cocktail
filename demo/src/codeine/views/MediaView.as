package codeine.views 
{
	import cocktail.core.data.dao.ProcessDAO;
	
	import codeine.AppView;
	
	import flash.display.MovieClip;	
	/**
	 * @author kreigne
	 */
	public class MediaView extends AppView 
	{
		private var _eclipse : MovieClip;
		private var _buttons : Array;
		private var _triggers : Array;
								

		public function before_render () : void
		{
			_sprite.alpha = 0;
			
//			_eclipse = MovieClip( child( "body.files.col-right.swf.timeline" )._holder );
			_buttons = child( "body.files.col-right.menu" ).childs( );
			_triggers = [];
			
		}

		public function after_render () : void
		{
//			var button : BtnElement;
//			var trigger : Function;
//			
//			_eclipse.stop( );
//			
//			for each ( button in _buttons ) {
//				trigger = proxy( button_click, button );
//				_triggers.push( trigger );
//				
//				button.sprite.addEventListener( MouseEvent.ROLL_OVER , trigger );
//			}
//			
//			motion.alpha( 1, .5 ).listen( render_done );
		}
		
		public function before_destroy ( dao : ProcessDAO ) : void
		{
//			var button : BtnElement;
//			var trigger : Function;
//			var i : uint;
//			
//			i = 0;
//			
//			for each ( button in _buttons ) 
//			{
//				trigger = _triggers[ i ];
//				button.sprite.removeEventListener( MouseEvent.CLICK, trigger );
//				i++;
//				
//				trace ( "triggado!! "+ button );
//			}
//			
//			dao;
//			motion.alpha( 0, .5 ).listen( destroy_done );
		}
		
//		private function button_click ( button : BtnElement, event : MouseEvent ) : void
//		{	
//			trace ( _eclipse +".gotoAndStop ( "+ button.info.id.split( "-" ).pop( ) +" )" );
//			_eclipse.gotoAndStop( button.info.id.split( "-" ).pop( ) );
//		}
	}
}
