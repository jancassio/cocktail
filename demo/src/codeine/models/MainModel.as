package codeine.models 
{
	import codeine.AppModel;

	/**
	 * Handles the main Model behaviors.
	 * @author nybras | nybras@codeine.it
	 */
	public class MainModel extends AppModel
	{
		override public function after_load() : void
		{
			log.debug( "Checking InlineDataSource binds..." );
			log.debug( "song: "+ bind.g( "song" ) );
			log.debug( "year: "+ bind.g( "year" ) );
			log.debug( "duration: "+ bind.g( "duration" ) );			
			log.debug( "=====" );
			
			log.debug( "Checking XMLDataSource binds..." );
			log.debug( "artist: "+ bind.g( "artist" ) );
			log.debug( "decade: "+ bind.g( "decade" ) );
		}
	}
}
