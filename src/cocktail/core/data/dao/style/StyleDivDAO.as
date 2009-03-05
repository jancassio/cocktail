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

package cocktail.core.data.dao.style 
{
	import cocktail.core.data.dao.style.StyleDAO;	

	/**
	 * @author carlos
	 */
	public class StyleDivDAO extends StyleDAO 
	{
		// BORDER
		public var border : Boolean = false;
		public var border_color : Number;
		public var border_alpha : Number = 1;
		public var border_size : Number = 1;
		public var border_over_color : Number;
		public var border_over_alpha : Number = 1;
		
		// BG
		public var bg : Boolean = false;
		public var bg_color : Number = 0xffffff;
		public var bg_alpha : Number = 1;
		public var bg_over_color : Number;
		public var bg_over_alpha : Number = 1;
		public var bg_width : Number;
		public var bg_over_width : Number;
		public var bg_height : Number;
		public var bg_over_height : Number;
		
		public function StyleDivDAO ( item : XML = null ) 
		{
			super( item );
		}
	}
}
