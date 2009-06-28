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

package cocktail.lib.view.helpers 
{
	import cocktail.core.Index;
	import cocktail.lib.view.helpers.form.FormItem;
	import cocktail.lib.view.helpers.form.rules.BooleanRule;
	import cocktail.lib.view.helpers.form.rules.EmailRule;
	import cocktail.lib.view.helpers.form.rules.EqualRule;
	import cocktail.lib.view.helpers.form.rules.LengthRule;
	import cocktail.lib.view.helpers.form.rules.NotNullRule;
	import cocktail.lib.view.helpers.form.rules.NumericRule;
	import cocktail.lib.view.helpers.interfaces.IRule;	

	/**
	 * Cocktail helper class for Forms.
	 * @author nybras | nybras@codeine.it
	 * @see	FormItem
	 * @see	IRule
	 * @see	cocktail.lib.view.helpers.form.rules.*
	 */
	public class FormHelper extends Helper 
	{

		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _items : Array;
		private var _invalid : FormItem;
		private var _last_item : FormItem;
		
		private var default_message : String;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new FormHelper instance.
		 * @param message	Default error message to be used for every item/rule that doesnt have an individual error message.
		 */
		public function FormHelper ( message : String = "Form invalid!" ) 
		{
			_items = [];
			default_message = message;
		}
		
		
		
		/* ---------------------------------------------------------------------
			ADDING / REMOVING / DESTROYING
		--------------------------------------------------------------------- */
		
		/**
		 * Adds a new item to the form.
		 * @param instance	Item instance.
		 * @param getter	Instance getter name ( it can be a getter or a method )
		 * @param alias	Item alias.
		 * @param rule	Item validation rule.
		 * @param message	Default item error message to be used for every rule that doesnt have an individual error message (if not informed, the form default error message will be used).
		 * @param data	Data you need to store to use later.
		 * @return	The FormHelper reference itself, for inline reuse.
		 */
		public function add ( instance : *, getter : String, alias : String, message : String = null, data : * = null ) : FormHelper
		{
			if ( has ( alias ) )
			{
				log.warn( "Another item was already added with the same alias: '"+ alias +"'" );
				return null;
			} else
				_items[ alias ] = ( _last_item = new FormItem ( instance, getter, alias, ( message || default_message ), data ) );
			
			return this;
		}
		
		/**
		 * Removes some previous added item.
		 * @param alias	Alias of the item to be removed.
		 */
		public function remove ( alias : String ) : void
		{
			if ( has ( alias ) )
			{
				( _items[ alias ] as FormItem ).destroy();
				_items[ alias ] = null;
				delete _items [ alias ];
			}
		}
		
		/**
		 * Checks if there's some item for the given alias.
		 * @param alias	Alias of the item to be checked.
		 * @return	<code>true</code> if some item is found, <code>false</code> otherwise.
		 */
		public function has ( alias : String ) : Boolean
		{
			if ( _items[ alias ] )
				return true;
			
			return false;
		}
		
		/**
		 * Destroy the form itself and all its items, removing listeners etc.
		 */
		public function destroy () : void
		{
			var item : FormItem;
			
			for each ( item in _items )
				item.destroy();
			
		}
		
		
		
		/* ---------------------------------------------------------------------
			RULES SHORTCUTs
		--------------------------------------------------------------------- */
		
		/**
		 * Adds an Email validation rule for the last added item.
		 * @param message	The error message to be used when the rule invalidates the item (if not informed, the item's default error message will be used).
		 * @return	The FormHelper reference itself, for inline reuse.
		 */
		public function email ( message : String = null ) : FormHelper
		{
			_last_item.add_rule( new EmailRule().boot( this, ( message || _last_item.message ) ) as IRule );
			return this;
		}
		
		/**
		 * Adds a Length (chars) validation rule for the last added item.
		 * @param min	Min chars need to validate.
		 * @param message	The error message to be used when the rule invalidates the item (if not informed, the item's default error message will be used).
		 * @param max	Max chars needed to validate, if not informed the max chars validation is ignored.
		 * @return	The FormHelper reference itself, for inline reuse.
		 */
		public function length ( min : uint,  message : String = null, max : uint = undefined) : FormHelper
		{
			_last_item.add_rule( new LengthRule( min, max ).boot( this, ( message || _last_item.message ) ) );
			return this;
		}
		
		/**
		 * Adds an equality validation rule for the last added item.
		 * @param alias	Alias of the item to compare with.
		 * @param message	The error message to be used when the rule invalidates the item (if not informed, the item's default error message will be used).
		 * @return	The FormHelper reference itself, for inline reuse.
		 */
		public function equal ( alias : String, message : String = null ) : FormHelper
		{
			_last_item.add_rule( new EqualRule( alias ).boot( this, ( message || _last_item.message ) ) );
			return this;
		}
		
		/**
		 * Adds a notnull validation rule for the last added item.
		 * @param message	The error message to be used when the rule invalidates the item (if not informed, the item's default error message will be used).
		 * @return	The FormHelper reference itself, for inline reuse.
		 */
		public function notnull ( message : String = null ) : FormHelper
		{
			_last_item.add_rule( new NotNullRule().boot( this, ( message || _last_item.message ) ) );
			return this;
		}
		
		/**
		 * Adds a Numberic (range) validation rule for the last added item.
		 * @param min	Min value need to validate.
		 * @param max	Max value needed to validate, if not informed the max value validation is ignored.
		 * @param message	The error message to be used when the rule invalidates the item (if not informed, the item's default error message will be used).
		 * @return	The FormHelper reference itself, for inline reuse.
		 */
		public function num ( min : uint, max : uint = undefined,  message : String = null ) : FormHelper
		{
			_last_item.add_rule( new NumericRule( min, max ).boot( this, ( message || _last_item.message ) ) );
			return this;
		}
		
		/**
		 * Adds a Boolean (true/false) validation rule for the last added item.
		 * @param value	the boolean value.
		 * @param message	The error message to be used when the rule invalidates the item (if not informed, the item's default error message will be used).
		 * @return	The FormHelper reference itself, for inline reuse.
		 */
		public function boolean ( value : Boolean = true,  message : String = null ) : FormHelper
		{
			_last_item.add_rule( new BooleanRule( value ).boot( this, ( message || _last_item.message ) ) );
			return this;
		}
		
		
		
		/* ---------------------------------------------------------------------
			LISTENERNS to validade/invalidade
		--------------------------------------------------------------------- */
		
		/**
		 * Listens for validate / invalidate.
		 * @param validate	Listens for validate.
		 * @param invalidate	Listens for invalidate.
		 * @param astype	If <code>true</code> validate item as the user type, otherwise <code>false</code> validates only when item looses focus.
		 * @return	The FormHelper reference itself, for inline reuse.
		 */
		public function listen ( validate : Function = null, invalidate : Function = null, astype : Boolean = true ) : FormHelper
		{
			_last_item.listen ( validate, invalidate, astype );
			return this;
		}
		
		/**
		 * Unlisten validate / invalidate methods.
		 * @param validate	Validate listener to be removed.
		 * @param invalidate	Invalidate listener to be removed.
		 * @return	The FormHelper reference itself, for inline reuse.
		 */
		public function unlisten ( validate : Function = null, invalidate : Function = null ) : FormHelper
		{
			_last_item.unlisten ( validate, invalidate );
			return this;
		}
		
		
		
		/* ---------------------------------------------------------------------
			ALIAS VALUES READER
		--------------------------------------------------------------------- */
		
		/**
		 * Reads the value for the given alias ( according the given alias at the "add" method ).
		 * @return	The item value according the given alias. 
		 */
		public function g ( alias : String ) : String
		{
			var value : String;
			
			try {
				value = ( _items[ alias ] as FormItem ).value;
			} catch ( e : Error ) {
				log.warn( "Error trying to read item value with the alias '"+ alias +"'. Check the errors below." ).error( e );
			}
			
			return value;
		}
		
		
		
		/* ---------------------------------------------------------------------
			GETTERS
		--------------------------------------------------------------------- */
		
		/**
		 * Gets all items and return it.
		 * @param	An array with all form items.
		 */
		public function get items () : Array
		{
			return _items;
		}
		
		/**
		 * Validates all items.
		 * @return	<code>true</code> if all items is valid, <code>false</code> otherwise. Check the "invalid" getter to get the invalid item.
		 */
		public function get valid () : Boolean
		{
			var item : FormItem;
			
			_invalid = null;
			for each ( item in items )
				if ( ! item.valid && ! _invalid )
					_invalid = item;
			
			return ( _invalid == null );
		}
		
		/**
		 * Gets the invalidated item during the last execution of the "valid" getter.
		 * @return	The last item invalidated by the "valid" getter.
		 */
		public function get invalid () : FormItem
		{
			return _invalid;
		}
	}
}