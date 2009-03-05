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

package cocktail.core 
{
	import flash.text.TextFormat;	
	import flash.text.Font;	

	/**
	 * @author Vincent
	 */
	public class FontHelper 
	{

		private static var fontList : Object = {};

		/**
		 * Adds a fontClass to list of fonts, and register it.
		 * @param FontClass	Loaded class from external swf file.
		 * @param alias	Name of the font to be found later.
		 */
		public static function add (FontClass : Class, alias : String) : Boolean
		{
			var result : Boolean;
			
			if (FontHelper.exists( alias )) return false;
			
			try {
				Font.registerFont( FontClass );
				FontHelper.fontList[alias] = new FontClass( );
				
				result = true;
			} catch (e : Error) {
				result = false;
			}
			
			return result;
		}

		/**
		 * Checks if font is already registred.
		 * @param alias	Name of the font (same used in add function).
		 * @return	True if font is registred, false otherwise.
		 */		public static function exists (alias : String) : Boolean
		{
			return (FontHelper.fontList[alias] != null);
		}

		/**
		 * Gets a registred font.
		 * @param alias	Name of the font (same used in add function).
		 * @return	The font as a Font class (null if font does not exists).
		 */
		public static function getFont (alias : String) : Font
		{
			if (FontHelper.exists( alias )) {
				return (FontHelper.fontList[alias] as Font);
			} else {
				return null;
			}
		}

		/**
		 * Gets a textformat from the selected font.
		 * @param alias	Name of the font (same used in add function).
		 * @return	A new textformat with font configs such as bold and italic.
		 */
		public static function getFormat (alias : String) : TextFormat
		{
			var fmt : TextFormat;
			var font : Font;
			
			fmt = new TextFormat( );
			
			if (!FontHelper.exists( alias )) {
				return fmt;
			}
			
			font = FontHelper.getFont( alias );
			
			fmt.font = font.fontName;
			fmt.bold = font.fontStyle.toLowerCase( ).indexOf( "bold" ) >= 0;
			fmt.italic = font.fontStyle.toLowerCase( ).indexOf( "italic" ) >= 0;
			
			return fmt;
		} 
	}
}
