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

package cocktail.core.data.amf 
{
	import cocktail.core.Index;
	
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;		
	/**
	 * Simple Amf class to make remoting requests.
	 * 
	 * @author nybras | nybras@codeine.it
	 */
	public class Amf extends Index 
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var conn : NetConnection;
		private var gateway : String;
		private var service : String;
		private var responder : Responder;
		
		public var result : Function;
		public var fault : Function;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new Amf instance.
		 * @param gateway	Service gateway.
		 * @param service	Service name.
		 * @param objectEncoding	Service encoding (default=AMF3).
		 */
		public function Amf ( gateway : String, service : String, objectEncoding : uint = undefined )
		{
			this.service = service;
			
			conn = new NetConnection();
			conn.objectEncoding = ( objectEncoding || ObjectEncoding.AMF3 );
			conn.connect( this.gateway = gateway );
		}
		
		/**
		 * Invokes the given method on the server.
		 * @param method	Method to be invoked.
		 * @param params	Method's params.
		 */
		public function invoke ( method : String, params : * = null ) : void
		{
			var i : String;
			
			for ( i in params )
				if ( "|undefined|null|NaN".indexOf ( "|"+ params[ i ] ) >= 0 || params[ i ] == "" )
					params[ i ] = null;
			
			responder = new Responder( proxy ( _result, result ), proxy ( _fault, fault ) );
			conn.call.apply( conn, [ ( service +"."+ method ), responder ].concat( params ) );
		}
		
		
		
		/* ---------------------------------------------------------------------
			DEFAULT RESPONDER / FAULT
		--------------------------------------------------------------------- */
		
		/**
		 * Default result callback, to handle server result and log debug messages.
		 * @param callback	App's result callback.
		 * @param result	Result from server.
		 */
		private function _result ( callback : Function, result : * ) : void
		{
			if ( callback is Function )
				callback.apply( callback.prototype, [ result ] );
			else
				log.debug( result );
		}
		
		/**
		 * Default fault callback, to handle server fault and log debug messages.
		 * @param callback	App's fault callback.
		 * @param info	Fault info message, from server.
		 */
		private function _fault ( callback : Function, info : Object ) : void
		{
			if ( callback is Function )
				callback.apply( callback.prototype, [info] );
			
			log.fatal( tree ( info ) );
		}
	}
}