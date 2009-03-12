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

package cocktail.lib.view.ui.events 
{	import cocktail.lib.View;		import flash.events.EventDispatcher;	import flash.events.MouseEvent;		
	/**
	 * 	 * @author nybras | nybras@codeine.it	 */	public class UIEvent extends View 
	{
		/* ---------------------------------------------------------------------
			LISTENERS CONTROL
		--------------------------------------------------------------------- */
		
		protected var _listening : Boolean;
		protected var _dispatcher: EventDispatcher;
		protected var _listeners : *;
		
		
		public function before_init () : void
		{
			_listeners = {};
		}
		
		public function get listen(): UIEvent
		{
			_listening = true;
			return this;
		}
		
		public function get unlisten(): UIEvent
		{
			_listening = false;
			return this;
		}
		
		
		
		private function handle ( type : String, handler : Function, params : Array = [] ) : void
		{
			var stack : Array;
			var active : *;
			
			stack = ( _listeners [ type ] || _listeners [ type ] = [] );
			
			if ( _listening )
			{
				stack.push( {
					type : type,
					handler : handler,
					proxy : ( handler = proxy ( handler, params ) )
				} );
				
				_sprite.addEventListener( type, handler, false, 0, true );
			}
			else if ( stack.length )
			{
				for each ( active in stack )
				{
					if ( active[ "handler" ] == handler )
						_sprite.addEventListener( type, handler, false, 0, true );
						
						
				}
				
			}
		}
		
		
		
		
		
		
		public function rollover( handler : Function, params : Array = [] ): UIEvent
		{
			handle( MouseEvent.ROLL_OVER, handler, params );
			return this;
		}
		
		public function rollout( handler : Function, params : Array = [] ): UIEvent
		{
			handle( MouseEvent.ROLL_OVER, handler, params );
			return this;
		}
	}}