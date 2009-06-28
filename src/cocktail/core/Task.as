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

package cocktail.core 
{
	import cocktail.core.data.dao.TaskDAO;		

	/**
	 * Task class can ben used when you need to wait for some
	 * asynchronous and/or mutiple dependence method execution.
	 * 
	 * @author nybras | nybras@codeine.it
	 */
	public class Task extends Index
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var stack : Array;
		private var id : uint;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new Task instance.
		 */
		public function Task () : void
		{
			this.stack = new Array();
			this.id = 0;
		}
		
		
		
		/* ---------------------------------------------------------------------
			I/O HANDLERS
		--------------------------------------------------------------------- */
		
		/**
		 * Waits for the execution of all the given required methods and execute the given actions.
		 * @param methods	Methods to wait for. ( methods=["methodA", "methodB"] or methods="methodA" )
		 * @param actions	Actions to be executed after all methods execution. ( actions=callback, actions=[callbackA, callbackB] )
		 */
		public function wait ( methods : *, actions : *) : void
		{
			log.info( "wait( "+ methods +", "+ actions +" )");
			this.stack.push( new TaskDAO( methods , actions ) );	
		}
		
		/**
		 * Tells the task manager that some method has been executed.
		 * @param method	The method name that has been executed.
		 */
		public function done ( method : String ) : void
		{
			var dao : TaskDAO;
			var action : Function;
			
			var methodName : String;
			var remaining: Array;
			var fired : Array;
			
			log.info( "done( "+ method +" )");
			
			remaining = new Array();
			fired = new Array();
			
			for each ( dao in this.stack ) {
				
				for each ( methodName in dao.methods ) {
					if ( methodName === method ) {
						dao.doneCount++;
					}
				}
				
				if ( dao.doneCount == dao.methods.length ) {
					fired.push( dao );
				} else {
					remaining.push( dao );
				}
			}
			
			this.stack = remaining;
			
			for each ( dao in fired ) {
				for each ( action in dao.actions ) {
					action();
				}
			}
		}
	}
}