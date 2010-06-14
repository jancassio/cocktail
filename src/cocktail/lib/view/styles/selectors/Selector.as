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
	import cocktail.core.data.bind.Binded;
	import cocktail.lib.view.styles.Style;
	import cocktail.utils.StringUtil;

	/**
	 * Selector base class.
	 * @author nybras | nybras@codeine.it
	 */
	public class Selector extends Index
	{

		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _booted : Boolean;
		
		private var _last_property : String;
		private var _last_value : String;
		
		protected var _name : String;
		protected var _properties : Bind;
		
		protected var _parent : Style;
		protected var _buffer : String;
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Boot all selectors and fill all styles / properties.
		 * @param name	Style name.
		 * @param properties	Parse style.
		 */
		public function boot (
			name : String,
			properties: *,
			parent : Style  = null
		) : void
		{
			var key : String;
			var value : String;
			
			if ( _booted )
				return;
			
			_name = name;
			_parent = parent;
			_properties = new Bind ();
			
			for ( key in properties )
			{
				try
				{
					name = StringUtil.replace_all ( key, "-", "_" );
					name = StringUtil.trim ( name ).toLowerCase();
					value = StringUtil.trim ( properties[ key ] );
					
					this[  name ] = value;
				}
				catch ( e : Error )
				{
					log.error( e );
				}
			}
		}
		
		
		
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
		
		/**
		 * Gets the the last modified property.
		 * @return	Last modified property.
		 */
		public function get last_modified_property () : *
		{
			return _last_property;
		}

		/**
		 * Gets the value of the last modified property.
		 * @return	Value of the last modified property.
		 */
		public function get last_modified_value () : *
		{
			return _last_value;
		}

		
		
		/* ---------------------------------------------------------------------
			PLUG / UNPLUG & TOUCH / UNTOUCH
		--------------------------------------------------------------------- */
		
		/**
		 * Plug some property.
		 * @param name	Property name to plug.
		 * @param handler	Property update handler.
		 */
		public function plug ( name : String, handler : Function ) : Binded
		{
			return _properties.plug( name, handler );
		}
		
		/**
		 * Unplug some property.
		 * @param property	Property name to unplug.
		 * @param handler	Property update handler.
		 */
		public function unplug ( name : String, handler : Function ) : Boolean
		{
			return _properties.unplug( name, handler );
		}
		
		
		
		/**
		 * Plug (touch) some property.
		 * @param name	Property name to plug.
		 * @param methods	Methods to be touched when the key value changes, it
		 * can be just a single method or an array with many methods.
		 */
		public function touch ( name : String, methods : * ) : void
		{
			_properties.touch( name, methods );
		}
		
		/**
		 * Unplug (untouch) some property.
		 * @param property	Property name to untouch.
		 * @param methods	Methods to be untouched, it can be just a single
		 * method or an array with many methods.
		 * @return	<code>true</code> if the property is untouched successfully,
		 * <code>false</code> otherwise.
		 */
		public function untouch ( name : String, methods : * ) : Boolean
		{
			return _properties.untouch( name, methods );
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
				_buffer = Selector( _parent )._properties.g( property );
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
			return _properties.s( _last_property=property, _last_value=value );
		}
	}
}