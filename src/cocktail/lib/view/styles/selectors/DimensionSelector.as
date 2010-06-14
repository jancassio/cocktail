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
	 * Provides all Dimension property selectors
	 * @author nybras | nybras@codeine.it
	 */
	public class DimensionSelector extends Selector
	{
		/* ---------------------------------------------------------------------
			CONSTANTS
		--------------------------------------------------------------------- */
		
		public static const WIDTH : String = "width";
		public static const MIN_WIDTH : String = "min-width";
		public static const MAX_WIDTH : String = "max-width";
		public static const HEIGHT : String = "height";
		public static const MIN_HEIGHT : String = "min-height";
		public static const MAX_HEIGHT : String = "max-height";
		
		
		
		/* ---------------------------------------------------------------------
			PROPERTIES
		--------------------------------------------------------------------- */
		
		/**
	 	* Get the width for dimension.
	 	* @return	The width for dimension.
	 	*/
		public function get width () : String
		{
			return r ( WIDTH );
		}
	
		/**
	 	* Specifies the width for dimension.
	 	* @param value	Possible values are: auto, length, %, inherit.
	 	*/
		public function set width ( value : * ) : void {
			w ( WIDTH, value );
		}



		/**
	 	* Get the min-width for dimension.
	 	* @return	The min-width for dimension.
	 	*/
		public function get min_width () : String
		{
			return r ( MIN_WIDTH );
		}
	
		/**
	 	* Specifies the min-width for dimension.
	 	* @param value	Possible values are: auto, length, %, inherit.
	 	*/
		public function set min_width ( value : * ) : void {
			w ( MIN_WIDTH, value );
		}



		/**
	 	* Get the max-width for dimension.
	 	* @return	The max-width for dimension.
	 	*/
		public function get max_width () : String
		{
			return r ( MAX_WIDTH );
		}
	
		/**
	 	* Specifies the max-width for dimension.
	 	* @param value	Possible values are: auto, length, %, inherit.
	 	*/
		public function set max_width ( value : * ) : void {
			w ( MAX_WIDTH, value );
		}



		/**
	 	* Get the height for dimension.
	 	* @return	The height for dimension.
	 	*/
		public function get height () : String
		{
			return r ( HEIGHT );
		}
	
		/**
	 	* Specifies the height for dimension.
	 	* @param value	Possible values are: auto, length, %, inherit.
	 	*/
		public function set height ( value : * ) : void {
			w ( HEIGHT, value );
		}



		/**
	 	* Get the min-height for dimension.
	 	* @return	The min-height for dimension.
	 	*/
		public function get min_height () : String
		{
			return r ( MIN_HEIGHT );
		}
	
		/**
	 	* Specifies the min-height for dimension.
	 	* @param value	Possible values are: auto, length, %, inherit.
	 	*/
		public function set min_height ( value : * ) : void {
			w ( MIN_HEIGHT, value );
		}



		/**
	 	* Get the max-height for dimension.
	 	* @return	The max-height for dimension.
	 	*/
		public function get max_height () : String
		{
			return r ( MAX_HEIGHT );
		}
	
		/**
	 	* Specifies the max-height for dimension.
	 	* @param value	Possible values are: auto, length, %, inherit.
	 	*/
		public function set max_height ( value : * ) : void {
			w ( MAX_HEIGHT, value );
		}
	}
}