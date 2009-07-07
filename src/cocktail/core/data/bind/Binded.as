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
	 * Binded class used by Bind.
	 * @author nybras | nybras@codeine.it
	 * @see Bind
	 */
	public class Binded 
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _touched : Array;
		private var _repass_value : Boolean;
		
		public var key : String;
		public var change : *;
		public var setter : String;
		public var value : *;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new Binded instance.
		 * @param key	Binded key.
		 * @param change		Binded method or setter's scope.
		 * @param setter	Binded setter (optional).
		 */
		public function Binded ( key : String, change  : *, setter : String = null ) : void
		{
			this.key = key;
			this.change = change;
			this.setter = setter;
			
			_touched = [];
			_repass_value = false;
		}
		
		
		
		/* ---------------------------------------------------------------------
			UPDATING
		--------------------------------------------------------------------- */
		
		/**
		 * Updates the binded item.
		 * @param value	New value.
		 */
		internal function update ( value : * ) : void
		{
			var method : Function;
			
			this.value = value;
			
			if ( setter != null )
				change[ setter ] = value;
			else
				( change as Function )( value );
			
			for each ( method in _touched )
				if ( _repass_value )
					( method as Function )( value );
				else
					( method as Function )();
		}
		
		
		
		/* ---------------------------------------------------------------------
			TOUCHING ( notifiers )
		--------------------------------------------------------------------- */
		
		/**
		 * Add a list of methods that will be "touched" every time this Bind
		 * changes.
		 * @param methods	Array of methods (functions) that shou be called.
		 * @param repass_value	If <code>true</true> pass the new Bind value
		 * to all methods -- method ( value ). Otherwise <code>false</code>
		 * all methods is called without passing any param -- method(). 
		 */
		public function touch ( methods : Array, repass_value : Boolean = false ) : void
		{
			_touched = methods;
			_repass_value = repass_value;
		}
	}
}