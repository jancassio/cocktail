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

package cocktail.lib.cocktail.preprocessor 
{
	import cocktail.core.Index;
	import cocktail.core.data.bind.Bind;
	import cocktail.lib.Model;
	import cocktail.lib.View;
	import cocktail.lib.cocktail.preprocessor.processors.Binds;
	import cocktail.lib.cocktail.preprocessor.processors.Globals;
	import cocktail.lib.cocktail.preprocessor.processors.Loops;
	import cocktail.lib.cocktail.preprocessor.processors.Params;
	import cocktail.lib.cocktail.preprocessor.processors.Sweeps;	

	/**
	 * Pre Processor main class.
	 * @author nybras | nybras@codeine.it
	 * @see	Globals
	 * @see	Params
	 * @see	Loops
	 * @see	Sweeps
	 * @see	Binds
	 * @see	IPreProcessor
	 */
	public class PreProcessor extends Index 
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _globals : Globals;
		private var _params : Params;
//		private var commands : Commands;
		private var _loops : Loops;
		private var _sweeps : Sweeps;
		private var _binds : Binds;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new PreProcessor instance.
		 * @param bind	Controller's Bind reference.
		 * @param model	Controller's Model reference.
		 * @param view	Controller's View reference.
		 */
		public function PreProcessor ( bind : Bind, model : Model, view : View )
		{
			_globals = new Globals();
			_params = new Params();
//			commands = new Commands( bind, model, view );
			_loops = new Loops();
			_sweeps = new Sweeps( bind, model, view );
			_binds = new Binds( bind, model, view );
		}
		
		
		
		/* ---------------------------------------------------------------------
			PRE PROCESSING
		--------------------------------------------------------------------- */
		
		/**
		 * Pre-processing globals.
		 * @param source	The xml content to be pre processed.
		 * @param path	The xml file path.
		 * @return	The given xml source, with all GLOBALS pre processed.
		 */
		public function globals ( source : XML, path : String ) : XML
		{
			return _globals.preprocess( source, path );
		}
		
		/**
		 * Pre-processing action params.
		 * @param source	The xml content to be pre processed.
		 * @param path	The xml file path.
		 * @return	The given xml source, with all PARAMS pre processed.
		 */
		public function params ( source : XML, path : String ) : XML
		{
			return _params.preprocess( source, path );
		}
		
//		/**
//		 * Pre-processing commands. 
//		 * @param source	The xml content to be pre processed.
//		 * @param path	The xml file path.
//		 * @return	The given xml source, with all COMMANDS pre processed.
//		 */
//		public function comands ( source : XML, path : String ) : XML
//		{
//			return commands.preprocess( source, path );
//		}
		
		/**
		 * Pre-processing loops. 
		 * @param source	The xml content to be pre processed.
		 * @param path	The xml file path.
		 * @return	The given xml source, with all LOOPS pre processed.
		 */
		public function loops ( source : XML, path : String ) : XML
		{
			return _loops.preprocess( source, path );
		}
		
		/**
		 * Pre-processing sweeps.
		 * @param source	The xml content to be pre processed.
		 * @param path	The xml file path.
		 * @return	The given xml source, with all SWEEPS pre processed.
		 */
		public function sweeps ( source : XML, path : String ) : XML
		{
			return _sweeps.preprocess( source, path );
		}
		
		/**
		 * Pre-processing/Plugging binds.
		 * @param source	The xml content to be pre processed.
		 * @param path	The xml file path.
		 * @return	The given xml source, with all BINDS pre processed.
		 */
		public function binds ( source : XML, path : String ) : XML
		{
			return _binds.preprocess( source, path );
		}
	}
}