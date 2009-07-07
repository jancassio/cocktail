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
	 * Provides all Text property selectors
	 * @author nybras | nybras@codeine.it
	 */
	public class TextSelector extends Selector
	{
		/* ---------------------------------------------------------------------
			CONSTANTS
		--------------------------------------------------------------------- */
		
		public static const WORD_SPACING : String = "word-spacing";
		public static const LETTER_SPACING : String = "letter-spacing";
		public static const WHITE_SPACE : String = "white-space";
		public static const WORD_WRAP : String = "word-wrap";
		public static const TEXT_ALIGN : String = "text-align";
		public static const TEXT_DECORATION : String = "text-decoration";
		public static const TEXT_SHADOW : String = "text-shadow";
		public static const TEXT_IDENT : String = "text-ident";
		
		
		
		/* ---------------------------------------------------------------------
			PROPERTIES
		--------------------------------------------------------------------- */
		
		/**
	 	* Get the word-spacing for text.
	 	* @return	The word-spacing for text.
	 	*/
		public function get word_spacing () : String
		{
			return r ( WORD_SPACING );
		}
	
		/**
	 	* Specifies the word-spacing for text.
	 	* @param value	Possible values are: normal, length, inherit.
	 	*/
		public function set word_spacing ( value : * ) : void {
			w ( WORD_SPACING, value );
		}



		/**
	 	* Get the letter-spacing for text.
	 	* @return	The letter-spacing for text.
	 	*/
		public function get letter_spacing () : String
		{
			return r ( LETTER_SPACING );
		}
	
		/**
	 	* Specifies the letter-spacing for text.
	 	* @param value	Possible values are: normal, length, inherit.
	 	*/
		public function set letter_spacing ( value : * ) : void {
			w ( LETTER_SPACING, value );
		}



		/**
	 	* Get the white-space for text.
	 	* @return	The white-space for text.
	 	*/
		public function get white_space () : String
		{
			return r ( WHITE_SPACE );
		}
	
		/**
	 	* Specifies the white-space for text.
	 	* @param value	Possible values are: normal, nowrap, pre, pre-line, pre-wrap, inherit.
	 	*/
		public function set white_space ( value : * ) : void {
			w ( WHITE_SPACE, value );
		}



		/**
	 	* Get the word-wrap for text.
	 	* @return	The word-wrap for text.
	 	*/
		public function get word_wrap () : String
		{
			return r ( WORD_WRAP );
		}
	
		/**
	 	* Specifies the word-wrap for text.
	 	* @param value	Possible values are: true, false.
	 	*/
		public function set word_wrap ( value : * ) : void {
			w ( WORD_WRAP, value );
		}



		/**
	 	* Get the text-align for text.
	 	* @return	The text-align for text.
	 	*/
		public function get text_align () : String
		{
			return r ( TEXT_ALIGN );
		}
	
		/**
	 	* Specifies the text-align for text.
	 	* @param value	Possible values are: left, right, center, justify, inherit.
	 	*/
		public function set text_align ( value : * ) : void {
			w ( TEXT_ALIGN, value );
		}



		/**
	 	* Get the text-decoration for text.
	 	* @return	The text-decoration for text.
	 	*/
		public function get text_decoration () : String
		{
			return r ( TEXT_DECORATION );
		}
	
		/**
	 	* Specifies the text-decoration for text.
	 	* @param value	Possible values are: blink, line-through, none, overline, underline, inherit.
	 	*/
		public function set text_decoration ( value : * ) : void {
			w ( TEXT_DECORATION, value );
		}



		/**
	 	* Get the text-shadow for text.
	 	* @return	The text-shadow for text.
	 	*/
		public function get text_shadow () : String
		{
			return r ( TEXT_SHADOW );
		}
	
		/**
	 	* Specifies the text-shadow for text.
	 	* @param value	Possible values are: none, shadow, inherit.
	 	*/
		public function set text_shadow ( value : * ) : void {
			w ( TEXT_SHADOW, value );
		}



		/**
	 	* Get the text-ident for text.
	 	* @return	The text-ident for text.
	 	*/
		public function get text_ident () : String
		{
			return r ( TEXT_IDENT );
		}
	
		/**
	 	* Specifies the text-ident for text.
	 	* @param value	Possible values are: length, %, inherit.
	 	*/
		public function set text_ident ( value : * ) : void {
			w ( TEXT_IDENT, value );
		}
	}
}