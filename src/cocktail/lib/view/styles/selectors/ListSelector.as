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
	 * Provides all List property selectors
	 * @author nybras | nybras@codeine.it
	 */
	public class ListSelector extends Selector
	{
		/* ---------------------------------------------------------------------
			CONSTANTS
		--------------------------------------------------------------------- */
		
		public static const LIST_STYLE_TYPE : String = "list-style-type";
		public static const LIST_STYLE_POSITION : String = "list-style-position";
		public static const LIST_STYLE_IMAGE : String = "list-style-image";
		public static const LIST_STYLE : String = "list-style";
		
		
		
		/* ---------------------------------------------------------------------
			PROPERTIES
		--------------------------------------------------------------------- */
		
		/**
	 	* Get the list-style-type for list.
	 	* @return	The list-style-type for list.
	 	*/
		public function get list_style_type () : String
		{
			return r ( LIST_STYLE_TYPE );
		}
	
		/**
	 	* Specifies the list-style-type for list.
	 	* @param value	Possible values are: none, disc, circle, square, decimal,
	 	* decimal-leading-zero, armenian, georgian, lower-alpha, upper-alpha,
	 	* lower-greek, lower-latin, upper-latin, lower-roman, upper-roman,
	 	* inherit.
	 	*/
		public function set list_style_type ( value : * ) : void {
			w ( LIST_STYLE_TYPE, value );
		}



		/**
	 	* Get the list-style-position for list.
	 	* @return	The list-style-position for list.
	 	*/
		public function get list_style_position () : String
		{
			return r ( LIST_STYLE_POSITION );
		}
	
		/**
	 	* Specifies the list-style-position for list.
	 	* @param value	Possible values are: inside, outside, inherit.
	 	*/
		public function set list_style_position ( value : * ) : void {
			w ( LIST_STYLE_POSITION, value );
		}



		/**
	 	* Get the list-style-image for list.
	 	* @return	The list-style-image for list.
	 	*/
		public function get list_style_image () : String
		{
			return r ( LIST_STYLE_IMAGE );
		}
	
		/**
	 	* Specifies the list-style-image for list.
	 	* @param value	Possible values are: URL, none, inherit.
	 	*/
		public function set list_style_image ( value : * ) : void {
			w ( LIST_STYLE_IMAGE, value );
		}



		/**
	 	* Get the list-style for list.
	 	* @return	The list-style for list.
	 	*/
		public function get list_style () : String
		{
			return r ( LIST_STYLE );
		}
	
		/**
	 	* Specifies the list-style for list.
	 	* @param value	Possible values are: list-style-type,
	 	* list-style-position, list-style-image, inherit.
	 	*/
		public function set list_style ( value : * ) : void {
			w ( LIST_STYLE, value );
		}
	}
}