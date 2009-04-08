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

package cocktail.lib.model.datasources.interfaces 
{
	import cocktail.core.connectors.RequestConnector;
	import cocktail.core.data.bind.Bind;
	import cocktail.lib.Model;	
	
	/**
	 * Interface for DataSource package.
	 * 	 * @author nybras | nybras@codeine.it
	 * @see DataSource
	 * @see XmlDataSource	 * @see HttpDataSource	 */	public interface IDataSource
	{
		function query ( query : String, src : * = null ) : *;
		
		function get info () : XML;
		function get binds () : XMLList;
		
		function get raw () : *;
		function get rawASxml () : XML;
		
		function get id () : String;
		function get locale () : String;
		function get type () : String;
		function get src () : String;
		
		function set raw ( value : * ) : void;
		function set id ( value : String ) : void;
		function set locale ( value : String ) : void;
		function set type ( value : String ) : void;
		function set src ( value : String ) : void;
		
		function boot ( model : Model, bind : Bind, item : XML, request : RequestConnector ) : void;
		function load () : IDataSource;
		
		function listen ( complete : Function ) : void
		function unlisten ( complete : Function ) : void
	}}