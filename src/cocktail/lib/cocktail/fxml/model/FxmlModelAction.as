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

package cocktail.lib.cocktail.fxml.model 
{	import cocktail.core.connectors.RequestConnector;
	import cocktail.core.data.bind.Bind;
	import cocktail.lib.Model;
	import cocktail.lib.cocktail.fxml.FxmlTag;
	import cocktail.lib.model.datasources.interfaces.IDataSource;
	import cocktail.utils.ArrayUtil;
	import cocktail.utils.StringUtil;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;	

	/**
	 * Fxml class for model DOM.	 * @author nybras | nybras@codeine.it	 */	public class FxmlModelAction extends FxmlTag 
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _model : Model;
		private var _bind : Bind;
		private var _request : RequestConnector;
		
		private var _structure : XML;
		protected var _name : String;
		protected var _datasources : Array;
		
		private var _dispatcher : EventDispatcher;
		private var _completed_ds_load : uint;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */		
		/**
		 * Boot & process the given FXML action structure.
		 * @param model	Model reference.
		 * @param bind	Model bind reference.
		 * @param request	Model request reference.
		 * @param structure	Model FXML action contents.
		 */
		public function boot (
			model : Model,
			bind : Bind,
			request : RequestConnector,
			structure : XML
		) : void
		{
			_model = model;
			_bind = bind;
			_request = request;
			
			_structure = structure;
			_name = structure.@name;
			_datasources = [];
			
			_dispatcher = new EventDispatcher();
			
			_parse();
		}
		
		
		
		/* ---------------------------------------------------------------------
			DESTROYING
		--------------------------------------------------------------------- */
		
		/**
		 * Destroy the action.
		 */
		public function destroy () : void
		{
			// TODO - implement method
		}
		
		
		
		/* ---------------------------------------------------------------------
			HANDLING DATASOURCES
		--------------------------------------------------------------------- */
		
		/**
		 * Parses all datasources, filtering by locale.
		 */
		private function _parse () : void
		{
			var source : XML;
			var check : Boolean;
			var ds_class : Class;
			var ds_type : String;
			var classpath : String;
			var ds : IDataSource;
			
			for each ( source in _structure )
			{
				check = source.@type == config.current_locale;
				check = check && source.@type == "*";
				check = check && source.@type == "";
				
				if ( ! check ) continue;
				
				ds_type = StringUtil.ucasef( source.@type );
				classpath = "cocktail.lib.model.datasources.$DataSource";
				ds_class = get_class( classpath.replace( "$", ds_type ) );
				
				if ( source.@type == config.current_locale || ds.locale == "*" )
				ds = new ds_class();
				ds.boot( _model , _bind, source, _request );
				
				_datasources.push( ds );
			}
		}
		
		/**
		 * Search the datasource based on the given id.
		 * @param id	Datasource ID to search for.
		 * @return	The found Datasource.
		 */
		public function datasource ( id : String ) : IDataSource
		{
			return ArrayUtil.find( _datasources, "id", id );
		}
		
		/**
		 * Get all action datasources.
		 * @return	All datasources.
		 */
		public function datasources () : Array
		{
			return _datasources;
		}
		
		
		
		/* ---------------------------------------------------------------------
			LOADING DATASOURCES
		--------------------------------------------------------------------- */
		
		/**
		 * Loads all datasources.
		 * @return	Self reference, for inline reuse.
		 */
		public function load () : FxmlModelAction
		{
			_completed_ds_load = 0;
			_load_datasources();
			
			return this;
		}
		
		/**
		 * Load each datasource, sequentially.
		 * @param event	Event.COMPLETE.
		 */
		private function _load_datasources ( event : Event = null ) : void
		{
			var ds : IDataSource;
			
			if ( _completed_ds_load == _datasources.length )
				_dispatcher.dispatchEvent( new Event ( Event.COMPLETE ) );
			else
			{
				ds = IDataSource( _datasources [ _completed_ds_load++ ] );
				ds.load().listen( _load_datasources );
			}
		}
		
		
		
		/* ---------------------------------------------------------------------
			LISTENING
		--------------------------------------------------------------------- */
		
		/**
		 * Start listening for complete event.
		 * @param complete	Complete listener.
		 */
		public function listen ( complete : Function ) : void
		{
			_dispatcher.addEventListener( Event.COMPLETE, complete );
		}
		
		/**
		 * Stop listening for complete event.
		 * @param complete	Complete listener.
		 */
		public function unlisten ( complete : Function ) : void
		{
			_dispatcher.removeEventListener( Event.COMPLETE, complete );
		}
	}}