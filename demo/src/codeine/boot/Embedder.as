package codeine.boot 
{
	import cocktail.core.EmbederTail;
		
	/**
	 * @author shake
	 */
	class Embedder extends EmbederTail
	{
		
		public static function get embed () : Boolean
		{
			var embedded : Function;
			codeine.controllers.DatasourcesController;
			codeine.controllers.FormController;
			codeine.controllers.MainController;
			codeine.controllers.MediaController;
			codeine.models.DatasourcesModel;
			codeine.models.form.FormDAO;
			codeine.models.FormModel;
			codeine.models.MainModel;
			codeine.models.MediaModel;
			codeine.views.DatasourcesView;
			codeine.views.elements.PreloaderElement;
			codeine.views.form.SendView;
			codeine.views.FormView;
			codeine.views.main.LocalesView;
			codeine.views.main.MenuView;
			codeine.views.MainView;
			codeine.views.MediaView;
			return true;
		}
	}
	
}