package cocktail.lib.view.ui.events 
{	import cocktail.lib.View;	

	/**	 * @author nybras | nybras@codeine.it	 */	public class UIEvent extends View 
	{
//		protected var _listening : Boolean;
//		protected var _dispatcher: EventDispatcher;
//		protected var _listeners : *;
//		
//		
//		public function before_init () : void
//		{
//			_listeners = {};
//		}
//		
//		public function get listen(): UIEvent
//		{
//			_listening = true;
//			return this;
//		}
//		
//		public function get unlisten(): UIEvent
//		{
//			_listening = false;
//			return this;
//		}
//		
//		
//		
//		private function handle ( type : String, handler : Function, params : Array = [] ) : void
//		{
//			var stack : Array;
//			
//			stack = ( _listeners [ type ] || _listeners [ type ] = [] );
//			
//			if ( _listening )
//			{
//				stack.push( {
//					type : type,
//					handler : handler,
//					proxy : ( handler = proxy ( handler, params ) )
//				} );
//				
//				_sprite.addEventListener( type, handler, false, 0, true );
//			}
//			else if ( stack.length )
//			{
//				// ...
//				
//			}
//		}
//		
//		
//		
//		public function rollover( handler : Function, params : Array = [] ): UIEvent
//		{
//			handle( MouseEvent.ROLL_OVER, handler, params );
//			return this;
//		}
//		
//		public function rollout( handler : Function, params : Array = [] ): UIEvent
//		{
//			handle( MouseEvent.ROLL_OVER, handler, params );
//			return this;
//		}
	}}