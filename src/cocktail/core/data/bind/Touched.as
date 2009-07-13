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

package cocktail.core.data.bind 
{

	/**
	 * Touched class used by Bind / Binded.
	 * @author nybras | nybras@codeine.it
	 * @see Bind
	 */
	public class Touched 
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		internal var _all : Boolean;
		
		public var key : String;
		public var methods : *;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new Touched instance.
		 * @param key	Key to plug.	
		 * @param methods	Methods to be touched when the key value changes, it
		 * can be just a single method or an array with many methods.
		 */
		public function Touched (
			key : String,
			methods  : *
		) : void
		{
			this.key = key;
			this.methods = methods;
		}
		
		
		
		/* ---------------------------------------------------------------------
			UPDATING
		--------------------------------------------------------------------- */
		
		/**
		 * Updates the touched item.
		 */
		internal function update () : void
		{
			var method : Function;
			
			if ( methods is Function )
				( methods as Function )();
			else if ( methods is Array )
				for each ( method in methods )
					( method as Function )();
		}
	}
}