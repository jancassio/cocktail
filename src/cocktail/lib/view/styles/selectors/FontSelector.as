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
	 * Provides all Font property selectors
	 * @author nybras | nybras@codeine.it
	 */
	public class FontSelector extends Selector
	{
		/* ---------------------------------------------------------------------
			CONSTANTS
		--------------------------------------------------------------------- */
		
		public static const FONT : String = "font";
		public static const FONT_STYLE : String = "font-style";
		public static const FONT_VARIANT : String = "font-variant";
		public static const FONT_WEIGTH : String = "font-weigth";
		public static const FONT_SIZE : String = "font-size";
		public static const FONT_FAMILY : String = "font-family";
		
		
		
		/* ---------------------------------------------------------------------
			PROPERTIES
		--------------------------------------------------------------------- */
		
		/**
	 	* Gets all the font properties in one declaration.
	 	* @return	All the font properties in one declaration.
	 	*/
		public function get font () : String
		{
			return r ( FONT );
		}
	
		/**
	 	* Sets all the font properties in one declaration.
	 	* @param value	Possible values are: font-style, font-variant, font-weight, font-size/line-height, font-family, caption, icon, menu, message-box, small-caption, status-bar, inherit.
	 	*/
		public function set font ( value : * ) : void {
			w ( FONT, value );
		}



		/**
	 	* Gets the text's font style.
	 	* @return	The text's font style.
	 	*/
		public function get font_style () : String
		{
			return r ( FONT_STYLE );
		}
	
		/**
	 	* Specifies the font style for text.
	 	* @param value	Possible values are: normal, italic, oblique, inherit.
	 	*/
		public function set font_style ( value : * ) : void {
			w ( FONT_STYLE, value );
		}



		/**
	 	* Gets the text's font variant.
	 	* @return	The text's font variant.
	 	*/
		public function get font_variant () : String
		{
			return r ( FONT_VARIANT );
		}
	
		/**
	 	* Specifies whether or not a text should be displayed in a small-caps font.
	 	* @param value	Possible values are: normal, small-caps, inherit.
	 	*/
		public function set font_variant ( value : * ) : void {
			w ( FONT_VARIANT, value );
		}



		/**
	 	* Gets the text's font weight.
	 	* @return	The text's font weight.
	 	*/
		public function get font_weigth () : String
		{
			return r ( FONT_WEIGTH );
		}
	
		/**
	 	* Specifies the weight of a font.
	 	* @param value	Possible values are: normal, bold, bolder, lighter, 100, 200, 300, 400, 500, 600, 700, 800, 900, inherit.
	 	*/
		public function set font_weigth ( value : * ) : void {
			w ( FONT_WEIGTH, value );
		}



		/**
	 	* Gets the the text's font size.
	 	* @return	The the text's font size.
	 	*/
		public function get font_size () : String
		{
			return r ( FONT_SIZE );
		}
	
		/**
	 	* Specifies the font size of text.
	 	* @param value	Possible values are: xx-small, x-small, small, medium, large, x-large, xx-large, smaller, larger, length, %, inherit.
	 	*/
		public function set font_size ( value : * ) : void {
			w ( FONT_SIZE, value );
		}



		/**
	 	* Get the text's font family.
	 	* @return	The text's font family.
	 	*/
		public function get font_family () : String
		{
			return r ( FONT_FAMILY );
		}
	
		/**
	 	* Specifies the font family for text.
	 	* @param value	Possible values are: family-name, generic-family, inherit.
	 	*/
		public function set font_family ( value : * ) : void {
			w ( FONT_FAMILY, value );
		}
	}
}