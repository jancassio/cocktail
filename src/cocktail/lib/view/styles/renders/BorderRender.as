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
	import cocktail.lib.view.styles.values.vos.border.BorderVo;	
	import cocktail.lib.view.styles.renders.Render;
	import cocktail.lib.view.styles.selectors.BorderSelector;	
	
	/**
	 * Render all Border properties
	 * @author nybras | nybras@codeine.it
	 */
	public class BorderRender extends Render 
	{
		/* ---------------------------------------------------------------------
			RENDER
		--------------------------------------------------------------------- */
		
		/**
		 * Start the automagic live rendering. 
		 */
		public function render () : void
		{
			_style.plug( BorderSelector.BORDER, _border );
			_style.plug( BorderSelector.BORDER_COLOR, _border_color );
			_style.plug( BorderSelector.BORDER_WIDTH, _border_width );
			_style.plug( BorderSelector.BORDER_STYLE, _border_style );
			_style.plug( BorderSelector.BORDER_RADIUS, _border_radius );
			_style.plug( BorderSelector.BORDER_OPACITY, _border_opacity );
			_style.plug( BorderSelector.BORDER_LEFT, _border_left );
			_style.plug( BorderSelector.BORDER_LEFT_COLOR, _border_left_color );
			_style.plug( BorderSelector.BORDER_LEFT_WIDTH, _border_left_width );
			_style.plug( BorderSelector.BORDER_LEFT_STYLE, _border_left_style );
			_style.plug( BorderSelector.BORDER_LEFT_RADIUS, _border_left_radius );
			_style.plug( BorderSelector.BORDER_LEFT_OPACITY, _border_left_opacity );
			_style.plug( BorderSelector.BORDER_TOP, _border_top );
			_style.plug( BorderSelector.BORDER_TOP_COLOR, _border_top_color );
			_style.plug( BorderSelector.BORDER_TOP_WIDTH, _border_top_width );
			_style.plug( BorderSelector.BORDER_TOP_STYLE, _border_top_style );
			_style.plug( BorderSelector.BORDER_TOP_RADIUS, _border_top_radius );
			_style.plug( BorderSelector.BORDER_TOP_OPACITY, _border_top_opacity );
			_style.plug( BorderSelector.BORDER_RIGHT, _border_right );
			_style.plug( BorderSelector.BORDER_RIGHT_COLOR, _border_right_color );
			_style.plug( BorderSelector.BORDER_RIGHT_WIDTH, _border_right_width );
			_style.plug( BorderSelector.BORDER_RIGHT_STYLE, _border_right_style );
			_style.plug( BorderSelector.BORDER_RIGHT_RADIUS, _border_right_radius );
			_style.plug( BorderSelector.BORDER_RIGHT_OPACITY, _border_right_opacity );
			_style.plug( BorderSelector.BORDER_BOTTOM, _border_bottom );
			_style.plug( BorderSelector.BORDER_BOTTOM_COLOR, _border_bottom_color );
			_style.plug( BorderSelector.BORDER_BOTTOM_WIDTH, _border_bottom_width );
			_style.plug( BorderSelector.BORDER_BOTTOM_STYLE, _border_bottom_style );
			_style.plug( BorderSelector.BORDER_BOTTOM_RADIUS, _border_bottom_radius );
			_style.plug( BorderSelector.BORDER_BOTTOM_OPACITY, _border_bottom_opacity );
		}
		
		
		
		/* ---------------------------------------------------------------------
			PROPERTIES
		--------------------------------------------------------------------- */
		
		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border_color( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border_width( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border_style( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border_radius( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border_opacity( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border_left( value : * ) : void
		{
			// TODO: implement method
		}
		
		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border_left_color( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border_left_width( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border_left_style( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border_left_radius( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border_left_opacity( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border_top( value : * ) : void
		{
			var border: BorderVo;

			border = new BorderVo( value );
			
			_border_top_width( border.border_width );
			_border_top_color( border.border_color );
			_border_top_style( border.border_style );
			
			trace( ' top border ->' + value );
		}
		
		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border_top_color( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border_top_width( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border_top_style( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border_top_radius( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border_top_opacity( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border_right( value : * ) : void
		{
			// TODO: implement method
		}
		
		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border_right_color( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border_right_width( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border_right_style( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border_right_radius( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border_right_opacity( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border_bottom( value : * ) : void
		{
			// TODO: implement method
		}
		
		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border_bottom_color( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border_bottom_width( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border_bottom_style( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border_bottom_radius( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _border_bottom_opacity( value : * ) : void
		{
			// TODO: implement method
		}
	}
}