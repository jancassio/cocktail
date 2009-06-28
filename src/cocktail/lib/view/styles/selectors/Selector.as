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

package cocktail.lib.view.styles.selectors 
{
	import cocktail.core.Index;
	import cocktail.core.data.bind.Bind;
	import cocktail.lib.view.styles.Style;		

	/**
	 * Selector base class.
	 * @author nybras | nybras@codeine.it
	 */
	public class Selector extends Index
	{

		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		protected var _name : String;
		protected var _properties : Bind;
		
		protected var _parent : Style;
		protected var _buffer : String;
		
		
		
		/* ---------------------------------------------------------------------
			GETTERS
		--------------------------------------------------------------------- */
		
		/**
		 * Gets the style name.
		 * @return	Style name.
		 */
		public function get name () : String
		{
			return _name;
		}
		
		/**
		 * Gets the parent style.
		 * @return	Parent style.
		 */
		public function get parent () : Style
		{
			return _parent;
		}
		
		
		
		/* ---------------------------------------------------------------------
			PLUG / UNPLUG
		--------------------------------------------------------------------- */
		
		/**
		 * Plug some property.
		 * @param property	Property name to plug.
		 * @param handler	Property update handler.
		 */
		public function plug ( name : String, handler : Function ) : void
		{
			_properties.plug( name, handler );
		}
		
		/**
		 * Unplug some property.
		 * @param property	Property name to unplug.
		 * @param handler	Property update handler.
		 */
		public function unplug ( name : String, handler : Function ) : void
		{
			_properties.unplug( name, handler );
		}
		
		
		
		/* ---------------------------------------------------------------------
			READ / WRITE
		--------------------------------------------------------------------- */
		
		/**
		 * Read some property.
		 * @param property	Property name.
		 * @return	The property value.
		 */
		protected function r ( property : String ) : String
		{
			_buffer = null;
			
			try
			{
				_buffer = _properties.g( property );
			}
			catch ( e : Error )
			{
				_buffer = _parent._properties.g( property );
			}
			
			return _buffer;
		}
		
		/**
		 * Write some property.
		 * @param property	Property name.
		 * @param value	Property value.
		 */
		protected function w ( property : String, value : * ) : *
		{
			return _properties.s( property, value );
		}
	}
}