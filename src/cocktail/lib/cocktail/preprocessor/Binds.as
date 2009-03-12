package cocktail.lib.cocktail.preprocessor 
{	import cocktail.core.data.bind.Bind;
	import cocktail.lib.Model;
	import cocktail.lib.View;
	import cocktail.lib.cocktail.interfaces.IPreProcessor;
	import cocktail.utils.StringUtil;	

	/**
	 * Pre Processor class for {binds}.	 * @author nybras | nybras@codeine.it	 */	public class Binds implements IPreProcessor 
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _bind : Bind;
		private var _model : Model;
		private var _view : View;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new Binds instance.
		 * @param bind	Controller's Bind reference.
		 * @param model	Controller's Model reference.
		 * @param view	Controller's View reference.
		 */
		public function Binds ( bind : Bind, model : Model, view : View )
		{
			_bind = bind;
			_model = model;
			_view = view;
		}
		
		
		
		/* ---------------------------------------------------------------------
			PRE-PROCESSING
		--------------------------------------------------------------------- */
		
		/**
		 * Pre-process all binds.
		 * @param xml	The xml content to be pre-processed.
		 * @param path	The path of the xml file ( just to display clear error messages ).
		 * @return	The xml pos-processed.
		 */		public function preprocess( xml: XML, path: String ) : XML
		{			var key : String;
			var content : String;
			
			content = xml;
			
			for each ( key in StringUtil.enclosure( content, "{", "}") )
				StringUtil.replace_all( content, key, _bind.g( StringUtil.innerb( key ) ) );
			
			return new XML ( content );
		}
	}}