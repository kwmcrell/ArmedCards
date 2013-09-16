/*
* Copyright (c) 2013, Kevin McRell & Paul Miller
* All rights reserved.
* 
* Redistribution and use in source and binary forms, with or without modification, are permitted
* provided that the following conditions are met:
* 
* * Redistributions of source code must retain the above copyright notice, this list of conditions
*   and the following disclaimer.
* * Redistributions in binary form must reproduce the above copyright notice, this list of
*   conditions and the following disclaimer in the documentation and/or other materials provided
*   with the distribution.
* 
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
* IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
* FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
* CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
* DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
* DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
* WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
* WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace ArmedCards.Library.Extensions
{
    /// <summary>
    /// Class containing IList Extensions
    /// </summary>
    public static class IListExtension
    {
        /// <summary>
        /// Convert a IList to xml string
        /// </summary>
        /// <typeparam name="T">Type of elements in the list</typeparam>
		/// <param name="list">List to convert</param>
        /// <returns>XML string</returns>
        public static string ConvertCollectionToXML<T>(this IList<T> list)
        {
            XmlDocument xml = new XmlDocument();

            if (typeof(String) == typeof(T) || typeof(Int32) == typeof(T))
            {
                XmlElement root = xml.CreateElement("ids");
                xml.AppendChild(root);

                XmlElement child;

				foreach (T element in list)
                {
                    child = xml.CreateElement("id");

                    child.SetAttribute("value", element.ToString());

                    root.AppendChild(child);
                }
            }
            else
            {
                throw new ArgumentException("T must be either a String or Int32");
            }

            return xml.OuterXml;
        }

		/// <summary>
		/// Shuffles a IList of elements of type <typeparamref name="T"/>
		/// </summary>
		/// <typeparam name="T">The type of elements in the list</typeparam>
		/// <param name="list">The list of elements to shuffle</param>
		public static void Shuffle<T>(this IList<T> list)
		{
			Random rand = new Random();

			for (int i = list.Count - 1; i > 0; --i)
			{
				int j = rand.Next(i + 1);
				T temp = list[i];
				list[i] = list[j];
				list[j] = temp;
			}
		}
    }
}
