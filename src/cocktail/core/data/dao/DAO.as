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

package cocktail.core.data.dao
{
	import cocktail.core.Index;
	
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;	

	/**
	* Default DAO to be extended for all DAO objects
	*/
	public class DAO extends Index {
		
		/**
		 * Creates a new DAO instance
		 */
		public function DAO() {
			
		}
		
		/**
		 * Default DAO conversion to string (debug uses)
		 * @return	The DAO data converted into string.
		 */
		public function toString():String {
			var result:String;
			var vars:XMLList;
			var i:uint;
			
			result = "\r[ " + getQualifiedClassName(this) + " ]\r";
			vars = describeType(this)..variable;
			
			for (i = 0; i < vars.length(); i++) {
				result += "\t[" + vars[i].@name + "]:" + vars[i].@type + " = {" + this[vars[i].@name] + "}\r";
			}
			
			result += "[ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ]\r";
			
			return result;
		}
		
		
	}
	
}