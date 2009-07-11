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

package cocktail.lib.view.ui.layout 
{
	import cocktail.lib.view.styles.renders.PositionRender;
	import cocktail.lib.view.ui.UI;	
	
	/**
	 * DivUI class.
	 * @author nybras | nybras@codeine.it
	 */
	public class TextUI extends UI
	{
		/* ---------------------------------------------------------------------
			PROPERTIES
		--------------------------------------------------------------------- */
		
		private var _text : String;
		
		
		
		/* ---------------------------------------------------------------------
			FXML PROPERTIES
		--------------------------------------------------------------------- */
		
		public var id : String;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Setting all used properties and renders.
		 */
		public function TextUI ()
		{
			_set_properties( "id" );
			_add_render( new PositionRender () );
		}
		
		/**
		 * Add span tag for all found tags in the given content.
		 * 
		 * @param content the string content to be parsed.
		 */
		private function _parse_tags ( content : String ) : String
		{
			var tags : Array;
			var tag : String;
			
			tags = content.match( /<[a-zA-Z\/]+>/g );
			
			for each ( tag in tags )
				if ( tag.indexOf ( "span" ) < 0 )
					if ( tag.indexOf( "/" ) < 0 )
						content = content.split( tag ).join (
							"<span class='" + tag.slice ( 1, -1 ) + "'>"
						);
					else
						content = content.split( tag ).join ( "</span>" );
			
			return content;
		}
		
		
		
		/* ---------------------------------------------------------------------
			GETTERS & SETTERS
		--------------------------------------------------------------------- */
		
		/**
		 * get the text value.
		 */
		public function get text () : String
		{
			return _text;
		}
		
		/**
		 * set the text value.
		 */
		public function set text ( text : String ) : void
		{	
			_text = _parse_tags( text );
		}
		
	}
}