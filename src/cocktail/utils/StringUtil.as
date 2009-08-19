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

package cocktail.utils 
{

	/**
	 * Utilities for string manipuation.
	 * @author nybras | nybras@codeine.it
	 */
	public class StringUtil 
	{
		
		/**
		 * Replaces all found occurencies.
		 * @param string	String source.
		 * @param search	String search entry.
		 * @param replace	String replacement.
		 */
		public static function replace_all( string : String, search : *, replace : * ) : String
		{
			return string.split( search ).join( replace ); 
		}
		
		/**
		 * Returns the given string in lowercase, except the first char that becomes uppercase.
		 * @param string	String source.
		 */
		public static function ucasef( string : String ) : String
		{
			return string.substr(0, 1).toUpperCase() + string.substr( 1 ).toLowerCase();
		}
		
		/**
		 * Returns the first and last char of the given string.
		 * @param string	String source.
		 */
		public static function outerb( string : String ) : String
		{
			return string.substr( 0, 1 ) + string.substr( -1 );
		}
		
		/**
		 * Returns the given string, excluding the first and last char.
		 * @param string	String source.
		 */
		public static function innerb( string : String ) : String
		{
			return string.slice( 1, -1 );
		}
		
		/**
		 * Search the given string for every ocurrency surrounded by the given opening/close chars and return a array with all found occurrencies.
		 */
		public static function enclosure( string : String, opening : String, closing : String ) : Array
		{
			var r : RegExp;
			
			opening = escapeRegExpChar( opening );
			closing = escapeRegExpChar( closing );
			
			//r = new RegExp( opening +"[^"+ opening +"|"+ closing +"|\\n\\s]*"+ closing, "g" );
			r = new RegExp( opening +".+?"+ closing, "g" );
			
			return string.match( r );
		}
		
		/**
		 * Escapes the given char to be used into a RegExp.
		 * @param char	Chars to be escaped.
		 */
		private static function escapeRegExpChar( char : String ) : String
		{
			return char.replace(
				new RegExp("([{}\(\)\^$&.\*\?\/\+\|\[\\\\]|\]|\-)","g"),
				"\\$1"
			);
		}
		
		/**
		 * Removes all blank spaces on the left and right side of the given string.
		 * @param string	String source.
		 */
		public static function trim( string : String ) : String
		{
			return StringUtil.ltrim( StringUtil.rtrim( string ) );
		}
		
		/**
		 * Removes all blank spaces on the left side of the given string.
		 * @param string	String source.
		 */
		public static function ltrim( string : String ) : String
		{
			var obj : RegExp = /^(\s*)([\W\w]*$)/;
			if( obj.test( string ) )
				string = string.replace(obj, '$2');
			return string;		
		}
		
		/**
		 * Removes all blank spaces on the right side of the given string.
		 * @param string	String source.
		 */
		public static function rtrim( string : String ) : String
		{
			var obj : RegExp = /^([\W\w]*)(\b\s*$)/;
			if( obj.test( string ) )
				string = string.replace(obj, '$1');
			return string;
		}
	}
}