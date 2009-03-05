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

package cocktail.lib.view.elements {
	import cocktail.core.data.dao.style.StyleCheckDAO;
	import cocktail.core.data.dao.style.StyleDAO;
	import cocktail.lib.view.elements.Element;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;		

	/**
	 * @author carlos
	 */
	public class CheckElement extends Element 
	{
		
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _checked : Boolean;
		private var bg : Sprite;
		private var border : Sprite;
		private var marker : Sprite;
		
		
		/* ---------------------------------------------------------------------
			CONTROL VARS
		--------------------------------------------------------------------- */

		private var ownStyle : StyleCheckDAO;

		
		
		/* ---------------------------------------------------------------------
			GETTERS & SETTERS
		--------------------------------------------------------------------- */
		
		public function set checked ( value : Boolean ) : void
		{
			_checked = value;
		}
		
		public function get checked () : Boolean
		{
			return _checked;
		}  
		
		
		/* ---------------------------------------------------------------------
			RENDERING
		--------------------------------------------------------------------- */
		
		public override function before_render () : void
		{
			super.before_render();
			draw();
		}
		
		
		private function draw () : void
		{
			
			bg = new Sprite();			
			//border = new Sprite();
			marker = new Sprite();
			
			ownStyle = style( ) as StyleCheckDAO;	
			
			sprite.buttonMode = true;
			
			//BG
			bg = new Sprite();
			bg.graphics.beginFill( ownStyle.bg_color );
			bg.graphics.drawRect( 0, 0, ownStyle.width, ownStyle.height );
			sprite.addChild( bg );
			
//			//BORDER
//			border.graphics.lineStyle( ownStyle.thickness, ownStyle.border_color );
//			border.graphics.lineTo( ownStyle.width, 0 );
//			border.graphics.lineTo( ownStyle.width, ownStyle.height );
//			border.graphics.lineTo( 0, ownStyle.height );
//			border.graphics.lineTo( 0, 0 );
//			bg.addChild( border );
			
			//MARKER
			marker.graphics.lineStyle( 3, ownStyle.marker_color );
			marker.graphics.moveTo( 2, 25 );
			marker.graphics.lineTo( 5, 25 );
			marker.graphics.lineTo( 10, 50 );
			marker.graphics.lineTo( 25, 0 );
			marker.width = ownStyle.width - ownStyle.width * 0.30;
			marker.height = ownStyle.height - ownStyle.height * 0.30;
			marker.x += ownStyle.width * 0.15;
			marker.y += ownStyle.height * 0.15;
			marker.visible = checked;
			
			bg.addChild( marker );
			
			
			sprite.addEventListener( MouseEvent.CLICK, click );
			
		}
		
		
		/* ---------------------------------------------------------------------
			LISTENERS
		--------------------------------------------------------------------- */
		
		private function click ( event : MouseEvent ) : void
		{
			var changeEvent : FocusEvent = new FocusEvent( FocusEvent.FOCUS_OUT );
			
			_checked = !_checked;
			marker.visible = _checked;
			
			sprite.dispatchEvent( changeEvent );
		}
		
		
		
		/* ---------------------------------------------------------------------
			HIGHLIGHT
		--------------------------------------------------------------------- */
		
		/**
		 * Turns highlight on or off.
		 */
		public function highlight ( on : Boolean = true ) : void
		{
			if ( border == null ) {
				border = new Sprite();
				border.graphics.lineStyle( 1, 0xff0000 );
				border.graphics.drawRect( 0, 0, sprite.width, sprite.height );
				border.visible = false;
				sprite.addChild( border );
			}
				
			if ( on )
				border.visible = true;
			else
				border.visible = false;
		}
		
	}
}
