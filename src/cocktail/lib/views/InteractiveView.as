package cocktail.lib.views 
{
	import cocktail.core.gunz.Gun;
	import cocktail.lib.View;

	/**
	 * @author hems | henriquematias.com
	 */
	public class InteractiveView extends View
	{
		private var _on_click : Gun;

		private var _on_mouse_over : Gun;

		private var _on_roll_over : Gun;

		private var _on_mouse_out : Gun;

		private var _on_roll_out : Gun;

		private var _on_mouse_up : Gun;

		private var _on_mouse_down : Gun;

		private var _on_double_click : Gun;

		/**
		 * Override super method just to add triggers to view
		 */		
		override protected function _instantiate_display() : * 
		{
			var r: *;
			
			r = super._instantiate_display( );
			
			set_triggers();
			
			return r; 
		}

		
		/**
		 * Will check if user customized some events, if so, will plug
		 * then for the user.
		 * 
		 * Called automatically once - when creating the view sprite
		 */
		public function set_triggers() : void 
		{
			if( is_defined( 'click' ) )
				on_click.add( this[ 'click' ] );
			
			if( is_defined( 'mouse_over' ) )
				on_mouse_over.add( this[ 'mouse_over' ] );
				
			if( is_defined( 'roll_over' ) )
				on_roll_over.add( this[ 'roll_over' ] );
				
			if( is_defined( 'mouse_out' ) )
				on_mouse_out.add( this[ 'mouse_out' ] );
				
			if( is_defined( 'roll_out' ) )
				on_roll_out.add( this[ 'on_roll_out' ] );
			
			if( is_defined( 'mouse_up' ) )
				on_mouse_up.add( this[ 'mouse_up' ] );
				
			if( is_defined( 'mouse_down' ) )
				on_mouse_down.add( this[ 'mouse_down' ] );
			
			if( is_defined( 'double_click' ) )
				on_double_click.add( this[ 'double_click' ] );
		}
		
		public function get on_click( ): Gun
		{
			if( _on_click ) return _on_click;
			
			return _on_click = listen( sprite, "click" ); 
		}

		public function get on_mouse_over( ): Gun
		{
			if( _on_mouse_over ) return _on_mouse_over;
			
			_on_mouse_over = listen( sprite, "mouseOver" );
			
			return _on_mouse_over;  
		}

		public function get on_roll_over( ): Gun
		{
			if( _on_roll_over ) return _on_roll_over;
			
			_on_roll_over = listen( sprite, "rollOver" );
			
			return _on_roll_over;  
		}

		public function get on_mouse_out( ): Gun
		{
			if( _on_mouse_out ) return _on_mouse_out;
			
			_on_mouse_out = listen( sprite, "mouseOut" );
			return _on_mouse_out; 
		}

		public function get on_roll_out( ): Gun
		{
			if( _on_roll_out ) return _on_roll_out;
			
			_on_roll_out = listen( sprite, "rollOut" ); 
			
			return _on_roll_out; 
		}

		public function get on_mouse_up( ): Gun
		{
			if( _on_mouse_up ) return _on_mouse_up;
			
			_on_mouse_up = listen( sprite, "mouseUp" ); 
			
			return _on_mouse_up; 
		}

		public function get on_mouse_down( ): Gun
		{
			if( _on_mouse_down ) return on_mouse_down;
			
			_on_mouse_down = listen( sprite, "mouseDown" );
			
			return _on_mouse_down; 
		}

		public function get on_double_click( ): Gun
		{
			if( _on_double_click ) return _on_double_click;
			
			_on_double_click = listen( sprite, "doubleClick" );
			 
			return _on_double_click; 
		}
	}
}
