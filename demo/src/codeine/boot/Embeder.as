package codeine.boot 
{
	import cocktail.core.EmbederTail;
	
	import codeine.controllers.DatasourcesController;
	import codeine.controllers.FormController;
	import codeine.controllers.MainController;
	import codeine.controllers.MediaController;
	import codeine.layouts.MainLayout;
	import codeine.models.DatasourcesModel;
	import codeine.models.FormModel;
	import codeine.models.MainModel;
	import codeine.models.MediaModel;
	import codeine.views.DatasourcesView;
	import codeine.views.FormView;
	import codeine.views.MainView;
	import codeine.views.MediaView;
	import codeine.views.form.SendView;
	import codeine.views.main.LocalesView;
	import codeine.views.main.MenuView;		

	/**
	 * Embed all application classes. 
	 * @author nybras | nybras@codeine.it
	 */
	public class Embeder extends EmbederTail 
	{
		
		public function Embeder ()
		{
			/* MAIN */
			MainModel;
			MainController;
			MainLayout
				MainView;
				LocalesView;
				MenuView;
			
			/* ABOUT */
			DatasourcesController;
			DatasourcesModel;
			DatasourcesView;
			
			/* MEDIA */
			MediaController;
			MediaModel;
			MediaView;
			
			/* FORM */
			FormController;
			FormModel;
			FormView;
				SendView;
		}
	}
}