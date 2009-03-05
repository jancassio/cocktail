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

package cocktail.lib.view.elements {	import cocktail.core.data.dao.layout.LayoutOptionDAO;	import cocktail.core.data.dao.style.StyleBtnDAO;	import cocktail.core.data.dao.style.StyleDAO;	import cocktail.core.data.dao.style.StyleOptionDAO;	import cocktail.core.data.dao.style.StyleSelectDAO;	import cocktail.lib.view.elements.TxtElement;		import flash.text.TextFieldAutoSize;		
	/**	 * Cocktail base option class.	 * @author nybras | nybras@codeine.it	 * @see	SelectElement	 */	public class OptionElement extends BtnElement	{		/* ---------------------------------------------------------------------			VARS		--------------------------------------------------------------------- */				private var _label : TxtElement;						
		/* ---------------------------------------------------------------------			RENDERING		--------------------------------------------------------------------- */				/**		 * Invoked before render.		 */		public override function before_render () : void		{			var content : String;			var tmp_style : StyleOptionDAO;						super.before_render();						tmp_style = style() as StyleOptionDAO;			tmp_style.snap = "0 0";			tmp_style.apply( this );						content = info.xml;						_label = addChild( create ( <txt>{content}</txt> ) ) as TxtElement;						if ( tmp_style.bg_width || tmp_style.bg_height )				_label.field.autoSize = TextFieldAutoSize.NONE;						if ( tmp_style.bg_width )				_label.field.width = tmp_style.bg_width;						if ( tmp_style.bg_height )				_label.field.height = tmp_style.bg_height;						if ( tmp_style.font )				_label.format( tmp_style.font , tmp_style.font_size , tmp_style.color , tmp_style.text_align , tmp_style.underline );		}								/* ---------------------------------------------------------------------			GETTERS		--------------------------------------------------------------------- */				/**		 * Gets the option value.		 * @return	The option value.		 */		public function get value () : String		{			return ( info as LayoutOptionDAO ).value;		}				/**		 * Gets the option label.		 * @return	The option label.		 */		public function get label () : String		{			return _label.text;		}								/* ---------------------------------------------------------------------			HIGHLIGHT		--------------------------------------------------------------------- */				/**		 * Turns the "over" state highlight ON or OFF.		 * @param show	If <code>true</code>, shows the over state, otherwise <code>false</code> hides it.		 */		public function highlight ( show : Boolean = true ) : void		{			if ( show )				this.over();			else				this.out();		}	}}