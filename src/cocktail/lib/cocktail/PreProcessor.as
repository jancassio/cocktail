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

package cocktail.lib.cocktail 
{	import cocktail.core.Index;	import cocktail.core.data.bind.Bind;	import cocktail.lib.Model;	import cocktail.lib.View;	import cocktail.lib.cocktail.preprocessor.Globals;	import cocktail.lib.cocktail.preprocessor.Loops;	import cocktail.lib.cocktail.preprocessor.Params;	import cocktail.lib.cocktail.preprocessor.Sweeps;		/**
	 * Pre Processor main class.
	 * @author nybras | nybras@codeine.it
	 * @see	Globals	 * @see	Params	 * @see	Loops	 * @see	Sweeps
	 * @see	IPreProcessor	 */	public class PreProcessor extends Index 	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var globals : Globals;
		private var params : Params;
//		private var commands : Commands;
		private var loops : Loops;
		private var sweeps : Sweeps;
		
		
		
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
			globals = new Globals();			params = new Params();//			commands = new Commands( bind, model, view );
			loops = new Loops();			sweeps = new Sweeps( bind, model, view );		}

		
		
		/* ---------------------------------------------------------------------
			PRE PROCESSING
		--------------------------------------------------------------------- */
		
		/**
		 * Pre processing globals.
		 * @param source	The xml content to be pre processed.
		 * @param path	The xml file path.
		 * @return	The given xml source, with all GLOBALS pre processed.
		 */
		public function preprocess_globals ( source : XML, path : String ) : XML
		{
			return globals.preprocess( source, path );
		}
		
		/**
		 * Pre processing action params.
		 * @param source	The xml content to be pre processed.
		 * @param path	The xml file path.
		 * @return	The given xml source, with all PARAMS pre processed.
		 */
		public function preprocess_params ( source : XML, path : String ) : XML
		{
			return params.preprocess( source, path );
		}
		
//		/**
//		 * Pre processing commands. 
//		 * @param source	The xml content to be pre processed.
//		 * @param path	The xml file path.
//		 * @return	The given xml source, with all COMMANDS pre processed.
//		 */
//		public function preprocess_comands ( source : XML, path : String ) : XML
//		{
//			return commands.preprocess( source, path );
//		}
		
		/**
		 * Pre processing loops. 
		 * @param source	The xml content to be pre processed.
		 * @param path	The xml file path.
		 * @return	The given xml source, with all LOOPS pre processed.
		 */
		public function preprocess_loops ( source : XML, path : String ) : XML
		{
			return loops.preprocess( source, path );
		}
		
		/**
		 * Pre processing sweeps.
		 * @param source	The xml content to be pre processed.
		 * @param path	The xml file path.
		 * @return	The given xml source, with all SWEEPS pre processed.
		 */
		public function preprocess_sweeps ( source : XML, path : String ) : XML
		{
			return sweeps.preprocess( source, path );
		}
	}}