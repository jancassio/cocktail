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

package cocktail.core.connectors.motion
{
	import gs.TweenMax;
	import gs.events.TweenEvent;		

	/**
	 * MotionKeeper takes care of listen/unlisten features for MotionConnector.
	 * 	 * @author nybras | nybras@codeine.it
	 * @see	MotionConnector
	 * @see TweenEvent
	 */	public class MotionKeeper 
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var target : TweenMax;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new MotionKeeper instance.
		 * @param target	Target to take control.
		 */
		public function MotionKeeper ( target : TweenMax )
		{
			this.target = target;
		}
		
		
		
		/* ---------------------------------------------------------------------
			LISTENERS
		--------------------------------------------------------------------- */
		
		/**
		 * Start listening the start, progress and/or complete events according the given listeners.
		 * @param complete	Method to listen the complete event.
		 * @param progress	Method to listen the complete event.
		 * @param start	Method to listen the complete event.
		 */
		public function listen ( complete : Function, progress : Function = null, start : Function = null ) : MotionKeeper
		{
			if ( complete != null ) target.addEventListener( TweenEvent.COMPLETE , complete );
			if ( progress != null ) target.addEventListener( TweenEvent.UPDATE , progress );
			if ( start != null ) target.addEventListener( TweenEvent.START , start );
			return this;
		}
		
		/**
		 * Stops listening the start, progress and/or complete events according the given listeners.
		 * @param complete	Method to unlisten the complete event.
		 * @param progress	Method to unlisten the complete event.
		 * @param start	Method to unlisten the complete event.
		 */
		public function unlisten ( complete : Function, progress : Function = null, start : Function = null ) : MotionKeeper
		{
			if ( complete != null ) target.removeEventListener( TweenEvent.COMPLETE , complete );
			if ( progress != null ) target.removeEventListener( TweenEvent.UPDATE , progress );
			if ( start != null ) target.removeEventListener( TweenEvent.START , start );
			return this;
		}	}}