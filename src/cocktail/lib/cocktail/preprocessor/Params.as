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
{	import cocktail.core.data.dao.ProcessDAO;	
	import cocktail.core.Index;
	import cocktail.lib.cocktail.interfaces.IPreProcessor;
	import cocktail.utils.StringUtil;	

	/**
	 * Pre Processor class for PARAMS ( /action/param1/param1/paramN... ).
	 * @author nybras | nybras@codeine.it
	 * @see	PreProcessor
	 * @see Globals
	 * @see Loops
	 * @see Sweeps
	 * @see IPreProcessor
	 */	public class Params extends Index implements IPreProcessor 
	{
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new Globals instance.
		 */
		public function Params () {}
		
		
		
		/* ---------------------------------------------------------------------
			PRE-PROCESSING
		--------------------------------------------------------------------- */
		
		/**
		 * Pre-process all global variables.
		 * @param xml	The xml content to be pre-processed.
		 * @param path	The path of the xml file ( just to display clear error messages ).
		 * @return	The xml pos-processed.
		 */
		public function preprocess ( xml : XML, path : String ) : XML
		{
			var content : String;
			var params : Array;
			var param : String;
			var index : *;
			
			content = xml.toString();
			params = new ProcessDAO ( config.location, false, false ).params;
			
			for each ( param in StringUtil.enclosure( content, "$", "$" ) )
			{
				index = StringUtil.innerb( param );
				
				if ( isNaN( index ) )
					log.fatal( "You can use @param@ tags only with NUMERIC indexes. Found '"+ param +"' in file "+ path +"\r\r\t"+ xml.toXMLString() );
				
				content = content.split( param ).join( params [ index ] );
			}
			
			return new XML ( content );
		}
	}
}