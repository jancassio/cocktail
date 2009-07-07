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
	 * Provides all Border property selectors
	 * @author nybras | nybras@codeine.it
	 */
	public class BorderSelector extends Selector
	{
		/* ---------------------------------------------------------------------
			CONSTANTS
		--------------------------------------------------------------------- */
		
		public static const BORDER : String = "border";
		public static const BORDER_COLOR : String = "border-color";
		public static const BORDER_WIDTH : String = "border-width";
		public static const BORDER_STYLE : String = "border-style";
		public static const BORDER_RADIUS : String = "border-radius";
		public static const BORDER_OPACITY : String = "border-opacity";
		public static const BORDER_LEFT_COLOR : String = "border-left-color";
		public static const BORDER_LEFT_WIDTH : String = "border-left-width";
		public static const BORDER_LEFT_STYLE : String = "border-left-style";
		public static const BORDER_LEFT_RADIUS : String = "border-left-radius";
		public static const BORDER_LEFT_OPACITY : String = "border-left-opacity";
		public static const BORDER_TOP_COLOR : String = "border-top-color";
		public static const BORDER_TOP_WIDTH : String = "border-top-width";
		public static const BORDER_TOP_STYLE : String = "border-top-style";
		public static const BORDER_TOP_RADIUS : String = "border-top-radius";
		public static const BORDER_TOP_OPACITY : String = "border-top-opacity";
		public static const BORDER_RIGHT_COLOR : String = "border-right-color";
		public static const BORDER_RIGHT_WIDTH : String = "border-right-width";
		public static const BORDER_RIGHT_STYLE : String = "border-right-style";
		public static const BORDER_RIGHT_RADIUS : String = "border-right-radius";
		public static const BORDER_RIGHT_OPACITY : String = "border-right-opacity";
		public static const BORDER_BOTTOM_COLOR : String = "border-bottom-color";
		public static const BORDER_BOTTOM_WIDTH : String = "border-bottom-width";
		public static const BORDER_BOTTOM_STYLE : String = "border-bottom-style";
		public static const BORDER_BOTTOM_RADIUS : String = "border-bottom-radius";
		public static const BORDER_BOTTOM_OPACITY : String = "border-bottom-opacity";
		
		
		
		/* ---------------------------------------------------------------------
			PROPERTIES
		--------------------------------------------------------------------- */
		
		/**
	 	* Get the border for border.
	 	* @return	The border for border.
	 	*/
		public function get border () : String
		{
			return r ( BORDER );
		}
	
		/**
	 	* Specifies the border for border.
	 	* @param value	Possible values are: border-width, border-style, border-color, inherit.
	 	*/
		public function set border ( value : * ) : void {
			w ( BORDER, value );
		}



		/**
	 	* Get the border-color for border.
	 	* @return	The border-color for border.
	 	*/
		public function get border_color () : String
		{
			return r ( BORDER_COLOR );
		}
	
		/**
	 	* Specifies the border-color for border.
	 	* @param value	Possible values are: color-rgb, color-hex, color-name, invert, inherit.
	 	*/
		public function set border_color ( value : * ) : void {
			w ( BORDER_COLOR, value );
		}



		/**
	 	* Get the border-width for border.
	 	* @return	The border-width for border.
	 	*/
		public function get border_width () : String
		{
			return r ( BORDER_WIDTH );
		}
	
		/**
	 	* Specifies the border-width for border.
	 	* @param value	Possible values are: thin, medium, thick, length, inherit.
	 	*/
		public function set border_width ( value : * ) : void {
			w ( BORDER_WIDTH, value );
		}



		/**
	 	* Get the border-style for border.
	 	* @return	The border-style for border.
	 	*/
		public function get border_style () : String
		{
			return r ( BORDER_STYLE );
		}
	
		/**
	 	* Specifies the border-style for border.
	 	* @param value	Possible values are: none, hidden, dotted, dashed, solid, double, groove, ridge, inset, outset, inherit.
	 	*/
		public function set border_style ( value : * ) : void {
			w ( BORDER_STYLE, value );
		}



		/**
	 	* Get the border-radius for border.
	 	* @return	The border-radius for border.
	 	*/
		public function get border_radius () : String
		{
			return r ( BORDER_RADIUS );
		}
	
		/**
	 	* Specifies the border-radius for border.
	 	* @param value	Possible values are: TODO: add possibilities.
	 	*/
		public function set border_radius ( value : * ) : void {
			w ( BORDER_RADIUS, value );
		}



		/**
	 	* Get the border-opacity for border.
	 	* @return	The border-opacity for border.
	 	*/
		public function get border_opacity () : String
		{
			return r ( BORDER_OPACITY );
		}
	
		/**
	 	* Specifies the border-opacity for border.
	 	* @param value	Possible values are: TODO: add possibilities.
	 	*/
		public function set border_opacity ( value : * ) : void {
			w ( BORDER_OPACITY, value );
		}



		/**
	 	* Get the border-left-color for border.
	 	* @return	The border-left-color for border.
	 	*/
		public function get border_left_color () : String
		{
			return r ( BORDER_LEFT_COLOR );
		}
	
		/**
	 	* Specifies the border-left-color for border.
	 	* @param value	Possible values are: border-color, inherit.
	 	*/
		public function set border_left_color ( value : * ) : void {
			w ( BORDER_LEFT_COLOR, value );
		}



		/**
	 	* Get the border-left-width for border.
	 	* @return	The border-left-width for border.
	 	*/
		public function get border_left_width () : String
		{
			return r ( BORDER_LEFT_WIDTH );
		}
	
		/**
	 	* Specifies the border-left-width for border.
	 	* @param value	Possible values are: border-width, inherit.
	 	*/
		public function set border_left_width ( value : * ) : void {
			w ( BORDER_LEFT_WIDTH, value );
		}



		/**
	 	* Get the border-left-style for border.
	 	* @return	The border-left-style for border.
	 	*/
		public function get border_left_style () : String
		{
			return r ( BORDER_LEFT_STYLE );
		}
	
		/**
	 	* Specifies the border-left-style for border.
	 	* @param value	Possible values are: border-style, inherit.
	 	*/
		public function set border_left_style ( value : * ) : void {
			w ( BORDER_LEFT_STYLE, value );
		}



		/**
	 	* Get the border-left-radius for border.
	 	* @return	The border-left-radius for border.
	 	*/
		public function get border_left_radius () : String
		{
			return r ( BORDER_LEFT_RADIUS );
		}
	
		/**
	 	* Specifies the border-left-radius for border.
	 	* @param value	Possible values are: TODO: add possibilities.
	 	*/
		public function set border_left_radius ( value : * ) : void {
			w ( BORDER_LEFT_RADIUS, value );
		}



		/**
	 	* Get the border-left-opacity for border.
	 	* @return	The border-left-opacity for border.
	 	*/
		public function get border_left_opacity () : String
		{
			return r ( BORDER_LEFT_OPACITY );
		}
	
		/**
	 	* Specifies the border-left-opacity for border.
	 	* @param value	Possible values are: TODO: add possibilities.
	 	*/
		public function set border_left_opacity ( value : * ) : void {
			w ( BORDER_LEFT_OPACITY, value );
		}



		/**
	 	* Get the border-top-color for border.
	 	* @return	The border-top-color for border.
	 	*/
		public function get border_top_color () : String
		{
			return r ( BORDER_TOP_COLOR );
		}
	
		/**
	 	* Specifies the border-top-color for border.
	 	* @param value	Possible values are: border-color, inherit.
	 	*/
		public function set border_top_color ( value : * ) : void {
			w ( BORDER_TOP_COLOR, value );
		}



		/**
	 	* Get the border-top-width for border.
	 	* @return	The border-top-width for border.
	 	*/
		public function get border_top_width () : String
		{
			return r ( BORDER_TOP_WIDTH );
		}
	
		/**
	 	* Specifies the border-top-width for border.
	 	* @param value	Possible values are: border-width, inherit.
	 	*/
		public function set border_top_width ( value : * ) : void {
			w ( BORDER_TOP_WIDTH, value );
		}



		/**
	 	* Get the border-top-style for border.
	 	* @return	The border-top-style for border.
	 	*/
		public function get border_top_style () : String
		{
			return r ( BORDER_TOP_STYLE );
		}
	
		/**
	 	* Specifies the border-top-style for border.
	 	* @param value	Possible values are: border-style, inherit.
	 	*/
		public function set border_top_style ( value : * ) : void {
			w ( BORDER_TOP_STYLE, value );
		}



		/**
	 	* Get the border-top-radius for border.
	 	* @return	The border-top-radius for border.
	 	*/
		public function get border_top_radius () : String
		{
			return r ( BORDER_TOP_RADIUS );
		}
	
		/**
	 	* Specifies the border-top-radius for border.
	 	* @param value	Possible values are: TODO: add possibilities.
	 	*/
		public function set border_top_radius ( value : * ) : void {
			w ( BORDER_TOP_RADIUS, value );
		}



		/**
	 	* Get the border-top-opacity for border.
	 	* @return	The border-top-opacity for border.
	 	*/
		public function get border_top_opacity () : String
		{
			return r ( BORDER_TOP_OPACITY );
		}
	
		/**
	 	* Specifies the border-top-opacity for border.
	 	* @param value	Possible values are: TODO: add possibilities.
	 	*/
		public function set border_top_opacity ( value : * ) : void {
			w ( BORDER_TOP_OPACITY, value );
		}



		/**
	 	* Get the border-right-color for border.
	 	* @return	The border-right-color for border.
	 	*/
		public function get border_right_color () : String
		{
			return r ( BORDER_RIGHT_COLOR );
		}
	
		/**
	 	* Specifies the border-right-color for border.
	 	* @param value	Possible values are: border-color, inherit.
	 	*/
		public function set border_right_color ( value : * ) : void {
			w ( BORDER_RIGHT_COLOR, value );
		}



		/**
	 	* Get the border-right-width for border.
	 	* @return	The border-right-width for border.
	 	*/
		public function get border_right_width () : String
		{
			return r ( BORDER_RIGHT_WIDTH );
		}
	
		/**
	 	* Specifies the border-right-width for border.
	 	* @param value	Possible values are: border-width, inherit.
	 	*/
		public function set border_right_width ( value : * ) : void {
			w ( BORDER_RIGHT_WIDTH, value );
		}



		/**
	 	* Get the border-right-style for border.
	 	* @return	The border-right-style for border.
	 	*/
		public function get border_right_style () : String
		{
			return r ( BORDER_RIGHT_STYLE );
		}
	
		/**
	 	* Specifies the border-right-style for border.
	 	* @param value	Possible values are: border-style, inherit.
	 	*/
		public function set border_right_style ( value : * ) : void {
			w ( BORDER_RIGHT_STYLE, value );
		}



		/**
	 	* Get the border-right-radius for border.
	 	* @return	The border-right-radius for border.
	 	*/
		public function get border_right_radius () : String
		{
			return r ( BORDER_RIGHT_RADIUS );
		}
	
		/**
	 	* Specifies the border-right-radius for border.
	 	* @param value	Possible values are: TODO: add possibilities.
	 	*/
		public function set border_right_radius ( value : * ) : void {
			w ( BORDER_RIGHT_RADIUS, value );
		}



		/**
	 	* Get the border-right-opacity for border.
	 	* @return	The border-right-opacity for border.
	 	*/
		public function get border_right_opacity () : String
		{
			return r ( BORDER_RIGHT_OPACITY );
		}
	
		/**
	 	* Specifies the border-right-opacity for border.
	 	* @param value	Possible values are: TODO: add possibilities.
	 	*/
		public function set border_right_opacity ( value : * ) : void {
			w ( BORDER_RIGHT_OPACITY, value );
		}



		/**
	 	* Get the border-bottom-color for border.
	 	* @return	The border-bottom-color for border.
	 	*/
		public function get border_bottom_color () : String
		{
			return r ( BORDER_BOTTOM_COLOR );
		}
	
		/**
	 	* Specifies the border-bottom-color for border.
	 	* @param value	Possible values are: border-color, inherit.
	 	*/
		public function set border_bottom_color ( value : * ) : void {
			w ( BORDER_BOTTOM_COLOR, value );
		}



		/**
	 	* Get the border-bottom-width for border.
	 	* @return	The border-bottom-width for border.
	 	*/
		public function get border_bottom_width () : String
		{
			return r ( BORDER_BOTTOM_WIDTH );
		}
	
		/**
	 	* Specifies the border-bottom-width for border.
	 	* @param value	Possible values are: border-width, inherit.
	 	*/
		public function set border_bottom_width ( value : * ) : void {
			w ( BORDER_BOTTOM_WIDTH, value );
		}



		/**
	 	* Get the border-bottom-style for border.
	 	* @return	The border-bottom-style for border.
	 	*/
		public function get border_bottom_style () : String
		{
			return r ( BORDER_BOTTOM_STYLE );
		}
	
		/**
	 	* Specifies the border-bottom-style for border.
	 	* @param value	Possible values are: border-style, inherit.
	 	*/
		public function set border_bottom_style ( value : * ) : void {
			w ( BORDER_BOTTOM_STYLE, value );
		}



		/**
	 	* Get the border-bottom-radius for border.
	 	* @return	The border-bottom-radius for border.
	 	*/
		public function get border_bottom_radius () : String
		{
			return r ( BORDER_BOTTOM_RADIUS );
		}
	
		/**
	 	* Specifies the border-bottom-radius for border.
	 	* @param value	Possible values are: TODO: add possibilities.
	 	*/
		public function set border_bottom_radius ( value : * ) : void {
			w ( BORDER_BOTTOM_RADIUS, value );
		}



		/**
	 	* Get the border-bottom-opacity for border.
	 	* @return	The border-bottom-opacity for border.
	 	*/
		public function get border_bottom_opacity () : String
		{
			return r ( BORDER_BOTTOM_OPACITY );
		}
	
		/**
	 	* Specifies the border-bottom-opacity for border.
	 	* @param value	Possible values are: TODO: add possibilities.
	 	*/
		public function set border_bottom_opacity ( value : * ) : void {
			w ( BORDER_BOTTOM_OPACITY, value );
		}
	}
}