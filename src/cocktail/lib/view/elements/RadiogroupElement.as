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

package cocktail.lib.view.elements 
{
	import cocktail.core.data.dao.ProcessDAO;
	import cocktail.lib.View;
	import cocktail.lib.view.elements.Element;

	import flash.display.Sprite;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;		

	/**
	 * @author carlos
	 */
	public class RadiogroupElement extends Element 
	{
		/* ---------------------------------------------------------------------
		VARS
		--------------------------------------------------------------------- */

		private var radios : Array;		private var radios_proxies : Array;
		private var checked_radio : RadiobuttonElement;
		private var border : Sprite;

		
		
		/* ---------------------------------------------------------------------
		RENDERING
		--------------------------------------------------------------------- */

		public override function before_render () : void
		{
			super.before_render( );
			var child : View;
			
			radios = [];
			
			for each ( child in childs( ) ) 
			{
				if( child is RadiobuttonElement ) 
				{
					radios.push( child ); 
				}
			}
			addListeners( );
		}

		public override function after_render () : void
		{
			super.after_render( );
			var radio : RadiobuttonElement;
			
			for each ( radio in radios ) 
			{
				if( radio.checked ) 
				{
					checked_radio = radio;
					return; 
				}
			}
			
			render_done( );
		}

		
		/* ---------------------------------------------------------------------
		LISTENERS & BEHAVIORS
		--------------------------------------------------------------------- */
		
		/**
		 * Add the listeners to all child buttons
		 */
		private function addListeners () : void
		{
			var radio : RadiobuttonElement;			var click : Function;
			
			radios_proxies = [];
			for each ( radio in radios ) 
			{
				radios_proxies.push( {
					item: radio, click: ( click = proxy( radioClick, radio ) )
				} );
				radio.sprite.addEventListener( MouseEvent.CLICK, click );
			}
		}

		/**
		 * Listener of the buttons childs
		 */
		private function radioClick ( selectedRadio : RadiobuttonElement, event : MouseEvent ) : void
		{
			var changeEvent : FocusEvent = new FocusEvent( FocusEvent.FOCUS_OUT );
			
			if ( checked_radio != null )
				checked_radio.checked = false;
			
			checked_radio = selectedRadio;
			checked_radio.checked = true;

			sprite.dispatchEvent( changeEvent );
		}

		
		/**
		 * Removing trash
		 */
		public function before_destroy ( dao : ProcessDAO ) : void
		{
			var item : *;
			var radio : RadiobuttonElement;			var click : Function;
			
			dao;
			for each ( item in radios_proxies )
			{
				radio = item[ "item" ];				click = item[ "click" ];
				
				radio.sprite.removeEventListener( MouseEvent.CLICK, click );
			}
		}

		/**
		 * Return the value of the selected radio.
		 * @return String the node value of the selected radio.
		 */
		public function get value () : String
		{
			return checked_radio.value;
		}

		
		
		/* ---------------------------------------------------------------------
		HIGHLIGHT
		--------------------------------------------------------------------- */
		
		/**
		 * Turns highlight on or off.
		 */
		public function highlight ( on : Boolean = true ) : void
		{
			if ( border == null ) 
			{
				border = new Sprite( );
				border.graphics.lineStyle( 1, 0xff0000 );
				border.graphics.drawRect( 0, 0, sprite.width, sprite.height );
				border.visible = false;
				sprite.addChild( border );
			}
				
			if ( on )
				border.visible = true;
			else
				border.visible = false;
		}
	}
}
