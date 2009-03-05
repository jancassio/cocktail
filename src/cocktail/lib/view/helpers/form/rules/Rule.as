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

package cocktail.lib.view.helpers.form.rules {	import cocktail.core.Index;	import cocktail.lib.view.helpers.FormHelper;	import cocktail.lib.view.helpers.interfaces.IRule;		/**	 * Rule base class.	 * @author nybras | nybras@codeine.it	 */	public class Rule extends Index implements IRule	{		/* ---------------------------------------------------------------------			VARS		--------------------------------------------------------------------- */				protected var _message : String;		protected var _form : FormHelper;								/* ---------------------------------------------------------------------			BOOTING		--------------------------------------------------------------------- */				/**		 * Boots the rule.		 * @param form	Parent form.		 * @param message	Rule error message.		 */		public function boot ( form : FormHelper, message : String = null ) : Rule		{			_form = form;			_message = message;			return this;		}						/* ---------------------------------------------------------------------			TESTING		--------------------------------------------------------------------- */				/**		 * Test value against rule.		 * 		=> obs: this method MUST to be overwritten  		 * @param value	Value to be tested.		 */		public function test ( value : * ) : Boolean		{			log.fatal( "Method 'test' MUST to be overwritten by subclasses." );			return false;		}						/* ---------------------------------------------------------------------			GETTERS		--------------------------------------------------------------------- */				/**		 * Gets the rule error message.		 * @return	The rule error message.		 */		public function get message () : String		{			return _message;		}	}}