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

package cocktail.core.data.dao.style {	import flash.text.TextFieldAutoSize;			/**	 * Style "select" data access object, used by View class.	 * 	 * @author nybras | nybras@codeine.it	 * @see View	 */	public class StyleSelectDAO extends StyleBtnDAO 	{		/* ---------------------------------------------------------------------			VARS		--------------------------------------------------------------------- */				public var font : String;		public var font_size : uint = 12;		public var text_auto_size : String = TextFieldAutoSize.LEFT;			public var text_align : String;		public var background : Number;		public var underline : Boolean = false;								/* ---------------------------------------------------------------------			INITIALIZING		--------------------------------------------------------------------- */				/**		 * Creates a new StyleSelectDAO instance.		 * @param item	The item xml node.		 */		public function StyleSelectDAO (item : XML = null )		{			super( item );		}	}}