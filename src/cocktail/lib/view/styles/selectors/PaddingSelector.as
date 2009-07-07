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
	 * Provides all Padding property selectors
	 * @author nybras | nybras@codeine.it
	 */
	public class PaddingSelector extends Selector
	{
		/* ---------------------------------------------------------------------
			CONSTANTS
		--------------------------------------------------------------------- */
		
		public static const PADDING : String = "padding";
		public static const PADDING_LEFT : String = "padding-left";
		public static const PADDING_TOP : String = "padding-top";
		public static const PADDING_RIGHT : String = "padding-right";
		public static const PADDING_BOTTOM : String = "padding-bottom";
		
		
		
		/* ---------------------------------------------------------------------
			PROPERTIES
		--------------------------------------------------------------------- */
		
		/**
	 	* Get the padding for padding.
	 	* @return	The padding for padding.
	 	*/
		public function get padding () : String
		{
			return r ( PADDING );
		}
	
		/**
	 	* Specifies the padding for padding.
	 	* @param value	Possible values are: length, %, inherit.
	 	*/
		public function set padding ( value : * ) : void {
			w ( PADDING, value );
		}



		/**
	 	* Get the padding-left for padding.
	 	* @return	The padding-left for padding.
	 	*/
		public function get padding_left () : String
		{
			return r ( PADDING_LEFT );
		}
	
		/**
	 	* Specifies the padding-left for padding.
	 	* @param value	Possible values are: length, %, inherit.
	 	*/
		public function set padding_left ( value : * ) : void {
			w ( PADDING_LEFT, value );
		}



		/**
	 	* Get the padding-top for padding.
	 	* @return	The padding-top for padding.
	 	*/
		public function get padding_top () : String
		{
			return r ( PADDING_TOP );
		}
	
		/**
	 	* Specifies the padding-top for padding.
	 	* @param value	Possible values are: length, %, inherit.
	 	*/
		public function set padding_top ( value : * ) : void {
			w ( PADDING_TOP, value );
		}



		/**
	 	* Get the padding-top for padding.
	 	* @return	The padding-top for padding.
	 	*/
		public function get padding_right () : String
		{
			return r ( PADDING_RIGHT );
		}
	
		/**
	 	* Specifies the padding-top for padding.
	 	* @param value	Possible values are: length, %, inherit.
	 	*/
		public function set padding_right ( value : * ) : void {
			w ( PADDING_RIGHT, value );
		}



		/**
	 	* Get the padding-bottom for padding.
	 	* @return	The padding-bottom for padding.
	 	*/
		public function get padding_bottom () : String
		{
			return r ( PADDING_BOTTOM );
		}
	
		/**
	 	* Specifies the padding-bottom for padding.
	 	* @param value	Possible values are: length, %, inherit.
	 	*/
		public function set padding_bottom ( value : * ) : void {
			w ( PADDING_BOTTOM, value );
		}
	}
}