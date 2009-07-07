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
	 * Provides all Margin property selectors
	 * @author nybras | nybras@codeine.it
	 */
	public class MarginSelector extends Selector
	{
		/* ---------------------------------------------------------------------
			CONSTANTS
		--------------------------------------------------------------------- */
		
		public static const MARGIN : String = "margin";
		public static const MARGIN_LEFT : String = "margin-left";
		public static const MARGIN_TOP : String = "margin-top";
		public static const MARGIN_RIGHT : String = "margin-right";
		public static const MARGIN_BOTTOM : String = "margin-bottom";
		
		
		
		/* ---------------------------------------------------------------------
			PROPERTIES
		--------------------------------------------------------------------- */
		
		/**
	 	* Get the margin for margin.
	 	* @return	The margin for margin.
	 	*/
		public function get margin () : String
		{
			return r ( MARGIN );
		}
	
		/**
	 	* Specifies the margin for margin.
	 	* @param value	Possible values are: auto, length, %, inherit.
	 	*/
		public function set margin ( value : * ) : void {
			w ( MARGIN, value );
		}



		/**
	 	* Get the margin-left for margin.
	 	* @return	The margin-left for margin.
	 	*/
		public function get margin_left () : String
		{
			return r ( MARGIN_LEFT );
		}
	
		/**
	 	* Specifies the margin-left for margin.
	 	* @param value	Possible values are: auto, length, %, inherit.
	 	*/
		public function set margin_left ( value : * ) : void {
			w ( MARGIN_LEFT, value );
		}



		/**
	 	* Get the margin-top for margin.
	 	* @return	The margin-top for margin.
	 	*/
		public function get margin_top () : String
		{
			return r ( MARGIN_TOP );
		}
	
		/**
	 	* Specifies the margin-top for margin.
	 	* @param value	Possible values are: auto, length, %, inherit.
	 	*/
		public function set margin_top ( value : * ) : void {
			w ( MARGIN_TOP, value );
		}



		/**
	 	* Get the margin-right for margin.
	 	* @return	The margin-right for margin.
	 	*/
		public function get margin_right () : String
		{
			return r ( MARGIN_RIGHT );
		}
	
		/**
	 	* Specifies the margin-right for margin.
	 	* @param value	Possible values are: auto, length, %, inherit.
	 	*/
		public function set margin_right ( value : * ) : void {
			w ( MARGIN_RIGHT, value );
		}



		/**
	 	* Get the margin-bottom for margin.
	 	* @return	The margin-bottom for margin.
	 	*/
		public function get margin_bottom () : String
		{
			return r ( MARGIN_BOTTOM );
		}
	
		/**
	 	* Specifies the margin-bottom for margin.
	 	* @param value	Possible values are: auto, length, %, inherit.
	 	*/
		public function set margin_bottom ( value : * ) : void {
			w ( MARGIN_BOTTOM, value );
		}
	}
}