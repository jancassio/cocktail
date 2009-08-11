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

package cocktail.core.router
{
	/**
	 * Handles all Routes translations.
	 * @author nybras | nybras@codeine.it
	 */
	public class Routes 
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _mappings : Array = [];
		
		
		
		/* ---------------------------------------------------------------------
			MAPPING
		--------------------------------------------------------------------- */
		
		/**
		 * Adds a mapping routine.
		 * @param mask	Url mask.
		 * @param target	Url target.
		 */
		public function map( mask : String, target : String ) : void
		{
//			TODO: implement method
//			
//			thoughts:
//			
//			if( ArrayUtil.has( _mappings, mask, "mask" ) )
//				ArrayUtil.del( _mappings, mask, "mask" );
			
			_mappings.push( new MapVO( mask, target ) );
		}
		
		
		
		/* ---------------------------------------------------------------------
			WRAP / UNWRAP
		--------------------------------------------------------------------- */
		
		/**
		 * Wraps a normal url into it's mask representation.
		 * @param target	Target url to wrap.
		 * @return	The mask for the given target url.
		 */
		public function wrap( target : String ) : String
		{
//			TODO: re-implement method
			return target;
		}
		
		/**
		 * Unwraps a normal url into it's mask representation.
		 * @param target	Target url to wrap.
		 * @return	The mask for the given target url.
		 */
		public function unwrap( mask : String ) : String
		{
//			TODO: re-implement method
			return mask;
		}
	}
}



/**
 * VO to store mappings objects.
 */
internal class MapVO
{
	public var mask : String;
	public var target : String;
	
	/**
	 * Creates a new MapVO instance.
	 * @param mask	Url mask.
	 * @param target	Url target.
	 */
	public function MapVO( mask : String, target : String )
	{
		this.mask = mask;
		this.target = target;
	}
}