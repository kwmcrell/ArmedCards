using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ArmedCards.Entities.Models.Profile
{
	/// <summary>
	/// Model for viewing a user's profile
	/// </summary>
	public class Profile
	{
		public Profile()
		{
			GameProfiles = new List<Entities.GamePlayer>();
		}

		/// <summary>
		/// The profile being viewed
		/// </summary>
		public Entities.User ViewedProfile { get; set; }

		/// <summary>
		/// Is my profile
		/// </summary>
		public Boolean MyProfile { get; set; }

		/// <summary>
		/// User's total points
		/// </summary>
		public Int64 TotalPoints { get; set; }

		/// <summary>
		/// The games the user belongs to
		/// </summary>
		public List<Entities.GamePlayer> GameProfiles { get; set; }
	}
}