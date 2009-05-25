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
	import cocktail.core.data.bind.Bind;
	import cocktail.lib.Model;
	import cocktail.lib.View;
	import cocktail.lib.cocktail.interfaces.IPreProcessor;	

	/**
	 * Pre Processor class for <sweep> tags.
	 * @author nybras | nybras@codeine.it
	 * @see	PreProcessor
	 * @see Globals
	 * @see Params
	 * @see Loops
	 * @see IPreProcessor
	 */
	public class Sweeps extends Index implements IPreProcessor
	{

		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _bind : Bind;
		private var _model : Model;
		private var _view : View;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new Sweeps instance.
		 * @param bind	Controller's Bind reference.
		 * @param model	Controller's Model reference.
		 * @param view	Controller's View reference.
		 */
		public function Sweeps ( bind : Bind, model : Model, view : View )
		{
			_bind = bind;
			_model = model;
			_view = view;
		}
		
		
		
		/* ---------------------------------------------------------------------
			PRE-PROCESSING
		--------------------------------------------------------------------- */
		
		/**
		 * Pre-process all SWEEP tags.
		 * @param xml	The xml content to be pre-processed.
		 * @param path	The path of the xml file ( just to display clear error messages ).
		 * @return	The xml pos-processed.
		 */
		public function preprocess ( xml : XML, path : String ) : XML
		{
//			var item : XML;
			
			var sweep : XML;
			var content : XML;
			var children : String;
			
			var datasource : String;
			var name : String;
			var value : String;
			
//			var sweeped : String;
			var buffer : XMLList;
			
			if ( ! xml..sweep.length() )
				return xml;
			
			content = new XML ( xml.toString() );
			sweep = content..sweep[ 0 ];
			children = sweep.children().toXMLString();
			
			datasource = sweep.@datasource;
			name = "#"+ sweep.@name +"#";
			value = "#"+ sweep.@value +"#";
			
			if ( name == "##" )
				log.warn( "You probably want to use some NAME alias at the <sweep/> tag in file "+ path +"\r\r\t"+ sweep.toXMLString() );
			
			if ( value == "##" )
				log.warn( "You probably want to use some VALUE alias at the <sweep/> tag in file "+ path +"\r\r\t"+ sweep.toXMLString() );
			
			buffer = new XMLList( <root/> );
			
//			TODO - fix block
//			for each ( item in _model.datasource( datasource ).binds )
//			{
//				sweeped = children.split( name ).join( item.localName() as String );
//				sweeped = sweeped.split( value ).join( _bind.g ( item.localName() as String ) );
//				
//				buffer.appendChild( new XMLList ( sweeped ) );
//			}
			
			sweep.parent().replace( sweep.childIndex(), buffer.children() );
			
			return content;
		}
	}
}