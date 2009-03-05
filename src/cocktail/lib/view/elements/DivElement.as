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
	import cocktail.core.connectors.MotionConnector;
	import cocktail.core.data.dao.style.StyleDivDAO;
	import cocktail.lib.view.elements.Element;
	
	import flash.display.Sprite;

	/**
	 * @author nybras | nybras@codeine.it
	 */
	public class DivElement extends Element 
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

		private var ownStyle : StyleDivDAO;

		public function DivElement () {}
		
		/**
		 * before_render	render the btn element.
		 */
		override public function before_render () : void 
		{
			super.before_render();
			
			ownStyle = style() as StyleDivDAO;
			
			sprite.mouseChildren = true;
			
			bg = new Sprite( );
			
			if ( ownStyle.bg ) 
				bg.graphics.beginFill( ( !isNaN( ownStyle.bg_color ) ? ownStyle.bg_color : defaultBgColor ), defaultBgAlpha );
			else
				bg.graphics.beginFill( 0, 0 );
			
			bg.graphics.drawRect( 0, 0, ( !isNaN( ownStyle.bg_width ) ? ownStyle.bg_width : sprite.width ), ( !isNaN( ownStyle.bg_height ) ? ownStyle.bg_height : sprite.height ) );
			sprite.addChildAt( bg, 0 );
			
			bg.alpha = ( !isNaN( ownStyle.bg_alpha ) ? ownStyle.bg_alpha : defaultBgAlpha );
			bgMotion = new MotionConnector( bg );	
			
			if ( ownStyle.border ) 
			{
				border = new Sprite( );
				border.graphics.lineStyle( ownStyle.border_size, ( isNaN( ownStyle.border_color ) ? ownStyle.border_color : defaultBorderColor ), ( isNaN( ownStyle.border_alpha ) ? ownStyle.border_alpha : defaultBorderAlpha ) );
				border.graphics.moveTo( 0, 0 ); 
				border.graphics.lineTo( bg.width, 0 );
				border.graphics.lineTo( bg.width, bg.height );
				border.graphics.lineTo( 0, sprite.height );
				border.graphics.lineTo( 0, 0 );
				sprite.addChild( border );
				
				borderMotion = new MotionConnector( border );
			}
		}
	}
}
