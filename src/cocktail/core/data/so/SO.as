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

package cocktail.core.data.so 
{
	import flash.net.SharedObject;		

	/**
	 * Simple class for local ShareObject management with easy read, update & delete actions.
	 * @author nybras | nybras@codeine.it
	 */
	public class SO 
	{
		/* ---------------------------------------------------------------------
			RENDER / DESTROY
		--------------------------------------------------------------------- */
		
		private var id : String;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new SO instance.
		 * @param id	Desired SharedObject id.
		 */
		public function SO ( id : String )
		{
			this.id = id;
		}
		
		
		
		/* ---------------------------------------------------------------------
			READ / WRITE / DELETE
		--------------------------------------------------------------------- */
		
		/**
		 * Reads data from SharedObject, according the given key.
		 * @param key	Key to be read.
		 */
		public function r ( key : String ) : *
		{
			return SharedObject.getLocal( id ).data[ key ];
		}
		
		/**
		 * Write data to SharedObject, according the given key & value.
		 * @param key	Key to be write.
		 * @param value	Key value to be write.
		 */
		public function w ( key : String, value : * ) : *
		{
			var so : SharedObject = SharedObject.getLocal( id );
			so.data[ key ] = value;
			so.flush();
			
			return value;
		}
		
		/**
		 * Delete data from SharedObject, according the given key.
		 * @param key	Key to be deleted.
		 */
		public function d ( key : String ) : void
		{
			var so : SharedObject = SharedObject.getLocal( id );
			
			so.data[ key ] = null;
			delete so.data[ key ];
			
			so.flush();
		}
	}
}
