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

package cocktail.core.connectors.request 
{
	import ch.capi.events.MassLoadEvent;
	import ch.capi.net.ILoadableFile;
	
	import cocktail.core.Index;
	import cocktail.utils.Timeout;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;	

	/**
	 * Takes care of listen/unlisten features for RequestConnector.
	 * 
	 * @author nybras | nybras@codeine.it
	 * @see MassLoadEvent
	 */
	public class RequestKeeper extends Index
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var enforcer : Timer;
		private var target : ILoadableFile;
		private var dispatcher : EventDispatcher;
		
		private var already_dispatched : Boolean;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * TODO - add documentation for all methods!
		 */
		public function RequestKeeper ( target : ILoadableFile, autoLoad : Boolean = false ) : void
		{
			this.target = target;
			
			enforcer = new Timer ( 30, 0 );
			enforcer.addEventListener( TimerEvent.TIMER, enforce_complete );
			enforcer.start();
			
			dispatcher = new EventDispatcher();
			
			this.target.addEventListener( Event.COMPLETE, loadable_complete );
			this.target.addEventListener( Event.INIT, loadable_init );
			this.target.addEventListener( ProgressEvent.PROGRESS , loadable_progress );
			this.target.addEventListener( MassLoadEvent.FILE_OPEN , loadable_start );
			this.target.addEventListener( IOErrorEvent.IO_ERROR , loadable_error );
			
			if ( autoLoad ) {
				this.target.start();
			}
		}
		
		
		
		/* ---------------------------------------------------------------------
			LISTEN / UNLISTEN
		--------------------------------------------------------------------- */
		
		/**
		 * 
		 */
		public function listen ( complete : Function, init : Function = null, progress : Function = null, start : Function = null, error : Function = null ) : void
		{
			if ( complete != null ) this.dispatcher.addEventListener( RequestEvent.COMPLETE , complete );
			if ( init != null ) this.dispatcher.addEventListener( RequestEvent.INIT, init );
			if ( progress != null ) this.dispatcher.addEventListener( RequestEvent.PROGRESS , progress );
			if ( start != null ) this.dispatcher.addEventListener( RequestEvent.START , start );
			if ( error != null ) this.dispatcher.addEventListener( RequestEvent.ERROR , error );
		}
		
		/**
		 * 
		 */
		public function unlisten ( complete : Function, init : Function = null, progress : Function = null, start : Function = null, error : Function = null ) : void
		{
			if ( complete != null ) this.dispatcher.removeEventListener( RequestEvent.COMPLETE , complete );
			if ( init != null ) this.dispatcher.removeEventListener( RequestEvent.INIT, init );
			if ( progress != null ) this.dispatcher.removeEventListener( RequestEvent.PROGRESS , progress );
			if ( start != null ) this.dispatcher.removeEventListener( RequestEvent.START , start );
			if ( error != null ) this.dispatcher.removeEventListener( RequestEvent.ERROR , error );
		}
		
		
		
		/* ---------------------------------------------------------------------
			LISTENERS
		--------------------------------------------------------------------- */
		
		/**
		 * 
		 */
		private function loadable_start ( event : MassLoadEvent ) : void
		{
			this.dispatch( RequestEvent.START );
		}

		/**
		 * 
		 */
		private function loadable_progress ( event : ProgressEvent ) : void
		{
			this.dispatch ( RequestEvent.PROGRESS );
		}
		
		/**
		 * 
		 */
		private function loadable_complete ( event : Event ) : void
		{
			if ( already_dispatched )
				return;
			
			if ( enforcer.running )
				enforcer.stop();
			
			already_dispatched = true;
			this.dispatch ( RequestEvent.COMPLETE );
		}
		
		/**
		 * 
		 */
		private function loadable_init ( event : Event ) : void
		{
			this.dispatch ( RequestEvent.INIT );
		}
		
		/**
		 * 
		 */
		private function loadable_error ( event : IOErrorEvent ) : void
		{
			log.error( event.text );
			enforcer.stop();
			this.dispatch ( RequestEvent.ERROR );
		}
		
		
		
		/**
		 * 
		 */
		private function dispatch ( type : String ) : void
		{
			this.dispatcher.dispatchEvent( new RequestEvent( type , this.target ) );
		}
		
		
		
		/* ---------------------------------------------------------------------
			ENFORCER
		--------------------------------------------------------------------- */
		
		/**
		 * Listens TimerEvent.TIMER, and try to force de "complete" event.
		 * @param event	TimerEvent.
		 */
		private function enforce_complete ( event : TimerEvent ) : void
		{
			if ( target.bytesTotal == target.bytesLoaded && target.bytesLoaded > 0 )
			{
				enforcer.stop();
				new Timeout( dispatch_enforcer, 500 ).exec();
			}
//			else
//				trace ( "total: "+ target.bytesTotal +", loaded="+ target.bytesLoaded +" -> "+ target.urlRequest.url );
		}
		
		/**
		 * Dispatch the complete event, if it has not been dispatched yet.
		 */
		private function dispatch_enforcer () : void
		{
//			trace ( "OVERRIDE: " + already_dispatched );
			loadable_complete( new Event ( Event.COMPLETE ) );
		}
		
	}
}