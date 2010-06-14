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

package cocktail.lib.view.helpers.form 
{
	import cocktail.core.Index;
	import cocktail.lib.view.helpers.events.FormEvent;
	import cocktail.lib.view.helpers.interfaces.IRule;
	import cocktail.utils.Timeout;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.FocusEvent;

	/**
	 * FormItem class.
	 * @author nybras | nybras@codeine.it
	 * @see	FormHelper
	 * @see	IRule
	 * @see	cocktail.lib.view.helpers.form.rules.*
	 */
	public class FormItem extends Index 
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		public var default_message : String;
		
		public var rules : Array;
		public var last_rule : IRule;
		
		public var instance : *;
		public var getter : String;
		public var alias : String;
		public var data : *;
		
		private var _astype : Boolean;
		private var _last_status : Boolean;
		private var _dispatcher : EventDispatcher;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new form item with validation feature.
		 * @param instance	Form item instance.
		 * @param getter	Instance getter name ( it can be a getter or a method )
		 * @param alias	Item alias.
		 * @param rule	Item validation rule.
		 * @param message	Item default error message to be used for every rule that doesnt have an individual error message.
		 * @param data	Optional data you need to store to use later.
		 */
		public function FormItem ( instance : *, getter : String, alias : String, message : String = null, data : * = null )
		{
			this.instance = instance;
			this.getter = getter;
			this.alias = alias;
			this.data = data;
			
			rules = [];
			default_message = message;
			_dispatcher = new EventDispatcher ();
			
//			TODO - create the proper communication with ui components
//			if ( instance is TxtElement)
//			{
//				( ( instance as TxtElement ).field as TextField ).addEventListener( Event.CHANGE , check, false, 0, true );
//				( ( instance as TxtElement ).field as TextField ).addEventListener( FocusEvent.FOCUS_OUT , check, false, 0, true );
//			}
//			else if ( instance is Element ) 
//				( instance as View )._sprite.addEventListener( FocusEvent.FOCUS_OUT, check, false, 0, true );
			check;
		}
		
		
		
		/* ---------------------------------------------------------------------
			DESTROYING
		--------------------------------------------------------------------- */
		
		/**
		 * Detroy the form item, removing all listeners.
		 */
		public function destroy () : void
		{
			_dispatcher = new EventDispatcher();
			
//			TODO - create the proper communication with ui components
//			if ( instance is TxtElement)
//			{
//				( ( instance as TxtElement ).field as TextField ).removeEventListener( Event.CHANGE , check );
//				( ( instance as TxtElement ).field as TextField ).removeEventListener( FocusEvent.FOCUS_OUT , check );
//			}
//			else if ( instance is Element ) 
//				( instance as View )._sprite.removeEventListener( FocusEvent.FOCUS_OUT, check );
			check;
		}
		
		
		
		/* ---------------------------------------------------------------------
			ADDING rules
		--------------------------------------------------------------------- */
		
		/**
		 * Adds a new rule to the item rules stack.
		 * @param rule	Rule to be added.
		 */
		public function add_rule ( rule : IRule ) : void
		{
			rules.push ( rule );
		}
		
		
		
		/* ---------------------------------------------------------------------
			LISTENERNS to validade/invalidade
		--------------------------------------------------------------------- */
		
		/**
		 * Listens for validate / invalidate.
		 * @param validate	Listens for validate.
		 * @param invalidate	Listens for invalidate.
		 * @param astype	If <code>true</code> validate item as the user type, otherwise <code>false</code> validates only when item looses focus.
		 */
		public function listen ( validate : Function = null, invalidate : Function = null, astype : Boolean = true ) : void
		{
			if ( validate is Function ) _dispatcher.addEventListener( FormEvent.VALIDATE, validate );
			if ( invalidate is Function ) _dispatcher.addEventListener( FormEvent.INVALIDATE, invalidate );
			_astype = astype;
		}
		
		/**
		 * Listens for validate / invalidate.
		 * @param validate	Listens for validate.
		 * @param invalidate	Listens for invalidate.
		 * @param astype	If <code>true</code> validate item as the user type, otherwise <code>false</code> validates only when item looses focus.
		 */
		public function unlisten ( validate : Function = null, invalidate : Function = null, astype : Boolean = true ) : void
		{
			if ( validate is Function ) _dispatcher.removeEventListener( FormEvent.VALIDATE, validate );
			if ( invalidate is Function ) _dispatcher.removeEventListener( FormEvent.INVALIDATE, invalidate );
			_astype = astype;
		}
		
		
		
		/**
		 * Check and dispacthes listeners.
		 * @param event	Event.CHANGE | FocusEvent.FOCUS_OUT.
		 */
		private function check ( event : Event ) : void
		{
			if ( ! _astype && event.type != FocusEvent.FOCUS_OUT )
				return;
			
			new Timeout ( function( ...params ) : void { valid; }, 300 ).exec();
		}
		
		
		
		/* ---------------------------------------------------------------------
			Getters for VALIDATION, VALUE & MESSAGE
		--------------------------------------------------------------------- */
		
		/**
		 * Validate the item agains all its rules.
		 * @return	<code>true</code> if valid, <code>false</code> otherwise.
		 */
		public function get valid () : Boolean
		{
			var rule : IRule;
			
			for each ( rule in rules )
				if ( ! ( last_rule = rule ).test ( value ) )
				{
					_dispatcher.dispatchEvent( new FormEvent( FormEvent.INVALIDATE, this ) );
					return ( _last_status = false );
				}
			
			if ( _last_status !== true )
				_dispatcher.dispatchEvent( new FormEvent( FormEvent.VALIDATE, this ) );
			
			return ( _last_status = true );
		}
		
		/**
		 * First tries to read the value from a get method (instance.getter), then as a usual method (instance.getter()).
		 * @return	The instance value.
		 */
		public function get value () : *
		{
			var output : *;
			
			try {
				output = instance[ getter ];
			} catch ( e : Error ) {
				try {
					output = instance[ getter ] ();
				} catch ( e1 : Error ) {
					log.warn ( "Getter '"+ getter +"' not valid, for item with alias '" + alias + "'" );
					log.error( e1 );
				}
			}
			
			return ( output || "" );
		}
		
		/**
		 * Get the error message according the last tested rule.
		 * @return	The error message for the last tested rule.
		 */
		public function get message () : String
		{
			if ( last_rule is IRule )
				return last_rule.message;
			
			return default_message;
		}
	}
}