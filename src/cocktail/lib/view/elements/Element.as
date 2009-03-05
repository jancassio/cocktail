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

package cocktail.lib.view.elements {	import cocktail.core.data.dao.style.StyleDAO;	import cocktail.lib.View;			/**	 * Element base class.	 * 	 * @author nybras | nybras@codeine.it	 * @see View	 */	public class Element extends View	{				public function before_render () : void		{			sprite.visible = false;		}				public function after_render () : void		{			var tmp_style : StyleDAO;			var x : uint;			var y : uint;						tmp_style = style();						switch ( tmp_style.align )			{				case "left": x = 0; break;				case "center": x = ( ( up.sprite.width - sprite.width ) / 2 ); break;				case "right": x = ( up.sprite.width - sprite.width ); break;			}						switch ( tmp_style.valign )			{				case "top": y = 0; break;				case "middle":					y = ( ( up.sprite.height - sprite.height ) / 2 );					if ( this is TxtElement )						y -= 3;				break;				case "bottom":					y = ( up.sprite.height - sprite.height );					if ( this is TxtElement )						y -= 3;				break;			}						sprite.x = ( x || sprite.x );			sprite.y = ( y || sprite.y );						sprite.visible = true;		}	}}