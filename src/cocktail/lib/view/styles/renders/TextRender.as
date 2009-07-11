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

package cocktail.lib.view.styles.renders 
{
	import cocktail.lib.view.styles.renders.Render;
	import cocktail.lib.view.styles.selectors.TextSelector;
	
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;	

	/**
	 * Render all Text properties
	 * @author nybras | nybras@codeine.it
	 */
	public class TextRender extends Render 
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _sheet : StyleSheet;		
		
		/* ---------------------------------------------------------------------
			CONSTRUCTOR
		--------------------------------------------------------------------- */
		
		public function TextRender ()
		{
			//init local stylesheet instance
			_sheet = new StyleSheet();
		}
		
		
		
		/* ---------------------------------------------------------------------
			RENDER
		--------------------------------------------------------------------- */
		
		/**
		 * Start the automagic live rendering. 
		 */
		public function render () : void
		{	
			var refresh : Array;
			
			refresh = [ this.refresh ];
			
			_style.plug( TextSelector.WORD_SPACING, _word_spacing ).touch( refresh );
			_style.plug( TextSelector.LETTER_SPACING, _letter_spacing ).touch( refresh );
			_style.plug( TextSelector.WHITE_SPACE, _white_space ).touch( refresh );
			_style.plug( TextSelector.WORD_WRAP, _word_wrap ).touch( refresh );
			_style.plug( TextSelector.TEXT_ALIGN, _text_align ).touch( refresh );
			_style.plug( TextSelector.TEXT_DECORATION, _text_decoration ).touch( refresh );
			_style.plug( TextSelector.TEXT_SHADOW, _text_shadow ).touch( refresh );
			_style.plug( TextSelector.TEXT_IDENT, _text_ident ).touch( refresh );
		}
		
		/**
		 * Apply the styles and format in the text field.
		 */
		public function refresh () : void
		{				
			var sclass : String;
			
			for each ( sclass in _get_stylenames() )
			{
				_sheet.setStyle( "." + sclass, _styles.get( sclass).to_obj() );
			}
			
			target.autoSize = TextFieldAutoSize.LEFT;
			
			target.defaultTextFormat = _sheet.transform( _style.to_obj() );
			target.styleSheet = _sheet;
			target.htmlText = "<span class='c'>COCKTAIL</span> body1 <span class='c'>sdf</span> body2";
		}
		
		/**
		 * Return all the span style names in the text value.
		 */
		private function _get_stylenames () : Array
		{
			var props : Array;
			var prop : String;
			props = "<c>COCKTAIL</c>".match( /<[a-zA-Z0-9]+>/g );
			for ( prop in props )
				props[ prop ] = props[ prop ].slice( 1, -1 );
			
			return props;
		}
		
		
		
		/* ---------------------------------------------------------------------
			GETTERS & SETTERS
		--------------------------------------------------------------------- */
		
		/**
		 * Return the target object casted to TextField 
		 */
		private function get target () : TextField
		{
			return super._target as TextField;
		}
		
		

		/* ---------------------------------------------------------------------
			PROPERTIES
		--------------------------------------------------------------------- */
		
		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _word_spacing( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _letter_spacing( value : * ) : void
		{
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _white_space( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _word_wrap( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _text_align( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _text_decoration( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _text_shadow( value : * ) : void
		{
			// TODO: implement method
		}

		/**
		  * TODO: Write render documentation.
		  * @param value	TODO: Write param documentation.
		  */
		private function _text_ident( value : * ) : void
		{
			// TODO: implement method
		}
	}
}