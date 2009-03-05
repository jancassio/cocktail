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
	import cocktail.core.data.dao.layout.LayoutItemDAO;
	import cocktail.core.data.dao.layout.LayoutRadiobuttonDAO;
	import cocktail.core.data.dao.style.StyleRadiobuttonDAO;
	import cocktail.lib.view.elements.Element;
	import cocktail.utils.StringUtil;
	
	import flash.display.Sprite;	

		/**
	 * @author carlos
	 */
	public class RadiobuttonElement extends Element {
		
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _checked : Boolean;
		private var bg : Sprite;
		private var marker : Sprite;
		private var _value : String;
		
		
		/* ---------------------------------------------------------------------
			CONTROL VARS
		--------------------------------------------------------------------- */

		private var ownStyle : StyleRadiobuttonDAO;

		
		
		/* ---------------------------------------------------------------------
			GETTERS & SETTERS
		--------------------------------------------------------------------- */
		
		public function set checked ( value : Boolean ) : void
		{
			marker.visible = _checked = value;
		}
		
		public function get checked () : Boolean
		{
			return _checked;
		}
		
		public function get value () : String
		{
			return _value;
		}  

		
		/* ---------------------------------------------------------------------
			RENDERING
		--------------------------------------------------------------------- */
		
		public override function before_render () : void
		{
			var content : String;
			var bindExp : String;
			
			super.before_render();
			
			// CONTENT
			content = info.xml;
			
			// BINDING
			for each ( bindExp in StringUtil.enclosure( content, "{", "}" ) )
				content = content.replace( bindExp, bind.g ( StringUtil.innerb( bindExp ) ) );
			
			_value = content;
			
			draw();
		}
		
		
		private function draw () : void
		{
						
			bg = new Sprite();
			marker = new Sprite();
			
			ownStyle = style( ) as StyleRadiobuttonDAO;	
			
			sprite.buttonMode = true;
			
			bg.graphics.beginFill( ownStyle.bg_color, 1 );
			bg.graphics.drawCircle( 0 , 0 , ownStyle.width );
			bg.x = ownStyle.width;
			bg.y = ownStyle.width;
			sprite.addChild( bg );
			
			marker.graphics.beginFill( ownStyle.marker_color, 1 );
			marker.graphics.drawCircle( 0 , 0 , ownStyle.width / 2 );
			marker.visible = _checked = LayoutRadiobuttonDAO( info ).selected;
			bg.addChild( marker );
			
		}
		
	}
}
