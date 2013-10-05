using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ArmedCards.Web.Models.Profile
{
	/// <summary>
	/// Model for viewing a user's profile
	/// </summary>
	public class Profile
	{
		/// <summary>
		/// The profile being viewed
		/// </summary>
		public Entities.User ViewedProfile { get; set; }

		/// <summary>
		/// Is my profile
		/// </summary>
		public Boolean MyProfile { get; set; }
	}
}