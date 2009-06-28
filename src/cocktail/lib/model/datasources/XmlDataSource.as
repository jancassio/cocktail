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

package cocktail.lib.model.datasources {
	import cocktail.core.connectors.request.RequestEvent;
	import cocktail.lib.model.datasources.DataSource;
	import cocktail.lib.model.datasources.interfaces.IDataSource;
	import cocktail.utils.StringUtil;
	import cocktail.utils.Timeout;
	
	import flash.events.Event;		

	/**
	 * DataSource class for XML.
	 * 
	 * @author nybras | nybras@codeine.it
	 * @see DataSource
	 * @see IDataSource
	 */
	public class XmlDataSource extends DataSource implements IDataSource
	{
		/* ---------------------------------------------------------------------
			LOADING
		--------------------------------------------------------------------- */
		
		/**
		 * Loads the data source.
		 * @return	A reference to this instance itself.
		 */
		public function load () : IDataSource
		{
			var path : String;
			
			if ( cache && raw is XML )
			{
				new Timeout( load_complete, 1 ).exec();
				return this;
			}
			
			path = src;
			if ( StringUtil.outerb( path ) != "[]" )
				path = config.path( ".xml" ) + "models/"+ path;
			else 
				path = StringUtil.innerb( path );
			
			_request.load( path, true ).listen( load_complete );
			
			return this;
		}
		
		
		
		/* ---------------------------------------------------------------------
			CACHING & PLUGGING
		--------------------------------------------------------------------- */
		
		/**
		 * Caches the loaded data into the <code>raw</code> property.
		 */
		private function load_complete ( event : RequestEvent = null ) : void
		{
			if ( event != null )
				raw = new XML( event.iLoadableFile.getData( ) );
			
			plug();
			
			_request.unlisten( load_complete );
			dispatch( Event.COMPLETE );
		}
	}
}