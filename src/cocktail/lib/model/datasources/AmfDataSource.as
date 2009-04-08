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

package cocktail.lib.model.datasources {
	import cocktail.core.data.amf.Amf;
	import cocktail.lib.model.datasources.DataSource;
	import cocktail.lib.model.datasources.interfaces.IDataSource;
	import cocktail.utils.StringUtil;
	
	import flash.events.Event;	

		/**	 * DataSource class for AMF.	 * 
	 * @author nybras | nybras@codeine.it
	 */
	public class AmfDataSource extends DataSource implements IDataSource	{
		/* ---------------------------------------------------------------------			LOADING		--------------------------------------------------------------------- */				private var _amf : Amf;		private var _buffer : Array;		private var _bufferData : *;
		private var _buffer_binds : XMLList;
								/* ---------------------------------------------------------------------			LOADING		--------------------------------------------------------------------- */				/**		 * Loads the datasource structure.		 * @return	A reference to this instance itself.			 */		public function load () : IDataSource		{			var method : XML;						if ( ! ( _amf is Amf ) )				_amf = new Amf( config.gateway(), src );						_buffer = new Array();						for each ( method in info.children() )				_buffer.push( method );						loadDS();						return this;		}				/**		 * Loads all datasource methods.		 */		private function loadDS () : void		{			var method : XML;			var params : *;						method = _buffer.shift();						if ( method..params.toXMLString() != "" || method..params != undefined )				if ( method..params.indexOf( "|" ) != -1 )					params = method..params.split( "|" );				else					params = method..params.toString();			else				params = null;						_amf.result = proxy( load_complete, method..binds.children() );			_amf.invoke( method.localName() as String, params );		}								/* ---------------------------------------------------------------------			QUERY		--------------------------------------------------------------------- */				/**		 * Perform the given query (simple object dot access syntax) into the server result.		 * @param q	Query to be performed.		 * @param data	Data to perform the query.		 */		public override function query ( q : String, data : * = null ) : *		{			var steps : Array;						if ( q == "RAW" )				return data;						steps = q.split( "." );						while ( steps.length )				try {					data = data[ steps.shift() ];				} catch ( e : Error ) {					log.fatal( e.message );				}						return data;		}								/* ---------------------------------------------------------------------			CACHING & PLUGGING		--------------------------------------------------------------------- */				/**		 * When method result arrives.		 * @param binds	Method binds to be plugged.		 * @param data	Result from server.		 */		private function load_complete ( binds : XMLList, data : * ) : void		{			_buffer_binds = binds;			_bufferData = data;						plug();						if ( _buffer.length )				loadDS();			else				dispatch( Event.COMPLETE );		}				/**		 * Plugs all binds.		 */		protected override function plug () : void		{			var node : XML;			var name : String;			var binds : Array;			var content : String;			var bindExp : String;						for each ( node in _buffer_binds )			{				content = node.toString();				name = node.localName().toString();				binds = StringUtil.enclosure( content, "{", "}" );								if ( content == binds[ 0 ] )					_bind.s( name, query( StringUtil.innerb( content ), _bufferData ) );				else				{					for each ( bindExp in binds )						content = content.replace( bindExp, query( StringUtil.innerb( bindExp ), _bufferData ) );										_bind.s( name, content );				}			}		}	}
}