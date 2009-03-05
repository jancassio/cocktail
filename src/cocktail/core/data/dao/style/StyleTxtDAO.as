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

package cocktail.core.data.dao.style 
{	import cocktail.core.data.dao.style.StyleDAO;		import flash.text.TextFieldAutoSize;	import flash.text.TextFormat;		
	/**	 * @author nybras | nybras@codeine.it	 */	public class StyleTxtDAO extends StyleDAO 
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
			
		public var font : String;
		public var font_size : uint = 12;
		public var text_auto_size : String = TextFieldAutoSize.LEFT;	
		public var text_select : Boolean;
		public var text_align : String;
		public var input : Boolean = false;
		public var border : Boolean = false;
		public var border_color : Number;
		public var background : Number;		public var multiline : Boolean = true;		public var underline : Boolean = false;
		public var leading : Object = null;								/* ---------------------------------------------------------------------			FILTERS VARS		--------------------------------------------------------------------- */				public var drop_shadow_distance : Number;		public var drop_shadow_angle : Number;		public var drop_shadow_color : Number;		public var drop_shadow_alpha : Number;		public var drop_shadow_blurX : Number;		public var drop_shadow_blurY : Number;		public var drop_shadow_strength : Number;		public var drop_shadow_quality : Number;		public var drop_shadow_inner : Boolean = false;		public var drop_shadow_knockout : Boolean = false;		public var drop_shadow_hide : Boolean = false;						
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new StyleTxtDAO instance.
		 * @param item	The item xml node.
		 */
		public function StyleTxtDAO (item : XML = null )
		{			super( item );
						new TextFormat (  );			
			// TODO - check if its working properly for input text 
			if ( input )
				text_auto_size = TextFieldAutoSize.NONE;
		}
	}}