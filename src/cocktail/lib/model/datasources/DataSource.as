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

package cocktail.lib.model.datasources 
{
	import cocktail.core.Index;
	import cocktail.core.connectors.RequestConnector;
	import cocktail.core.data.bind.Bind;
	import cocktail.lib.Model;
	import cocktail.utils.StringUtil;
	
	import net.digitalprimates.utils.E4XParser;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	import flash.utils.describeType;		

	/**
	 * Main cocktail DataSource class.
	 * 
	 * @author nybras | nybras@codeine.it
	 * @see IDataSource
	 * @see XmlDataSource
	 * @see HttpDataSource
	 */
	internal class DataSource extends Index
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _dispatcher : EventDispatcher;
		
		private var _xml_raw : XML;
		
		protected var _info : XML;
		protected var _binds : XMLList;
		
		protected var _model : Model;
		protected var _bind : Bind;
		protected var _request : RequestConnector;
		
		protected var _raw : *;
		
		protected var _id : String;
		protected var _locale : String;
		protected var _type : String;
		protected var _src : String;
		protected var _cache : String;
		
		
		
		/* ---------------------------------------------------------------------
			XML NODE REPRESENTATION VARS
		--------------------------------------------------------------------- */
		
		public function get id () : String {		return _id;		}
		public function get locale () : String {	return _locale;	}
		public function get type () : String {		return _type;	}
		public function get src () : String { 		return _src;	}
		public function get cache () : String { 	return _cache;	}
		
		public function set id ( value : String ) : void		{	_id = value;		}
		public function set locale ( value : String ) : void	{	_locale = value;	}
		public function set type ( value : String ) : void		{	_type = value;		}
		public function set src ( value : String ) : void		{	_src = value;		}
		public function set cache ( value : String ) : void		{	_cache = value;		}
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Boot method, acts like a constructor.
		 * @param model	Parent model.
		 * @param bind	Parent model's bind reference.
		 * @param fxml	XML datasources's node content.
		 * @param request	Models request point reference.
		 */
		public function boot ( model : Model, bind : Bind, fxml : XML, request : RequestConnector ) : void
		{
			this._dispatcher = new EventDispatcher();
			
			this._model = model;
			this._bind = bind;
			this._request = request;
			
			_info = fxml;
			
			parse();
		}
		
		
		
		/* ---------------------------------------------------------------------
			GETTERS
		--------------------------------------------------------------------- */
		
		/**
		 * Return the <code>info</code> schema.
		 * @return	The raw data.
		 */
		public function get info () : XML
		{
			return _info;
		}
		
		/**
		 * Return the <code>binds</code> eschema.
		 * @return	The raw data.
		 */
		public function get binds () : XMLList
		{
			return _binds;
		}
		
		
		
		/**
		 * Return the <code>raw</code> data.
		 * @return	The raw data.
		 */
		public function get raw () : *
		{
			return _raw;
		}
		
		/**
		 * Set the <code>raw</code> data.
		 * @param data	Raw data.
		 */
		public function set raw ( data : * ) : void	
		{
			_raw = data;
		}
		
		
		
		/* ---------------------------------------------------------------------
			PLUGGING BINDS
		--------------------------------------------------------------------- */
		
		/**
		 * Plugs all pre-defined binds.
		 * 
		 */
		protected function plug () : void
		{
			var node : XML;
			var name : String;
			var content : String;
			var bindExp : String;
			
			for each ( node in binds )
			{
				content = node.toString();
				name = node.localName() as String;
				
				for each ( bindExp in StringUtil.enclosure( content, "{", "}" ) )
					content = content.replace( bindExp, query ( StringUtil.innerb( bindExp ) ) );
				
				_bind.s( name, content );
			}
		}
		
		
		
		/* ---------------------------------------------------------------------
			RAW CONVERTIONS
		--------------------------------------------------------------------- */
		
		/**
		 * Try to convert the RAW data to XML format and return it.
		 * @return	The RAW data as XML.
		 */
		public function get rawASxml () : XML 
		{
			var bytes : ByteArray;
			
			if ( raw is XML ) return raw;
			if ( _xml_raw is XML ) return _xml_raw;
			
			( raw as URLStream ).readBytes( bytes = new ByteArray );
			_xml_raw = new XML( bytes.toString() );
			
			return _xml_raw;
		}
		
		
		
		/* ---------------------------------------------------------------------
			QUERIES
		--------------------------------------------------------------------- */
		
		/**
		 * Try to convert the RAW data to xml and performs a E4X query.
		 * @param query	The E4X formated query to be done.
		 * @return	The query result.
		 */
		public function query ( query : String, data : * = null ) : *
		{
			return E4XParser.evaluate( data || rawASxml, query );
		}
		
		
		
		/* ---------------------------------------------------------------------
			PARSING
		--------------------------------------------------------------------- */
		
		/**
		 * Parses the item's xml node based on class public getters ( see the section "XML NODE REPRESENTATION VARS" ).
		 */
		private function parse () : void
		{
			var props : XMLList;
			var prop : XML;
			
			props = describeType( this )..accessor;
			
			for each ( prop in props )
				if ( info.@[ prop.@name ] != undefined && prop != "raw" )
					this[ prop.@name ] = info.@[ prop.@name ];
			
			_binds = info.children();
		}
		
		
		
		/* ---------------------------------------------------------------------
			LISTENERS
		--------------------------------------------------------------------- */
		
		/**
		 * Dispatch the given event type.
		 * @param event	Event to be dispatched.
		 */
		protected final function dispatch ( type : String ) : void
		{
			_dispatcher.dispatchEvent( new Event( type ) );
		}

		/**
		 * Start listening for events.
		 * @param complete	Method listener for Event.COMPLETE.
		 */
		public function listen ( complete : Function ) : void
		{
			_dispatcher.addEventListener( Event.COMPLETE, complete );
		}
		
		/**
		 * Stop listening for events.
		 * @param complete	Method for Event.COMPLETE to stop listening.
		 */
		public function unlisten ( complete : Function ) : void
		{
			_dispatcher.removeEventListener( Event.COMPLETE, complete );
		}
	}
}