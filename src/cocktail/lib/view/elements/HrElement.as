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

package cocktail.lib.view.elements {	import cocktail.core.data.dao.style.StyleDAO;	import cocktail.core.data.dao.style.StyleHrDAO;	import cocktail.lib.View;		import flash.display.DisplayObject;	import flash.display.Sprite;		/**	 * Cocktail base hr element.	 * @author Gustavo Castro	 */	public class HrElement extends Element 	{		/* ---------------------------------------------------------------------			VARS		--------------------------------------------------------------------- */				private var own_style : StyleHrDAO;		private var line : Sprite;								/* ---------------------------------------------------------------------			RENDERING		--------------------------------------------------------------------- */				/**		 * Overwirte the 		 */		override public function after_render () : void 		{			var auto_width : uint;						super.after_render();						own_style = ( style() as StyleHrDAO );			auto_width = ( up.sprite.width - ( up.style().padding_left + up.style().padding_right ) );						line = new Sprite ();			line.graphics.lineStyle( own_style.thickness, own_style.color, own_style.alpha );			line.graphics.lineTo( ( own_style.width || auto_width ),  0 );						sprite.addChild( line );		}	}}