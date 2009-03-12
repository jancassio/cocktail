package codeine.views {	import cocktail.core.data.dao.ProcessDAO;		import codeine.AppView;		/**	 * Handles the main interface.	 * @author nybras | nybras@codeine.it	 */	public class MainLayout extends AppView 	{		/* ---------------------------------------------------------------------			RENDERING		--------------------------------------------------------------------- */				/**		 * Prepare everything before render.		 */		public function before_render () : void		{			switch ( current_process.action )			{				case "base":					child ( "body-base" )._sprite.alpha = 0;				break;								case "home":					child ( "body-home" )._sprite.alpha = 0;				break;			}		}				/**		 * Mount animation.		 */		public function after_render () : void		{			switch ( current_process.action )			{				 case "base":				 	child( "body-base" ).motion.alpha( 1, .5 ).listen( render_done );				 break;				 				 case "home":				 	child( "body-home" ).motion.alpha( 1, .5 ).listen( render_done );				 break;			}					}								/* ---------------------------------------------------------------------			DESTROYING		--------------------------------------------------------------------- */				/**		 * Unmount animation.		 * @param dao	ProcessDAO to be destroyed.		 */		public function before_destroy ( dao : ProcessDAO ) : void		{			switch ( dao.action )			{				 case "base":				 	child( "body-base" ).motion.alpha( 0, .5 ).listen( destroy_done );				 break;				 				 case "home":				 	child( "body-home" ).motion.alpha( 0, .5 ).listen( destroy_done );				 break;			}					}	}}