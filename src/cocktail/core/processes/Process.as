package cocktail.core.processes 
{
	import cocktail.core.Index;
	import cocktail.core.request.Request;
	import cocktail.lib.Controller;

	/**
	 * @author nybras
	 */
	public class Process extends Index
	{
		private var _processes : Processes;

		private var _controller : Controller;
		private var _request : Request;

		
		
		public function Process(
			processes : Processes,
			request : Request
		) 
		{
			var controller_name : String;
			
			controller_name = request.route.api.controller;
			
			_processes = processes;
			_controller = _processes._controller( controller_name );
			_request = request;
		}

		
		
		public function get listen() : Process
		{
			
			return this;
		}

		public function get unlisten() : Process
		{
			
			return this;
		}

		
		
		public function ran( handler : Function ) : Process
		{
			handler;
			return this;
		}

		public function destroyed( handler : Function ) : Process
		{
			handler;
			return this;
		}

		public function once() : Process
		{
			return this;
		}

		
		
		
		public function run() : Process
		{
			_controller.run( this );
			return this;
		}

		public function destroy() : Process
		{
			_controller.run( this );
			return this;
		}

		
		
		public function get controller() : Controller 
		{
			return _controller;
		}

		public function get request() : Request 
		{
			return _request;
		}
	}
}