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

package cocktail.lib.view.helpers.events 
{
	import cocktail.lib.view.helpers.form.FormItem;
	
	import flash.events.Event;	

	/**
	 * FormHelper events.
	 * @author nybras | nybras@codeine.it
	 */
	public class FormEvent extends Event 
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		public static const VALIDATE : String = "FormItem.VALIDATE";
		public static const INVALIDATE : String = "FormItem.INVALIDATE";
		
		public var item : FormItem;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new FormEvent.
		 * @param type	Event type.
		 * @param item	FormItem that is dispatching the event.
		 */
		public function FormEvent ( type : String, item : FormItem )
		{
			super( type );
			this.item = item;
		}
	}
}