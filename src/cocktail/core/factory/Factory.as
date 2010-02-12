/*	****************************************************************************
Cocktail ActionScript Full Stack Framework. Copyright(C) 2009 Codeine.
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

package cocktail.core.factory 
{
	import cocktail.core.Index;

	import flash.utils.getDefinitionByName;

	/**
	 * Factory class.
	 * @author hems | hems@codeine.it
	 * @author nybras | nybras@codeine.it
	 */
	public class Factory extends Index
	{
		/* ERROR MESSAGE TEMPLATE */
		
		/**
		 * Formats an customized prefrix error message based on given name.
		 * @param name	Class name not found.
		 * @param kind	Base class name.
		 */
		private function _m( name : String, base : String ) : String
		{
			var message : String;
			
			message = "Class '" + ( name ? name + base : "null" );
			message += "' was not found, so the default " + base + " was used.";
			
			return message;
		}

		
		
		/* CLASS EVALUATOR */
		
		/**
		 * Returns a class reference according the given classpath.
		 * @param classpath	Desired classpath.
		 * @return	The found class reference.
		 */
		public function evaluate( classpath : String ) : Class
		{
			return Class( getDefinitionByName( classpath ) );
		}

		
		
		/* MVCL */
		
		/**
		 * Evaluates classes for Model, View, Controller and Layout.
		 * @param folder	Class folder name.
		 * @param classname	Class name.
		 */
		private function _mvcl( folder : String, classname : String ) : Class
		{
			var klass : Class;
			var path : String;
			
			path = _cocktail.app_id + "." + folder + "." + classname;
			return evaluate( path );
		}

		/**
		 * Evaluates the given Controller class by name and return it.
		 * @param name	Controller name (CamelCased).
		 * @return	Controller class to be instantiated.
		 */
		public function controller( name : String ) : Class
		{
			try
			{
				return _mvcl( "controllers", name + "Controller" );
			} catch( e : Error )
			{
				log.warn( _m( name, "Controller" ) );
			}
			return evaluate( "cocktail.lib.Controller" );
		}

		/**
		 * Evaluates the given Model class by name and return it.
		 * @param name	Model name (CamelCased).
		 * @return	Model class to be instantiated.
		 */
		public function model( name : String ) : Class
		{
			try
			{
				return _mvcl( "models", name + "Model" );
			} catch( e : Error )
			{
				log.warn( _m( name, "Model" ) );
			}
			return evaluate( "cocktail.lib.Model" );
		}

		/**
		 * Evaluates the given Layout class by name and return it.
		 * @param name	Layout name (CamelCased).
		 * @return	Layout class to be instantiated.
		 */
		public function layout( name : String ) : Class
		{
			try
			{
				return _mvcl( "layouts", name + "Layout" );
			} catch( e : Error )
			{
				log.warn( _m( name, "Layout" ) );
			}
			return evaluate( "cocktail.lib.Layout" );
		}

		/**
		 * Evaluates the given View class by name and return it.
		 * @param name	View name (CamelCased).
		 * @return	View class to be instantiated.
		 */
		public function view( name : String ) : Class
		{
			try
			{
				return _mvcl( "views", name + "View" );
			} catch( e : Error )
			{
				log.warn( _m( name, "View" ) );
			}
			return evaluate( "cocktail.lib.View" );
		}
	}
}