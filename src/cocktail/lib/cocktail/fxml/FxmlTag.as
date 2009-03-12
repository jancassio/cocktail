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

package cocktail.lib.cocktail.fxml
{
	import cocktail.core.Index;				

	/**
	 * Fxml basic node class.
	 * @author nybras | nybras@codeine.it
	 */
	public class FxmlTag extends Index 
	{
		/* ---------------------------------------------------------------------
			PROPERTIES
		--------------------------------------------------------------------- */
		
		private var _properties : Array;
		
		
		
		/* ---------------------------------------------------------------------
			SETTING / PARSING PROPERTIES
		--------------------------------------------------------------------- */
		
		/**
		 * Keep all properties for future parsing.
		 * @param properties	Tag properties you has defined in your UI class,
		 * each one divided by a pipe "|".
		 */
		public function _set_properties ( properties : String ) : void
		{
			_properties = [].concat ( properties.split ( "|" ) );
		}
				/**
		 * Parses the item's node attributes according the declared vars.
		 * @param fxml_node	Node xml of any fxml tag, in view or model.
		 */
		public function _parse_properties ( fxml_node : XML ) : void
		{
			var value : *;
			var property : XML;
			var property_name : String;
			
			for each ( property_name in _properties )
				property = describe( property_name );
				if ( ( value = fxml_node.@[ property.@name ] ) != undefined )
				{
					switch ( property.@type )
					{
						case "Boolean":
							value = ( value == "true" || value == true );
						break;
					}
					this[ property.@name ] = value;
				}
		}
	}
}