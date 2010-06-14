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

package cocktail.lib.view.styles.selectors 
{
	import cocktail.lib.view.styles.selectors.Selector;					

	/**
	 * Provides all Position property selectors
	 * @author nybras | nybras@codeine.it
	 */
	public class PositionSelector extends Selector
	{
		/* ---------------------------------------------------------------------
			CONSTANTS
		--------------------------------------------------------------------- */
		
		public static const POSITION : String = "position";
		public static const LEFT : String = "left";
		public static const TOP : String = "top";
		public static const RIGHT : String = "right";
		public static const BOTTOM : String = "bottom";
		public static const ALIGN : String = "align";
		public static const OVERFLOW : String = "overflow";
		public static const OVERFLOW_X : String = "overflow-x";
		public static const OVERFLOW_Y : String = "overflow-y";
		public static const Z_INDEX : String = "z-index";
		public static const SNAP : String = "snap";
		public static const SNAP_LEFT : String = "snap-left";
		public static const SNAP_TOP : String = "snap-top";
		public static const SNAP_SCALE : String = "snap-scale";
		
		
		
		/* ---------------------------------------------------------------------
			PROPERTIES
		--------------------------------------------------------------------- */
		
		/**
	 	* Gets the type of positioning for an element.
	 	* @return	The positionin type.
	 	*/
		public function get position () : String
		{
			return r( POSITION );
		}
		
//		/**
//	 	* Specifies the type of positioning for an element.
//	 	* @return	The positionin type.
//	 	*/
//		public function set position (  ) : String
//		{
//			return r ( POSITION );
//		}
		
		/**
	 	* Get the left for position.
	 	* @return	The left for position.
	 	*/
		public function get left () : String
		{
			return r ( LEFT );
		}
	
		/**
	 	* Specifies the left for position.
	 	* @param value	Possible values are: auto, length, %, inherit.
	 	*/
		public function set left ( value : * ) : void
		{
			w ( LEFT, value );
		}



		/**
	 	* Get the top for position.
	 	* @return	The top for position.
	 	*/
		public function get top () : String
		{
			return r ( TOP );
		}
	
		/**
	 	* Specifies the top for position.
	 	* @param value	Possible values are: auto, length, %, inherit.
	 	*/
		public function set top ( value : * ) : void
		{
			w ( TOP, value );
		}



		/**
	 	* Get the right for position.
	 	* @return	The right for position.
	 	*/
		public function get right () : String
		{
			return r ( RIGHT );
		}
	
		/**
	 	* Specifies the right for position.
	 	* @param value	Possible values are: auto, length, %, inherit.
	 	*/
		public function set right ( value : * ) : void
		{
			w ( RIGHT, value );
		}



		/**
	 	* Get the bottom for position.
	 	* @return	The bottom for position.
	 	*/
		public function get bottom () : String
		{
			return r ( BOTTOM );
		}
	
		/**
	 	* Specifies the bottom for position.
	 	* @param value	Possible values are: auto, length, %, inherit.
	 	*/
		public function set bottom ( value : * ) : void
		{
			w ( BOTTOM, value );
		}



		/**
	 	* Get the align for position.
	 	* @return	The align for position.
	 	*/
		public function get align () : String
		{
			return r ( ALIGN );
		}
	
		/**
	 	* Specifies the align for position.
	 	* @param value	Possible values are: left, top, right, bottom.
	 	*/
		public function set align ( value : * ) : void
		{
			w ( ALIGN, value );
		}



		/**
	 	* Get the overflow for position.
	 	* @return	The overflow for position.
	 	*/
		public function get overflow () : String
		{
			return r ( OVERFLOW );
		}
	
		/**
	 	* Specifies the overflow for position.
	 	* @param value	Possible values are: auto, hidden, scroll, visible,
	 	* inherit.
	 	*/
		public function set overflow ( value : * ) : void
		{
			w ( OVERFLOW, value );
		}



		/**
	 	* Get the overflow-x for position.
	 	* @return	The overflow-x for position.
	 	*/
		public function get overflow_x () : String
		{
			return r ( OVERFLOW_X );
		}
	
		/**
	 	* Specifies the overflow-x for position.
	 	* @param value	Possible values are: auto, hidden, scroll, visible,
	 	* inherit.
	 	*/
		public function set overflow_x ( value : * ) : void
		{
			w ( OVERFLOW_X, value );
		}



		/**
	 	* Get the overflow-y for position.
	 	* @return	The overflow-y for position.
	 	*/
		public function get overflow_y () : String
		{
			return r ( OVERFLOW_Y );
		}
	
		/**
	 	* Specifies the overflow-y for position.
	 	* @param value	Possible values are: auto, hidden, scroll, visible,
	 	* inherit.
	 	*/
		public function set overflow_y ( value : * ) : void
		{
			w ( OVERFLOW_Y, value );
		}



		/**
	 	* Get the z-index for position.
	 	* @return	The z-index for position.
	 	*/
		public function get z_index () : String
		{
			return r ( Z_INDEX );
		}
	
		/**
	 	* Specifies the z-index for position.
	 	* @param value	Possible values are: number, auto, inherit.
	 	*/
		public function set z_index ( value : * ) : void
		{
			w ( Z_INDEX, value );
		}
		
		
		
		/**
	 	* TODO: write docs
	 	*/
		public function get snap () : String
		{
			return r ( SNAP );
		}
		
		/**
	 	* TODO: write docs
	 	*/
		public function set snap ( value : * ) : void
		{
			w ( SNAP, value );
			w ( SNAP_LEFT, value );
			w ( SNAP_TOP, value );
			w ( SNAP_SCALE, value );
		}
		
		/**
	 	* TODO: write docs
	 	*/
		public function get snap_left () : String
		{
			return r ( SNAP );
		}
		
		/**
	 	* TODO: write docs
	 	*/
		public function set snap_left ( value : * ) : void
		{
			w ( SNAP, value );
		}
		
		/**
	 	* TODO: write docs
	 	*/
		public function get snap_top () : String
		{
			return r ( SNAP );
		}
		
		/**
	 	* TODO: write docs
	 	*/
		public function set snap_top ( value : * ) : void
		{
			w ( SNAP, value );
		}
		
		/**
	 	* TODO: write docs
	 	*/
		public function get snap_scale () : String
		{
			return r ( SNAP );
		}
		
		/**
	 	* TODO: write docs
	 	*/
		public function set snap_scale ( value : * ) : void
		{
			w ( SNAP, value );
		}
	}
}