package codeine.models.form 
{
	import cocktail.core.data.dao.DAO;	

	/**
	 * Form data access object. 
	 * @author nybras | nybras@codeine.it
	 */
	public class FormDAO extends DAO 
	{
		/* ----------------------------------------------------------------------
			VARS
		---------------------------------------------------------------------- */
		
		public var name : String;
		public var email : String;
		public var select : String;
		public var radio : String;
		public var check : String;
		public var comment : String;
		
		
		
		/* ----------------------------------------------------------------------
			INITIALIZING
		---------------------------------------------------------------------- */
		
		/**
		 * Create a new FormDAO.
		 * @param name	User name.
		 * @param email	User name.
		 * @param select	User selected option.
		 * @param radio	User User selected radio.
		 * @param check	User User selected checks.
		 * @param comment	User comment.
		 */
		public function FormDAO ( name : String, email : String, select : String, radio : String, check : String, comment : String )
		{
			this.name = name;
			this.email = email;
			this.select = select;
			this.radio = radio;
			this.check = check;
			this.comment = comment;
		}
	}
}