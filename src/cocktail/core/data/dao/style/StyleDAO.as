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

package cocktail.core.data.dao.style 
{
	import cocktail.core.data.dao.DAO;	import cocktail.lib.View;	import cocktail.lib.view.elements.FontElement;		import flash.display.DisplayObject;	import flash.display.Sprite;	import flash.utils.describeType;		
	/**
	 * Style data access object, used by View class.
	 * 
	 * @author nybras | nybras@codeine.it
	 * @see View
	 */
	public class StyleDAO extends DAO 
	{
		
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var xml : XML;
		private var vars : XMLList;
		
		protected var autoApplicableVars : String;
		
		public var id : String;
		
		public var display : String = "block";
		
		public var x : Number;
		public var y : Number;
		public var z : Number;
		
		public var alpha : Number = 1;
		public var rotation : Number = 0;
		
		public var width : Number;
		public var height : Number;
		
		public var scaleX : Number;
		public var scaleY : Number;
		
		public var align : String;
		public var valign : String;
		
		public var color : uint = 0x000000;
		
		public var visible : Boolean = true;
		
		// margins
		private var _margin : String = "0";
			public var margin_right : Number = 0;
			public var margin_bottom : Number = 0;
			public var margin_left : Number = 0;
			public var margin_top : Number = 0;
		
		// paddings
		private var _padding : String = "0";
			public var padding_right : Number = 0;
			public var padding_bottom : Number = 0;
			public var padding_left : Number = 0;
			public var padding_top : Number = 0;
		
		// snaps
			 /**
			 * snap = x y z;	
			 * 		x=[0], [0.5], [1]
			 * 		y=[0], [0.5], [1]
			 * 		z=[0], [0.5], [1]
			 */
		private var _snap : String;
			public var snap_x : Number;
			public var snap_y : Number;
			public var snap_z : Number;
		
		public var absolute : Boolean = false;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new StylesDAO instance.
		 * @param item	The item xml node.
		 */
		public function StyleDAO ( item : XML = null ) {
			autoApplicableVars = "|z|x|y|alpha|visible|rotation|width|height|scaleX|scaleY|";
			vars = describeType( this )..variable + describeType( this )..accessor;
			xml = item;
			parse();
		}
		
		
		
		/* ---------------------------------------------------------------------
			SETTERs
		--------------------------------------------------------------------- */
		
		/**
		 * Sets all paddings, according the right sequencue (left, top, right, bottom).
		 * 
		 * @param value	The padding value. You can informe it divided by space like "0 1 2 3",
		 * 				where 0=left, 1=top, 2=right, 3=bottom. If you inform only one value its
		 * 				applied for all cases, otherwise, only to the items you've informed. 
		 */
		public function set padding ( value : String ) : void
		{
			var values : Array;
			
			values = ( _padding = value ).split( " " );
			
			if ( values.length == 4 )
				padding_bottom = values[ 3 ];
			
			if ( values.length >= 3 )
				padding_right = values[ 2 ];
			
			if ( values.length >= 2 )
				padding_top = values[ 1 ];
			
			if ( values.length >= 1 )
				padding_left = values[ 0 ];
			
			if ( values.length == 1 )
				padding_top =
				padding_right =
				padding_bottom = padding_left;
		}
		
		/**
		 * Sets all margin, according the right sequencue (left, top, right, bottom).
		 * 
		 * @param value	The padding value. You can informe it divided by space like "0 1 2 3",
		 * 				where 0=left, 1=top, 2=right, 3=bottom. If you inform only one value its
		 * 				applied for all cases, otherwise, only to the items you've informed. 
		 */
		public function set margin ( value : String ) : void
		{
			var values : Array;
			
			values = ( _margin = value ).split( " " );
			
			if ( values.length == 4 )
				margin_bottom = values[ 3 ];
			
			if ( values.length >= 3 )
				margin_right = values[ 2 ];
			
			if ( values.length >= 2 )
				margin_top = values[ 1 ];
			
			if ( values.length >= 1 )
				margin_left = values[ 0 ];
			
			if ( values.length == 1 )
				margin_top =
				margin_right =
				margin_bottom = margin_left;
		}
		
		/**
		 * Sets all snap properties, according the right sequencue (x, y, z).
		 * 
		 * @param value	The snap properties, divided by space. you can informe only x, x and y, and x, y and z. 
		 */
		public function set snap ( value : String ) : void
		{
			var values : Array;
			
			values = ( _snap = value ).split( " " );
			
			if ( values.length == 3 )
				snap_z = values[ 2 ];
			
			if ( values.length >= 2 )
				snap_y = values[ 1 ];
			
			if ( values.length >= 1 )
				snap_x = values[ 0 ];
		}
		
		
		
		public function get margin () : String {	return _margin;		}
		public function get padding () : String {	return _padding;	}
		public function get snap () : String {		return _snap;		}
		
		
		
		/* ---------------------------------------------------------------------
			PARSING
		--------------------------------------------------------------------- */
		
		/**
		 * Parses the item's xml node into DAO object.
		 */
		private function parse () : void
		{
			var prop : XML;
			var value : *;
			var type : String;
			
			if( !xml ) return;
			
			for each ( prop in vars )
				if ( ( value = xml.@[ prop.@name ] ) != undefined )
				{
					type = prop.@type;
					switch ( type )
					{
						case "Boolean":	value = ( value == "true" || value == true ); break;
					}
					this[ prop.@name ] = value;
				}
			
		}
		
		
		
		/* ---------------------------------------------------------------------
			APPLYING STYLEs
		--------------------------------------------------------------------- */
		
		/**
		 * Apply the styles into the given target.
		 * @param target	Target where styles should be applied.
		 */
		public function apply ( target : View ) : void
		{
			var propName : String;
			var propType : String;
			var propValue : *;
			var prop : XML;
			
			var skip  : Boolean;
				
			for each ( prop in vars ) {
				propName = prop.@name;
				propType = prop.@type;
				propValue = this [ propName ];
				
				
				switch ( propType ) {
					case "Number":	skip = isNaN( propValue ); break;
					default:		skip = ( propValue == undefined );
				}
				
				if ( skip )
					continue;
				else if ( isAutoApplicable( propName ) ) 
				{
					if ( propName == "z" )
					{
						target.sprite.scaleX = propValue;
						target.sprite.scaleY = propValue;
					}
					else if ( propName == "width" || propName == "height" )
						target.styleable_target[ propName ] = propValue;
					else
						target.sprite[ propName ] = propValue;
				}
			}
			
			snapit ( target );
			spaceit ( target );
			displayit ( target );
		}
		
		
		
		/* ---------------------------------------------------------------------
			ALIGNING & DISPLAYING
		--------------------------------------------------------------------- */
		
		/**
		 * Snaps the given item with its up (parent) item.
		 * @param target	Target to apply the margin + padding.
		 */
		private function snapit ( target : View ) : void
		{
			var prev : View;
			var point : Sprite;
			
			if ( absolute || target.prev == null )
				return;
			else
				prev = target.prev;
			
			while ( prev.style().display != "block" )
				if ( prev.prev is View  && !( prev.prev is FontElement ) )
					prev = prev.prev;
				else
					return;
			
			point = prev.sprite;
			
			if ( isNaN( scaleX ) && ! isNaN ( snap_z ) )
				target.sprite.scaleX = ( point.scaleX * snap_z );
			
			if ( isNaN( scaleY ) && ! isNaN ( snap_z ) )
				target.sprite.scaleY = ( point.scaleY * snap_z );
			
			if ( isNaN( x ) )
				if ( ! isNaN ( snap_x ) )
					target.sprite.x = ( point.x + ( point.width * snap_x ) );
				else
					target.sprite.x = ( point.x + point.width );
			
			if ( isNaN( y ) )
				if ( ! isNaN ( snap_y ) )
					target.sprite.y = ( point.y + ( point.height * snap_y ) );
				else
					target.sprite.y = point.y;
		}
		
		/**
		 * Applies all margins and paddings to the given item, according its up (parent) or previous item.
		 * @param target	Target to apply the margin + padding. 
		 */
		private function spaceit ( target : View ) : void
		{
			var point : StyleDAO;
			var x : Number;
			var y : Number;
			
			x = margin_left;
			y = margin_top;
			
//			if ( target.info && target.info.id && target.info.id == "center" )
//				trace ( "CURRENT: "+ target.sprite.x, target.sprite.y );
			
			if ( target.up != null && target.prev == null )
			{ 
//				if ( target.info && target.info.id && target.info.id == "center" )
//					trace ( "UP ( "+ target.up.info.id +" ): "+ target.up.style().padding_left, target.up.style().padding_top );
				
				x += target.up.style().padding_left;
				y += target.up.style().padding_top;
			}
			
			if ( !absolute && target.prev != null )
				if ( ( point = target.prev.style() ) is StyleDAO )
				{
//					if ( target.info && target.info.id && target.info.id == "center" )
//						trace ( "PREV: ( "+ target.prev.info.id + ") "+ target.up.style().margin_right, target.up.style().margin_bottom );
					
					// if ( isNaN ( snap_x ) )
						x += point.margin_right;
					
					// if ( isNaN ( snap_y ) )
						y += point.margin_bottom;
				}
			
			target.sprite.x += x;
			target.sprite.y += y;
		}
		
		/**
		 * Apply the proper display type to the given item.
		 * @param target	Target to apply the margin + padding.
		 */
		private function displayit ( target : View ) : void
		{
			target.sprite.visible = ( display == "block" && visible );
		}
		
		
		
		/* ---------------------------------------------------------------------
			RULES FOR AUTO-APPLYING STYLES
		--------------------------------------------------------------------- */
		
		/**
		 * Checks if some prop is auto-applicale.
		 * @param prop	Prop to be checked.
		 * @return	<code>true</code> if the prop is applicable, <code>false</code> otherwise.
		 */
		private final function isAutoApplicable ( prop : String ) : Boolean
		{
			return ( autoApplicableVars.indexOf( "|"+ prop ) != -1 );
		}
	}
}