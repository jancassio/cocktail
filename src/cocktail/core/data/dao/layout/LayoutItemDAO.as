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

package cocktail.core.data.dao.layout 
{	import cocktail.core.data.bind.Bind;
	import cocktail.core.data.dao.DAO;
	import cocktail.lib.View;
	import cocktail.utils.StringUtil;
	
	import flash.utils.describeType;	

	/**
	 * Layout's item data-access-object, used by View class.
	 * 
	 * @author nybras | nybras@codeine.it
	 * @see	LayoutItemDAO
	 */	public class LayoutItemDAO extends DAO 
	{
		
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		protected var view : View;
		protected var bind : Bind;
		
		public var xml : XML;
		protected var variables : XMLList;
		
		public var category : String;
		public var shared : Boolean;
		public var classname : String;
		public var id : String;
		public var src : String;
		public var data : *;
		public var style : String;
		public var childs : Array;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new LayoutItem instance.
		 */
		public function LayoutItemDAO () {}
		
		/**
		 * Boots the DAO with the givem params.
		 * @param up	The item related view.
		 * @param bind	The view related target.
		 * @param item	The item xml node.
		 */
		public function boot ( view : View, bind : Bind, item : XML ) : void
		{
			this.view = view;
			this.bind = bind;
			this.xml = item;
			
			this.category = ( xml.localName() as String );
			this.childs = new Array();
			
			variables = describeType( this )..variable;
			
			this.parse();
		}
		
		
		
		
		/* ---------------------------------------------------------------------
			BINDING ( plug )
		--------------------------------------------------------------------- */
		
		/**
		 * 
		 */
		public function plugBinds () : void
		{
			var variable : XML;
			var value : *;
			var name : String;
			var bindExp : String;
			
			for each ( variable in variables )
			{
				name = variable.@name;
				value = this[ name ];
				
				if ( name == "xml" || name == "childs" || value == undefined || value == null )
					continue;
				
				for each ( bindExp in StringUtil.enclosure( value, "{", "}") )
					this[ name ] = this[ name ].toString().replace( bindExp, bind.g( StringUtil.innerb( bindExp ) ) );
			}
		}
		
		
		
		/* ---------------------------------------------------------------------
			PARSING
		--------------------------------------------------------------------- */
		
		/**
		 * Parses the item's xml node into DAO object.
		 */
		private function parse () : void
		{
			var variable : XML;
			var value : *;
			
			for each ( variable in variables )
				if ( ( value = xml.@[ variable.@name ] ) != undefined )
				{
					switch ( variable.@type )
					{
						case "Boolean":
							value = ( value == "true" || value == true );
						break;
					}
					this[ variable.@name ] = value;
				}
		}
	}}