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

package cocktail.lib.view.helpers.form.rules 
{
	import cocktail.lib.view.helpers.interfaces.IRule;
	import cocktail.utils.StringUtil;	

	/**
	 * Validation class for non-null values.
	 * @author nybras | nybras@codeine.it
	 * @see	FormHelper
	 * @see	FormItem
	 * @see	IRule
	 */
	public class NotNullRule extends Rule implements IRule 
	{
		/* ---------------------------------------------------------------------
			TESTING
		--------------------------------------------------------------------- */
		
		/**
		 * Tests the given value against the rule.
		 * @param value	Value to be tested.
		 * @return	<code>true</code> if the value is valid,
		 * <code>false</code> otherwise.
		 */
		override public function test ( value : * ) : Boolean
		{
			return ( StringUtil.trim( String( value ) ).length >= 1 );
		}
	}
}