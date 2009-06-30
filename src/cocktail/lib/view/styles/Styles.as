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

package cocktail.lib.view.styles
{
	import cocktail.lib.view.styles.gunz.StylesBullet;
	import cocktail.lib.view.styles.gunz.StylesTrigger;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;	

	/**
	 * Styles (multiple) manager.
	 * @author nybras | nybras@codeine.it
	 */
	public class Styles
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		public var trigger : StylesTrigger;
		
		private var _loading : Boolean;
		private var _loader : URLLoader;
		private	var _styles : *;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Styles manager.
		 * @param url	Url to be loaded.
		 */
		public function Styles ( url : String = null ) : void
		{
			_styles = {};
			trigger = new StylesTrigger ( this );
			
			if ( url != null )
				load ( url );
		}
		
		
		
		/* ---------------------------------------------------------------------
			DESTROYING
		--------------------------------------------------------------------- */
		
		/**
		 * Destroys all styles, even if its still loading.
		 */
		public function destroy () : void
		{
			if ( ! _loading )
				return;
			
			_loader.close();
			_loader.removeEventListener( Event.COMPLETE, _cache );
			
			_loading = false;
			_styles = null;
		}
		
		
		
		/* ---------------------------------------------------------------------
			STYLES SEARCH
		--------------------------------------------------------------------- */
		
		/**
		 * Search by the given style name.
		 * @return	The found style, parsed into object.
		 */
		public function get ( name : String ) : Style
		{
			var output : Style;
			
			try
			{
				 output = _styles[ name ];
			}
			catch ( e : Error )
			{
				output = null;
				trace ( "Warning: STYLE DOESNT EXIST!" );
			}
			
			return output;
		}
		
		
		
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		/**
		 * Load the given style url.
		 * @param url	Url to be loaded.
		 */
		public function load ( url : String ) : void
		{
			_loading = true;
			_loader = new URLLoader();
			_loader.addEventListener( Event.COMPLETE, _cache );
			_loader.load( new URLRequest( url ) );
		}
		
		/**
		 * Cached all styles parsed into objects.
		 * @param event	Event.COMPLETE.
		 */
		private function _cache ( event : Event ) : void
		{
			var raw : *;
			var name : String;
			var style : Style;
			
			raw = Fss.parse ( URLLoader( event.target ).data );
			for ( name in raw )
			{
				style = Style ( _styles[ name ] = new Style() );
				style.boot( name, raw[ name ] );
			}
			
			trigger.pull( new StylesBullet( StylesTrigger.COMPLETE ));
			
			_loader.removeEventListener( Event.COMPLETE, _cache );
		}
		
		
		
		/* ---------------------------------------------------------------------
			BULLET/TRIGGER IMPLEMENTATION ( listen/unlisten )
		--------------------------------------------------------------------- */
		
		/*
		 * THESE TWO GETTERS BELOW MUST TO BE IMPLEMENTED IN EVERY CLASS THAT
		 * WILL USE TRIGGER/BULLETS, IN ORDER TO OFFER STRICT AUTO-COMPLETE AND
		 * VALIDATION.  
		 */
		
		/**
		 * Start listening.
		 * @return	The trigger <code>UserTrigger</code> reference.
		 */
		public function get listen () : StylesTrigger
		{
			return StylesTrigger ( trigger.listen );
		}
		
		/**
		 * Stop listening.
		 * @return	The trigger <code>StylesTrigger</code> reference.
		 */
		public function get unlisten () : StylesTrigger
		{
			return StylesTrigger ( trigger.unlisten );
		}
	}
}