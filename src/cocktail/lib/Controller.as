package cocktail.lib 
{
	import cocktail.Cocktail;
	import cocktail.core.Index;
	import cocktail.core.request.Request;
	import cocktail.core.router.Route;	

	public class Controller extends Index
	{

		public function Controller( cocktail : Cocktail )
		{
			super( cocktail );
		}
		
		
		
		final public function run( request : Request ) : void
		{
			try_exec( this, request.route.api.action, request.route.api.params );
		}
	}
}