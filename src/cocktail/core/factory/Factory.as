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
	import cocktail.Cocktail;
	import cocktail.core.Index;
	import cocktail.lib.Controller;
	import cocktail.lib.Layout;
	import cocktail.lib.Model;
	
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;	

	/**
	 * Factory class.
	 * @author hems | hems@codeine.it
	 */
	public class Factory extends Index
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _uniques : Dictionary;
		private var _app_id : String;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */

		/**
		 * @param app owner of the fabric
		 */
		public function Factory( cocktail : Cocktail )
		{
			super( cocktail );
			_uniques = new Dictionary();
		}
		
		
		
		/* ---------------------------------------------------------------------
			CLASS GETTER
		--------------------------------------------------------------------- */
		
		/**
		 * Returns a class reference according the given classpath.
		 * @param class_path	Classpath to return.
		 * @return	The found class.
		 */
		public function get_class ( classpath : String ) : Class {
			return getDefinitionByName( classpath ) as Class;
		}
		
		
		
		/* ---------------------------------------------------------------------
			CONTROLLERS
		--------------------------------------------------------------------- */
		
		/**
		 * Return a unique controller
		 * @param process	ProcessDAO to get the controller search.
		 */
		public function controller( clean_class_name : String ) : Controller
		{
			var cls : Class;
			var ctrl : Controller;
			var path : String;
			
			path = _app_id + ".controllers." + clean_class_name + "Controller";
			
			if( defined( _uniques, path ) )
				cls = _uniques[ path ];
			else
			{
				cls = get_class( path );
				ctrl = new cls();
				_uniques[ path ] = ctrl;
			}
			
			return ctrl;
		}
		
		
		/* ---------------------------------------------------------------------
			MODEL
		--------------------------------------------------------------------- */
		
		/**
		 * Return a unique model
		 * @param process	ProcessDAO to get the controller search.
		 */
		public function model( clean_class_name : String ) : Model
		{
			var cls : Class;
			var model : Model;
			var path : String;
			
			path = _app_id + ".models." + clean_class_name + "Model";
			
			if( defined( _uniques, path ) )
				cls = _uniques[ path ];
			else
			{
				cls = get_class( path );
				model = new cls();
				_uniques[ path ] = cls;
			}
			
			return model;
		}
		
		
		
		/* ---------------------------------------------------------------------
			VIEW
		--------------------------------------------------------------------- */
		
		// TODO: write documentation
		public function layout( clean_class_name : String ) : Layout
		{
			var path : String;
			path = _app_id + ".layouts." + clean_class_name + "Layout";
			
			return new ( get_class( path ) )();
		}
	}
}