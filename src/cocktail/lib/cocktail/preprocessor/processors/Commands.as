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

package cocktail.lib.cocktail.preprocessor.processors {	import cocktail.core.Index;	import cocktail.core.data.bind.Bind;	import cocktail.lib.Model;	import cocktail.lib.View;	import cocktail.lib.cocktail.interfaces.IPreProcessor;	import cocktail.utils.StringUtil;			/**	 * Pre Processor class for COMMANDS keys.	 * @author nybras | nybras@codeine.it	 * @see	PreProcessor	 * @see Globals	 * @see Params	 * @see Loops	 * @see Sweeps	 * @see IPreProcessor	 */	public class Commands extends Index implements IPreProcessor 	{		/* ---------------------------------------------------------------------			VARS		--------------------------------------------------------------------- */				private var bind : Bind;		private var model : Model;		private var view : View;								/* ---------------------------------------------------------------------			INITIALIZING		--------------------------------------------------------------------- */				/**		 * Creates a new Commands instance.		 * @param bind	Controller's Bind reference.		 * @param model	Controller's Model reference.		 * @param view	Controller's View reference.		 */		public function Commands ( bind : Bind, model : Model, view : View )		{			this.bind = bind;			this.model = model;			this.view = view;		}								/* ---------------------------------------------------------------------			PRE-PROCESSING		--------------------------------------------------------------------- */				/**		 * Pre-process some xml content, replacing all command-template-keys by its value.		 * @param xml	The xml content to be pre-processed.		 * @param path	The path of the xml file ( just to display clear error messages ).		 * @return	The xml pos-processed.		 */		public function preprocess ( xml : XML, path : String ) : XML		{			var content : String;			var command : String;						var operators : Array;			var values : Array;						content = xml.toString();						for each ( command in StringUtil.enclosure ( content, ":", ":") )			{				operators = command.match( new RegExp ( "[/\*\+\-]", "g" ) );				values = command.match( new RegExp ( "[^\/\*\+\-]+", "g" ) );								process_expressions( values );								process_multiplication ( operators, values );				process_division ( operators, values );				process_addition ( operators, values );				process_subtraction ( operators, values );								content.replace( command, values[ 0 ] );			}						return new XML ( content );		}								private function process_expressions ( values : Array ) : void		{			var i : uint;			var len : uint;			var steps : Array;			var step : String;			var value : String;			var buffer : *;						len = values.length;						for ( i = 0; i < len; i++ )			{				value = values[ i ];								if ( ! isNaN ( ( value as Number ) ) )					continue;								steps = value.split( "." );								while ( steps.length )				{					step = steps.shift();
					//					TODO - fix block//					if ( step.substr ( 0, 5 ) == "bind=" )//						buffer = bind.g( step.substr ( 5 ) );//					else if ( step.substr ( 0, 3 ) == "ds=" )//						buffer = model.datasource( step.substr ( 3 ) ).binds;//					else//						try {//							if ( step.substr( -2 ) == "()" )//								buffer = buffer[ step.slice( 0, -2 ) ]();//							else//								buffer = buffer[ step ];//						} catch ( e : Error ) {//							log.fatal( e.message );//						}				}								values[ i ] = buffer;			}		}								private function process_multiplication (operators : Array, values : Array) : void		{					}		private function process_division (operators : Array, values : Array) : void		{					}		private function process_addition (operators : Array, values : Array) : void		{					}		private function process_subtraction (operators : Array, values : Array) : void		{					}	}}