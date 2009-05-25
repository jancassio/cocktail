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

package cocktail.lib.cocktail.preprocessor.processors 
{
	import cocktail.core.Index;
	import cocktail.lib.cocktail.preprocessor.interfaces.IPreProcessor;
	import cocktail.utils.StringUtil;	

	/**
	 * Pre Processor class for GLOBALS VARS ( usually, config vars ).
	 * @author nybras | nybras@codeine.it
	 * @see	PreProcessor
	 * @see Params
	 * @see Loops
	 * @see Sweeps
	 * @see IPreProcessor
	 */
	public class Globals extends Index implements IPreProcessor
	{
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new Globals instance.
		 */
		public function Globals () {}
		
		
		
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
			var global : String;
			
			content = xml.toString();
			
			for each ( global in StringUtil.enclosure( content, "%", "%" ) )
				content = content.split( global ).join ( read ( global, path ) );
			
			return new XML ( content );
		}
		
		/**
		 * Read some global.
		 * @param global	Global to be read.
		 * @param path	Path of the xml being pre-processed.
		 * @return	The global value if found, otherwise fires a fatal message. 
		 */
		private function read ( global : String, path : String ) : String
		{
			var value : String;
			
			switch ( StringUtil.innerb( global ) )
			{
				case "MOVIE_SCALE_MODE":	value = config.movie ( "scaleMode" );		break;
				case "MOVIE_SHOW_MENU":		value = config.movie ( "showMenu" );		break;
				case "MOVIE_WIDTH":			value = config.movie ( "width" );			break;
				case "MOVIE_HEIGHT":		value = config.movie ( "height" );			break;
				case "MOVIE_ALIGN":			value = config.movie ( "align" );			break;
				
				case "PATH_DEFAULT":		value = config.root ();						break;
				case "PATH_LOCAL":			value = config.root ( "local" );			break;
				case "PATH_DEVELOPMENT":	value = config.root ( "development" );		break;
				case "PATH_PRODUCTION":		value = config.root ( "production" );		break;
				
				case "FILETYPE_CSS":		value = config.path ( ".css" );				break;
				case "FILETYPE_FLV":		value = config.path ( ".flv" );				break;
				case "FILETYPE_IMG":		value = config.path ( ".img" );				break;
				case "FILETYPE_SWF":		value = config.path ( ".swf" );				break;
				case "FILETYPE_XML":		value = config.path ( ".xml" );				break;
				case "FILETYPE_FONT":		value = config.path ( ".font" );			break;
				
				case "GATEWAY_DEFAULT":		value = config.gateway ();					break; 
				case "GATEWAY_LOCAL":		value = config.gateway ( "local" );			break; 
				case "GATEWAY_DEVELOPMENT":	value = config.gateway ( "development" );	break; 
				case "GATEWAY_PRODUCTION":	value = config.gateway ( "production" );	break;
				
				case "LOCALE_DEFAULT":		value = config.defaultLocale;				break;
				case "LOCALE_CURRENT":		value = config.current_locale;				break;	
			}
			
			if ( value == null )
				log.warn( "Error parsing document structure globals : "+ path +".\r Key '"+ global +"' is not a global variable." );
			
			return value;
		}
	}
}