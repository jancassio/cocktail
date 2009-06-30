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
	 * Handles all position properties.
	 * @author nybras | nybras@codeine.it
	 */
	public class PositionSelector extends Selector
	{
		/* ---------------------------------------------------------------------
			CONSTANTS
		--------------------------------------------------------------------- */
		
		public static const LEFT : String = "left";
		public static const TOP : String = "top";
		public static const RIGHT : String = "right";
		public static const BOTTOM : String = "bottom";
		public static const ALIGN : String = "align";
		public static const VALIGN : String = "valign";
		public static const BACKGROUND_COLOR : String = "background-color";
		
		
		
		/* ---------------------------------------------------------------------
			PROPERTIES
		--------------------------------------------------------------------- */
		
		/**
		 * Gets the bottom margin edge for a positioned box.
		 * @return	The bottom margin edge.
		 */
		public function get left () : String { return r ( LEFT ); }
		
		/**
		 * Sets the left margin edge for a positioned box.
		 * @param left	Possible valus are: <br/>
		 * 				auto<br/>
		 *				length<br/>
		 *				%<br/>
						inherit<br/>
		 */
		public function set left ( left : * ) : void {
			w ( LEFT, left );
		}
		
		
		
		/**
		 * Gets the top margin edge for a positioned box.
		 */
		public function get top () : String { return r( TOP ); }
		
		/**
		 * Sets the top margin edge for a positioned box.
		 * @param top	Possible valus are: <br/>
		 * d
		 */
		public function set top ( top : * ) : void { w( TOP, top ); }
		
		
		
		/**
		 * TODO - add documentation
		 */
		public function get right () : String { return r ( RIGHT ); }
		
		/**
		 * TODO - add documentation
		 */
		public function set right ( right : * ) : void { w ( RIGHT, right ); }
		
		/**
		 * Gets the bottom margin edge for a positioned box.
		 * @return	The bottom margin edge.
		 */
		public function get bottom () : String { return r ( BOTTOM ); }
		
		/**
		 * Sets the bottom margin edge for a positioned box.
		 */
		public function set botton ( bottom : * ) : void { w ( BOTTOM, bottom ); }
		
		
		
		/**
		 * TODO - add documentation
		 */
		public function get align () : String { return r ( ALIGN ); }
		
		/**
		 * TODO - add documentation
		 */
		public function set align ( align : * ) : void { w ( ALIGN, align ); }
		
		
		
		/**
		 * TODO - add documentation
		 */
		public function get valign () : String { return r ( VALIGN ); }
		
		/**
		 * TODO - add documentation
		 */
		public function set valign ( valign : * ) : void { w ( VALIGN, valign ); }
	}
}