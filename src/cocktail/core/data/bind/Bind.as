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
	 * Simple bind class.
	 * 
	 * @author nybras | nybras@codeine.it
	 */
	public class Bind 
	{
		
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var binded : Array;
		private var data : Object;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new Bind instance.
		 */
		public function Bind ()
		{
			binded = new Array();
			data = new Object();
		}
		
		
		
		/* ---------------------------------------------------------------------
			GETTER & SETTER
		--------------------------------------------------------------------- */
		
		/**
		 * Set the key value.
		 * @param key	Key to be setted.
		 * @param value	Value to the given key.
		 */
		public function s( key : String, value : * ) : void
		{
			data[ key ] = value;
			update( key, value );
		}
		
		/**
		 * Get the key value.
		 * @param key	Key to get the value.
		 * @return	The key value.
		 */
		public function g( key : String ) : *
		{
			return data[ key ];
		}
		
		/**
		 * Delete the key entry.
		 * @param key	Key to be deleted.
		 */
		public function d( key : String ) : void
		{
			data[ key ] = null;
			delete data[ key ];
		}
		
		
		
		/* ---------------------------------------------------------------------
			GETTER & SETTER
		--------------------------------------------------------------------- */
		
		/**
		 * Updates some key and "ping" all plugged items.
		 * @param key	Updated key.
		 * @param value	Updated value.
		 */
		private function update ( key : String, value : * ) : void
		{
			var item : Binded;
			
			for each ( item in binded )
			{
				if ( item.key == key )
					item.update( value );
			}
		}
		
		
		
		/* ---------------------------------------------------------------------
			PLUG & UNPLUG
		--------------------------------------------------------------------- */
		
		/**
		 * Plug some key.
		 * @param key	The key to be plugged.
		 * @param change		The listener method or the setter's scope.
		 * @param setter	If informed, the <code>change</code> param is
		 * handled as a scope, otherwise its handled as a method.
		 */
		public function plug (
			key : String,
			change  : *,
			setter : String = null
		) : Binded
		{
			var item : Binded;
			
			unplug(key, change, setter);
			binded.push( item = new Binded( key, change, setter ) );
			
			if ( data[ key ] != undefined )
				item.update( data[ key ] );
			
			return item;
		}
		
		/**
		 * Unplug some key.
		 * @param key	The key to be unplugged.
		 * @param change		The listener method or the setter's scope.
		 * @param setter	If informed, the <code>change</code> param is
		 * handled as a scope, otherwise its handled as a method.
		 * @return	<code>true</code> if the key is unplugged successfully,
		 * <code>false</code> otherwise.
		 */
		public function unplug (
			key : String,
			change  : *,
			setter : String = null
		) : Boolean
		{
			var item : Binded;
			
			for each ( item in binded )
			{
				if (	item.key == key			&&
						item.change == change	&&
						item.setter == setter	)
				{
					ArrayUtil.del( binded , item );
					return true;
				}
			}
			
			return false;
		}
		
	}
}