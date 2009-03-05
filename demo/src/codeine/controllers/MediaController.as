package codeine.controllers 
{
	import codeine.AppController;
	
	/**
	 * @author kreigne
	 */
	public class MediaController extends AppController 
	{
		public function index_uses () : void
		{	
			uses( "Main/base", true );
		}
	}
}
