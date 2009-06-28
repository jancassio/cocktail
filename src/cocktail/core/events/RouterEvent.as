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

package cocktail.core.events 
{
	import flash.events.Event;
	
	/**
	 * RouterEvent class is the Event class for the Router class.
	 * 
	 * @author nybras | nybras@codeine.it
	 * @see Router
	 */
	public class RouterEvent extends Event
	{
		
		/* ---------------------------------------------------------------------
			CONSTs
		--------------------------------------------------------------------- */
		
		public static const CHANGE : String = "Router_change";
		
		
		
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		public var location : String;
		public var freezed : Boolean;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new RouterEvent class.
		 */
		public function RouterEvent (type : String, location : String, freezed : Boolean )
		{
			super( type );
			this.location = location;
			this.freezed = freezed;
		}
	}
}