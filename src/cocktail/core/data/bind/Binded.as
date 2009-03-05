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

package cocktail.core.data.bind {	/**	 * Binded class used by Bind.	 * @author nybras | nybras@codeine.it	 * @see Bind	 */	internal class Binded 	{		/* ---------------------------------------------------------------------			VARS		--------------------------------------------------------------------- */				public var key : String;		public var change : *;		public var setter : String;		public var value : *;								/* ---------------------------------------------------------------------			INITIALIZING		--------------------------------------------------------------------- */				/**		 * Creates a new Binded instance.		 * @param key	Binded key.		 * @param change		Binded method or setter's scope.		 * @param setter	Binded setter (optional).		 */		public function Binded ( key : String, change  : *, setter : String = null ) : void		{			this.key = key;			this.change = change;			this.setter = setter;		}								/* ---------------------------------------------------------------------			UPDATING		--------------------------------------------------------------------- */				/**		 * Updates the binded item.		 * @param value	New value.		 */		internal function update ( value : * ) : void		{			this.value = value;						if ( setter != null )				change[ setter ] = value;			else				( change as Function )( value );		}	}}