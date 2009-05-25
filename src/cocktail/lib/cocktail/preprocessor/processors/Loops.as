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
	import cocktail.lib.cocktail.interfaces.IPreProcessor;	
	
	/**
	 * Pre Processor class for <loop> tags.
	 * @author nybras | nybras@codeine.it
	 * @see	PreProcessor
	 * @see Globals
	 * @see Params
	 * @see Sweeps
	 * @see IPreProcessor
	 */
	public class Loops extends Index implements IPreProcessor
	{
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new Loops instance.
		 */
		public function Loops () {}
		
		
		
		/* ---------------------------------------------------------------------
			PRE-PROCESSING
		--------------------------------------------------------------------- */
		 
		/**
		 * Pre-process all loops.
		 * @param xml	The xml content to be pre-processed.
		 * @param path	The path of the xml file ( just to display clear error messages ).
		 * @return	The xml pos-processed.
		 */
		public function preprocess ( xml : XML, path : String ) : XML
		{
			var content : XML;
			
			content = new XML ( xml.toString() );
			
			if ( content..loop.length() )
				process ( content, path );
			
			return content;
		}
		
		/**
		 * Process all <loop> tags, recursively.
		 * @param xml	The xml being pre-processed.
		 * @param path	The xml's path.
		 */
		private function process ( xml : XML, path : String ) : void
		{
			var loop : XML;
			var children : XMLList;
			var content : String;
			var buffer : XMLList;
			
			var times : uint;
			var time : uint;
			var iterator : String;
			
			loop = xml..loop[ 0 ];
			children = loop.children();
			content = children.toXMLString();
			
			buffer = new XMLList( <root/> );
			times = loop.@times;
			iterator = "#"+ loop.@iterator +"#";
			
			if ( iterator == "##" )
				log.warn( "You probably want to use some interator at the <loop/> tag in file "+ path +"\r\r\t"+ loop.toXMLString() );
			
			for ( time = 1; time <= times; time++ )
				buffer.appendChild( content.split( iterator ).join ( time ) );
			
			loop.parent().replace( loop.childIndex(), new XMLList ( buffer.children() ) );
			
			if ( xml..loop.length() )
				process( xml, path );
		}
	}
}