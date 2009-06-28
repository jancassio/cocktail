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

package cocktail.lib.view.styles.renders 
{
	import cocktail.core.Index;
	import cocktail.lib.view.styles.Style;
	
	import flash.display.Sprite;	

	/**
	 * Render base class.
	 * @author nybras | nybras@codeine.it
	 */
	public class Render extends Index 
	{
		
		protected var _style : Style;
		protected var _target: Sprite;
		
		
		
		public function boot ( target : Sprite, style : Style ) : void
		{
			_style = style;
			_target = target;
		}
		
		protected function _is_percent ( value : * ) : Boolean
		{
			return /^([0-9.]+)(%|px)?/.test( value );
		}
		
		protected function _clear_unit ( value : String ) : String
		{
			var r : RegExp = /[0-9.]+/;
			return value.match( r )[ 0 ];
		}
	}
}