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

package cocktail.utils 
{
	import flash.events.TimerEvent;	
	import flash.utils.Timer;	
	
	/**
	 * Simple pracctice class to execute functios with a delay.
	 * 
	 * @author nybras | nybras@codeine.it
	 */
	public class Timeout 
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var timer : Timer;
		private var active : Boolean;
		
		private var action : Function;
		private var args : Array;
		private var delay : uint;
		
//		private var autostart : Timer;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new Timeout instance.
		 * @param action	Action/Funtion to be executed according the given delay.
		 * @param delay	Delay ( in miliseconds ) to excute the given action. 
		 */
		public function Timeout ( action : Function, delay : uint )
		{
			this.action = action;
			this.active = true;
			
			this.timer = new Timer( this.delay = delay , 1 );
			this.timer.addEventListener( TimerEvent .TIMER_COMPLETE , this.fire );
			
//			this.autostart = new Timer( 1 , 1 );
//			this.autostart.addEventListener( TimerEvent .TIMER_COMPLETE , this.start );
		}

		
		
		/* ---------------------------------------------------------------------
			ABORT / FIRE
		--------------------------------------------------------------------- */
		
		/**
		 * Aborts the timeout execution forever! :)
		 */
		public function abort () : void
		{
			this.active = false;
			this.timer.stop();
		}
		
		/**
		 * Listens Timer.TIMERCOMPLETE and executes the cached action, passing the orginal params.
		 */
		public function fire ( event : TimerEvent = null ) : void
		{
			if ( !active ) return; 
			active = false;
			this.action.apply( this.action.prototype, this.args );
		}
		
		
		
		/* ---------------------------------------------------------------------
			TRIGGER GETTER
		--------------------------------------------------------------------- */
		
		/**
		 * Returns a shortcut to start the timer after the function is called.
		 */
		public function get trigger () : Function
		{
//			this.autostart
			return this.start; 
		}
		
		public function exec () : void
		{
			start();
		}
		
		
		/* ---------------------------------------------------------------------
			START trigger
		--------------------------------------------------------------------- */
		
		/**
		 * Keep the original params and start the timer.
		 * @param args	The original params passed to the action.
		 */
		private function start (...params) : void
		{
			if ( !active ) return;
			this.args = params;
			this.timer.start();
		}
		
		
		
	}
}
