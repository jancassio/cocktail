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
	import cocktail.utils.ArrayUtil;				

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
		
		internal var _all : Boolean;
		
		private var _touched : Array;
		
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
		public function Binded (
			key : String,
			change  : *,
			setter : String = null
		) : void
		{
			this.key = key;
			this.change = change;
			this.setter = setter;
			
			_touched = [];
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
			var item : Touched;
			
			this.value = value;
			
			if ( setter != null )
				change[ setter ] = value;
			else
				( change as Function )( value );
			
			for each ( item in _touched )
				item.update();
		}
		
		
		
		/* ---------------------------------------------------------------------
			TOUCH / UNTOUCH ( notifiers )
		--------------------------------------------------------------------- */
		
		/**
		 * Add methods to be touched..
		 * @param methods	A single method or an array of methods to touch
		 * after the plugged handler, every time it's executed.
		 */
		public function touch ( methods  : * ) : void
		{
			var item : Touched;
			
			untouch ( key, methods );
			_touched.push( item = new Touched( key, methods ) );
			
			if ( value != null )
				item.update();
		}
		
		
		
		/**
		 * Remove methods from being touched.
		 * @param methods	Methods to be untouched, it can be just a single
		 * method or an array with many methods.
		 * @return	<code>true</code> if the key is untouched successfully,
		 * <code>false</code> otherwise.
		 */
		public function untouch (
			key : String,
			methods  : *
		) : Boolean
		{
			var item : Touched;
			
			for each ( item in _touched )
			{
				if ( item.key != key )
					continue;
				
				if ( methods is Array && item.methods is Array )
				{
					if ( ArrayUtil.compare( methods , item.methods ) )
					{
						ArrayUtil.del( _touched, item );
						return true;
					}
				}
				else if ( methods is Function && item.methods is Function )
				{
					if ( methods == item.methods )
					{
						ArrayUtil.del( _touched, item );
						return true;
					}
				}
			}
			
			return false;
		}
	}
}