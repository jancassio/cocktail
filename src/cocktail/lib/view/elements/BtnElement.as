/*	****************************************************************************
		Cocktail ActionScript Full Stack Framework. Copyright (C) 2009 Codeine.
	****************************************************************************
   
		This library is free software; you can redistribute it and/or modify
	it under the terms of the GNU Lesser General Public License as published
	by the Free Software Foundation; either version 2.1 of the License, or
	(at your option) any later version.
		
		This library is distributed in the hope that it will be useful, but
	WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
	or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public
	License for more details.

		You should have received a copy of the GNU Lesser General Public License
	along with this library; if not, write to the Free Software Foundation,
	Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

	-------------------------
		Codeine
		http://codeine.it
		contact@codeine.it
	-------------------------
	
*******************************************************************************/

package cocktail.lib.view.elements 
{
	import cocktail.core.connectors.MotionConnector;	import cocktail.core.data.dao.style.StyleBtnDAO;	import cocktail.lib.view.elements.Element;		import flash.display.Sprite;	import flash.events.EventDispatcher;	import flash.events.MouseEvent;		/**
	 * @author Carlos
	 */
	public class BtnElement extends Element 
	{
		/* ---------------------------------------------------------------------
			VISUAL VARS
		--------------------------------------------------------------------- */
		
		public var bg : Sprite;
		public var bgMotion : MotionConnector;
		public var border : Sprite;
		public var borderMotion : MotionConnector;

		
		/* ---------------------------------------------------------------------
			DEFAULT VALUES
		--------------------------------------------------------------------- */

		protected var defaultBgColor : uint = 0x525252;
		protected var defaultBgAlpha : Number = 1;
		protected var defaultBgOverColor : uint = 0x3e3e3e;
		protected var defaultBorderColor : uint = 0;
		protected var defaultBorderAlpha : Number = 1;

		
		
		/* ---------------------------------------------------------------------
			CONTROL VARS
		--------------------------------------------------------------------- */

		private var ownStyle : StyleBtnDAO;
		
		
		
		/* ---------------------------------------------------------------------
			RENDERING
		--------------------------------------------------------------------- */
		
		/**
		 * Invoked before render.
		 */
		override public function before_render () : void 
		{
			super.before_render();
			
			sprite.mouseChildren = false;
			sprite.buttonMode = true;
			
			set_triggers();
			
			draw( style() as StyleBtnDAO );
		}
		
		public function draw ( style : StyleBtnDAO ) : void
		{
			var bg_color : uint;
			var bg_width : uint;
			var bg_height : uint;
			var bg_alpha : Number;
			
			var border_color : uint;
			var border_alpha : uint;
			
			ownStyle = style;
			
			if ( ownStyle.bg ) 
			{
				bg_color = ( !isNaN ( ownStyle.bg_color ) ? ownStyle.bg_color : defaultBgColor );
				bg_width = ( !isNaN ( ownStyle.bg_width ) ? ownStyle.bg_width : sprite.width );
				bg_height = ( !isNaN ( ownStyle.bg_height ) ? ownStyle.bg_height : sprite.height );
				bg_alpha = ( !isNaN ( ownStyle.bg_alpha ) ? ownStyle.bg_alpha : defaultBgAlpha );
				
				if ( bg is Sprite )
					bg.graphics.clear();
				else
					bg = new Sprite( );
				
				bg.alpha = bg_alpha;
				bg.graphics.beginFill( bg_color, defaultBgAlpha );
				bg.graphics.drawRect( 0, 0, bg_width, bg_height );
				sprite.addChildAt( bg, 0 );
				
				bgMotion = new MotionConnector( bg );	
			}
			else if ( bg is Sprite )
				bg.graphics.clear();
			
			if ( ownStyle.border ) 
			{
				border_color = ( ! isNaN( ownStyle.border_color ) ? ownStyle.border_color : defaultBorderColor );
				border_alpha = ( ! isNaN( ownStyle.border_alpha ) ? ownStyle.border_alpha : defaultBorderAlpha );
				
				if ( border is Sprite )
					border.graphics.clear();
				else
					border = new Sprite();
				
				border.graphics.lineStyle( ownStyle.border_size , border_color , border_alpha );
				border.graphics.drawRect( 0, 0, bg_width, bg_height );
				sprite.addChild( border );
				
				borderMotion = new MotionConnector( border );
			}
			else if ( border is Sprite )
				border.graphics.clear();
		}
		
		
		
		
		public function enable () : void
		{
			set_triggers();
		}
		
		public function disable () : void
		{
			unset_triggers();
		}
		
		private function set_triggers () : void
		{
			sprite.addEventListener( MouseEvent.ROLL_OVER, over );
			sprite.addEventListener( MouseEvent.ROLL_OUT, out );
		}
		
		private function unset_triggers () : void
		{
			sprite.removeEventListener( MouseEvent.ROLL_OVER, over );
			sprite.removeEventListener( MouseEvent.ROLL_OUT, out );
		}
		
		
		
		/**
		 * TODO	add comments doc
		 */
		public function over ( event : MouseEvent = null ) : void
		{
			if ( ownStyle.border && !isNaN( ownStyle.border_over_color ) ) 
				borderMotion.tint( ownStyle.border_over_color, 0 );
			
			if ( ownStyle.bg ) 
				bgMotion.tint( ( !isNaN( ownStyle.bg_over_color ) ? ownStyle.bg_over_color : defaultBgOverColor ), 0 );
		}

		/**
		 * TODO	add comments doc
		 */
		public function out ( event : MouseEvent = null ) : void
		{
			if ( ownStyle.border && !isNaN( ownStyle.border_over_color ) ) 
				borderMotion.tint( -1, 0 );
			
			if ( ownStyle.bg ) 
				bgMotion.tint( -1, 0 );
		}
		
		/**
		 * TODO	add comments doc
		 */
		public function clearListeners() : void {
			sprite.removeEventListener( MouseEvent.ROLL_OVER, over );
			sprite.removeEventListener( MouseEvent.ROLL_OUT, out );	
		}				
	}
}
