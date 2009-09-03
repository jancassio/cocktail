package codeine.controllers 
{
	import codeine.AppController;	

	/**
	 * Handles the main Controller behaviors.
	 * @author nybras | nybras@codeine.it
	 */
	public class MainController extends AppController 
	{
		public function index(
			param0 : String,
			param1 : String,
			param2 : String
		) : void
		{
			log.debug( "@@ INDEX" );
			log.debug( "param 0 => "+ param0 );
			log.debug( "param 1 => "+ param1 );
			log.debug( "param 2 => "+ param2 );
			log.debug( "------" );
		}
		
		public function edit(
			param0 : String,
			param1 : String
		) : void
		{
			log.debug( "@@ EDIT" );
			log.debug( "param 0 => "+ param0 );
			log.debug( "param 1 => "+ param1 );
			log.debug( "------" );
		}
		
		public function del(
			param0 : String,
			param1 : String,
			param2 : String
		) : void
		{
			log.debug( "@@ DEL" );
			log.debug( "param 0 => "+ param0 );
			log.debug( "param 1 => "+ param1 );
			log.debug( "param 2 => "+ param2 );
			log.debug( "------" );
		}
	}
}
